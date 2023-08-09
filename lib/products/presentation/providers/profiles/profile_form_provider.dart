import 'package:ecommerce_ui_flutter/auth/domain/entities/user.dart';
import 'package:ecommerce_ui_flutter/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileFormProvider =
    StateNotifierProvider.autoDispose<ProfileFormNotifier, ProfileFormState>(
        (ref) {
  final uploadProfileCallback = ref.watch(authProvider.notifier).uploadProfile;
  final shipping = ref.read(authProvider).user?.shippingAddress;

  return ProfileFormNotifier(
      uploadProfileCallback: uploadProfileCallback, shipping: shipping);
});

class ProfileFormNotifier extends StateNotifier<ProfileFormState> {
  final Function(String, String, String, String, String, String)
      uploadProfileCallback;

  final ShippingAddress? shipping;

  ProfileFormNotifier(
      {required this.uploadProfileCallback, required this.shipping})
      : super(ProfileFormState().copyWith(
          fullName: shipping?.fullName,
          address: shipping?.address,
          city: shipping?.city,
          postalCode: shipping?.postalCode,
          phone: shipping?.phone,
          country: shipping?.country,
        ));

  // loadDataShipping() {
  //   state = state.copyWith(
  //     fullName: shipping?.fullName,
  //     address: shipping?.address,
  //     city: shipping?.city,
  //     postalCode: shipping?.postalCode,
  //     phone: shipping?.phone,
  //     country: shipping?.country,
  //   );
  // }

  onFullNameChange(String value) {
    // final ShippingAddress a = ShippingAddress(
    //     fullName: '1',
    //     address: '1',
    //     city: '1',
    //     postalCode: 'postalCode',
    //     phone: ' phone',
    //     country: ' country');

    // ProfileFormState().copyWith(shipping: a);

    state = state.copyWith(fullName: value);
  }

  onAddressChange(String value) {
    state = state.copyWith(address: value);
  }

  onCityChange(String value) {
    state = state.copyWith(city: value);
  }

  onPostalCodeChange(String value) {
    state = state.copyWith(postalCode: value);
  }

  onPhoneChange(String value) {
    state = state.copyWith(phone: value);
  }

  onCountryChange(String value) {
    state = state.copyWith(country: value);
  }

  onFormSubmit(BuildContext context, VoidCallback onSuccess) async {
    // state = state.copyWith(isFormPosted: true);

    if (state.isPosting) return;
    state = state.copyWith(isPosting: true);

    await uploadProfileCallback(
      state.fullName,
      state.address,
      state.city,
      state.postalCode,
      state.phone,
      state.country,
    );

    state = state.copyWith(isPosting: false);
    onSuccess();
  }
}

class ProfileFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String fullName;
  final String address;
  final String city;
  final String postalCode;
  final String phone;
  final String country;
  // final ShippingAddress shipping;

  ProfileFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.fullName = "",
    this.address = "",
    this.city = "",
    this.postalCode = "",
    this.phone = "",
    this.country = "",
    // this.shipping = const {} as dynamic,
  });

  ProfileFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    String? fullName,
    String? address,
    String? city,
    String? postalCode,
    String? phone,
    String? country,
    // ShippingAddress? shipping,
  }) =>
      ProfileFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        fullName: fullName ?? this.fullName,
        address: address ?? this.address,
        city: city ?? this.city,
        postalCode: postalCode ?? this.postalCode,
        phone: phone ?? this.phone,
        country: country ?? this.country,
        // shipping: shipping ?? this.shipping,
      );

  @override
  String toString() {
    return '''
      ProfileFormState:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      isValid: $isValid
      fullName: $fullName
      address: $address
      city: $city
      postalCode: $postalCode
      phone: $phone
      country: $country
    ''';
  }
}
