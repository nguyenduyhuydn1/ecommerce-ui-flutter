import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:ecommerce_ui_flutter/config/router/app_router.dart';
import 'package:ecommerce_ui_flutter/config/theme/app_theme.dart';
import 'package:ecommerce_ui_flutter/config/constants/enviroments.dart';
import 'package:ecommerce_ui_flutter/products/presentation/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Background messages
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await NotificationsNotifier.initializeFCM();

  await Environment.initEnvironment();
  Stripe.publishableKey = Environment.stipeKeyPublic;

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}

