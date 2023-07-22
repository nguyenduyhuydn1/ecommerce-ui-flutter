import 'package:ecommerce_ui_flutter/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
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
            const CustomFormField(widgets: [
              CustomTextField(
                hintText: "Enter your email",
              ),
              CustomTextField(
                hintText: "Enter your password",
              ),
              CustomTextField(
                hintText: "Re-enter your password",
                borderBottom: false,
              ),
            ]),
            const SizedBox(height: 70),
            CustomFilledButton(
              width: 250,
              height: 50,
              text: "Register",
              onPressed: () {},
            ),
            const SizedBox(height: 40),
            //media social
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialButton(
                  icon: 'assets/icons/google-icon.svg',
                  onPressed: () {},
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
    );
  }
}
