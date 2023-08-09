import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ecommerce_ui_flutter/auth/presentation/providers/auth_provider.dart';

class CheckAuthStatusScreen extends ConsumerWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(authProvider, (previous, next) {
      if (next.authStatus == AuthStatus.authenticated) context.go('/');
      context.go('/login');
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
