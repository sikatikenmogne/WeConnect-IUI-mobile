import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/view/pages/login/loginPage.dart';

import '../../../constants/app_color.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const routeName = '/sing_up';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon button
            Container(
              width: screenWidth * 0.87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColor.primary,
                        size: 30,
                      )),
                ],
              ),
            ),

            const SizedBox(height: 80),
            // Login title
            const Text(
              'Inscription',
              style: TextStyle(
                color: AppColor.primary,
                fontFamily: "Syne",
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // Signup form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name input field
                  Container(
                    //height: screenWidth * 0.1,
                    width: screenWidth * 0.87,
                    child: TextFormField(
                      controller: nameController,
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontFamily: 'Syne',
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Name',
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
                  // Email input field
                  Container(
                    //height: screenWidth * 0.1,
                    width: screenWidth * 0.87,
                    child: TextFormField(
                      controller: emailController,
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
                      controller: passwordController,
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
                  // Repeat password input field
                  const SizedBox(height: 20),
                  Container(
                    width: screenWidth * 0.87,
                    child: TextFormField(
                      controller: repeatPasswordController,
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontFamily: 'Syne',
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Repeat password',
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
                      onPressed: () async {
                        // Add your submit functionality here

                        final name = nameController.text;
                        final email = emailController.text;
                        final password = passwordController.text;
                        final repeatPassword = repeatPasswordController.text;

                        if (password != repeatPassword) {
                          // Show an error message
                          return;
                        }

                        try {
                          final response = await supabaseClient.auth.signUp(email: email, password: password);
                        
                          if (response.user != null) {
                            // There was an error during the sign-up process
                            print('Sign-up failed: ');
                          } else {
                            // Sign-up was successful
                            print('Sign-up successful');
                          }
                        } catch (e) {
                          // An unexpected error occurred
                          print('Unexpected error occurred: $e');
                        }
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
                                    fontSize: 15,
                                    fontFamily: 'Syne',
                                  ),
                                ),
                                SizedBox(
                                    width: 8), // Adjust this width as needed
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
                          "Already have an account?",
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
                                    builder: (context) => LoginPage()));
                          },
                          child: const Text(
                            "Signin",
                            style: TextStyle(
                              color: AppColor.primary,
                              fontFamily: 'Syne',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 200)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
