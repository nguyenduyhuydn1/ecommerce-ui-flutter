import 'package:dio/dio.dart';
import 'package:ecommerce_ui_flutter/config/constants/enviroments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  late final Dio dio;

  StripeService()
      : dio = Dio(
          BaseOptions(headers: {
            'Authorization': 'Bearer ${Environment.stipeKeySecret}',
            'Content-Type': 'application/x-www-form-urlencoded',
          }),
        );

  Future createPaymentIntent(price) async {
    try {
      Map<String, dynamic> body = {
        "amount": price ~/ 20000 * 100,
        "currency": 'USD',
      };
      final res = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
      );
      return res.data;
    } catch (e) {
      return Exception(e.toString());
    }
  }

  Future<bool> makePayment(price, name) async {
    try {
      final paymentIntent = await createPaymentIntent(price);

      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: 'US',
        currencyCode: 'USD',
        testEnv: true,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: name,
          googlePay: gpay,
        ),
      );

      final a = await Stripe.instance.presentPaymentSheet().then((value) {
        return true;
      });
      return a;
    } catch (e) {
      Exception(e.toString());
      return false;
    }
  }
}
