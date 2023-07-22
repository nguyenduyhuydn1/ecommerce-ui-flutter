import 'package:flutter/material.dart';

import 'package:ecommerce_ui_flutter/auth/presentation/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var temp = true;
  final List<Color> colors = [
    Colors.green,
    Colors.green[300]!,
    Colors.green[200]!,
    Colors.green[100]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: colors),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),

                        //form text field
                        const CustomFormField(widgets: [
                          CustomTextField(
                            hintText: "Email or Phone number",
                          ),
                          CustomTextField(
                            hintText: "Password",
                            borderBottom: false,
                          )
                        ]),
                        const SizedBox(height: 16),

                        // Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),

                        //Display Error
                        temp
                            ? const SizedBox(
                                height: 50,
                                child: Column(
                                  children: [
                                    CustomDisplayError(
                                      error: "error",
                                    ),
                                    CustomDisplayError(
                                      error: "Error22",
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(height: 50),

                        //button
                        CustomFilledButton(
                          width: 250,
                          height: 50,
                          text: "Login",
                          onPressed: () {
                            setState(() {
                              temp = !temp;
                            });
                          },
                        ),

                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),

                        const Text(
                          "Continue with social media",
                          style: TextStyle(color: Colors.grey),
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

                        //Register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Dont have an account?",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600]),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
