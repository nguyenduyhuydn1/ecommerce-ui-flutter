import 'package:flutter/material.dart';

import 'package:ecommerce_ui_flutter/auth/presentation/widgets/widgets.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Complete Profile",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              const CustomFormField(widgets: [
                // CustomTextField(
                //   hintText: "Enter your first name",
                // ),
                // CustomTextField(
                //   hintText: "Enter your last name",
                // ),
                // CustomTextField(
                //   hintText: "Re-enter your phone number",
                // ),
                // CustomTextField(
                //   hintText: "Re-enter your address",
                // ),
                // CustomTextField(
                //   hintText: "City",
                // ),
                // CustomTextField(
                //   hintText: "Postal code",
                //   borderBottom: false,
                // ),
              ]),
              const SizedBox(height: 70),
              CustomFilledButton(
                width: 250,
                height: 50,
                text: "Continue",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
