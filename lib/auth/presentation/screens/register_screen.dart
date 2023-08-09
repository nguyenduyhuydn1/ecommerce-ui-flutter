import 'package:ecommerce_ui_flutter/shared/infrastructure/services/google_sign_in_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_ui_flutter/auth/presentation/providers/providers.dart';
import 'package:ecommerce_ui_flutter/auth/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPosting = ref.watch(registerFormProvider).isPosting;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Register Account",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              CustomFormField(widgets: [
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged:
                      ref.read(registerFormProvider.notifier).onEmailChange,
                  hint: "Enter your email",
                ),
                CustomTextField(
                  keyboardType: TextInputType.visiblePassword,
                  onChanged:
                      ref.read(registerFormProvider.notifier).onPasswordChanged,
                  hint: "Enter your password",
                  borderBottom: false,
                ),
                CustomTextField(
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: ref
                      .read(registerFormProvider.notifier)
                      .onConfirmPasswordChanged,
                  hint: "Confirm your password",
                  borderBottom: false,
                ),
              ]),
              const SizedBox(height: 70),
              CustomFilledButton(
                width: 250,
                height: 50,
                text: "Submit",
                onPressed: () {
                  isPosting
                      ? null
                      : ref.read(registerFormProvider.notifier).onFormSubmit();
                },
              ),
              const SizedBox(height: 40),
              //media social
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(
                    icon: 'assets/icons/google-icon.svg',
                    onPressed: () async {
                      await GoogleAuthService(
                          ref: ref,
                          context: context,
                          func: () {
                            context.push('/');
                          }).signInWithGoogle();
                    },
                  ),
                  SocialButton(
                    icon: 'assets/icons/facebook-2.svg',
                    onPressed: () {},
                  ),
                  SocialButton(
                    icon: 'assets/icons/twitter.svg',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
