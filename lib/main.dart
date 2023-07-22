import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_ui_flutter/config/router/app_router.dart';
import 'package:ecommerce_ui_flutter/config/theme/app_theme.dart';
import 'package:ecommerce_ui_flutter/config/constants/enviroments.dart';

void main() async {
  await Environment.initEnvironment();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
