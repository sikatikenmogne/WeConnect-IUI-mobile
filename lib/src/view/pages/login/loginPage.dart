import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/view/pages/login/signupPage.dart';

import '../../../constants/app_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Login title
            const Text(
              'Login',
              style: TextStyle(
                color: AppColor.primary,
                fontFamily: "Syne",
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Login form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email input field
                  Container(
                    // height: screenWidth * 0.1,
                    width: screenWidth * 0.87,
                    child: TextFormField(
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontFamily: 'Syne',
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: AppColor.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColor.primary,
                        ),
                        filled: true,
                        fillColor: AppColor.success,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password input field
                  Container(
                    width: screenWidth * 0.87,
                    child: TextFormField(
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontFamily: 'Syne',
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: AppColor.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColor.primary,
                        ),
                        filled: true,
                        fillColor: AppColor.success,
                      ),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Submit button with centered text and icon at the end
                  Container(
                    width: screenWidth * 0.87,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your submit functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor:
                            AppColor.primary, // Set the button color
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Syne',
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.exit_to_app),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Signup link aligned with form fields
                  Container(
                    width: screenWidth * 0.87,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: AppColor.tertiary,
                            fontFamily: 'Syne',
                          ),
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                              color: AppColor.primary,
                              fontFamily: 'Syne',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * .05),
          ],
        ),
      ),
    );
  }
}
