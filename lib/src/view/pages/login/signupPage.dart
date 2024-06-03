import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
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

  void initState() {
    super.initState();

    // Écoutez les changements de session
    supabaseClient.auth.onAuthStateChange.listen((event) async {
      if (event == AuthChangeEvent.signedIn) {
        final userName = nameController.text.trim();
        // final website = _websiteController.text.trim();
        final user = supabaseClient.auth.currentUser;

        // L'utilisateur a cliqué sur le lien d'authentification et est maintenant connecté
        // Vous pouvez maintenant continuer la séquence d'inscription

        // Sauvegardez les informations supplémentaires de l'utilisateur
        try {
          final insertResponse = await supabaseClient.from('profiles').insert({
            'id': user!.id,
            'username': userName,
            'updated_at': DateTime.now().toIso8601String(),
          });

          if (mounted) {
            const SnackBar(
              content: Text('Profile Successfully created !'),
            );
          }
        } catch (e) {
          print('Error saving user information: $e');
        }
      }
    }, onError: (error) {
      print('Error from stream: ${error.message}');
    }, onDone: () {
      print('Stream is done');
    }, cancelOnError: false);
  }

  Future<void> _updateProfile(Map<String, String> updates) async {
    try {
      await supabaseClient.from('profiles').upsert(updates);
      if (mounted) {
        const SnackBar(
          content: Text('Successfully updated profile!'),
        );
      }
    } on PostgrestException catch (error) {
      if (mounted) {
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } catch (error) {
      if (mounted) {
        SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    }
  }

  Future<AuthResponse?> _signUp(
      {required String email,
      required String password,
      required String repeatPassword}) async {
    if (password != repeatPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Invalid verification: the password and the repeat password dhould be the same')),
      );
      return null;
    }

    try {
      final response =
          await supabaseClient.auth.signUp(email: email, password: password);

      if (response.user != null) {
        print('Sign-up successful');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Sign-up successful')),
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        return response;
      } else {
        // Sign-up was failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed')),
        );

        print('Sign-up failed');
      }
    } catch (e) {
      // An unexpected error occurred
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error occurred: $e')),
      );

      print('Unexpected error occurred: $e');
    }
    return null;
  }

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
                        final email = emailController.text;
                        final password = passwordController.text;
                        final repeatPassword = repeatPasswordController.text;

                        var signUpResponse = await _signUp(
                            email: email,
                            password: password,
                            repeatPassword: repeatPassword);

                        if (signUpResponse != null && signUpResponse.session != null) {
                          final name = nameController.text.trim();
                          final user = signUpResponse.user;

                          final updates = {
                            'id': user!.id,
                            'username': name,
                            'updated_at': DateTime.now().toIso8601String(),
                          };
                          await _updateProfile(updates);

                          // Navigate to the login page
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.home);
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
