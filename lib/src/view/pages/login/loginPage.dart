import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';
import 'package:we_connect_iui_mobile/src/controller/login_controller.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/pages/login/signupPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/app_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final LoginController _loginController = LoginController(supabaseClient);

  Future<Session?> _signInWithPassword(
      {required String email, required String password}) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signin started!')),
      );

      final response = await _loginController.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        if (response?.user != null) {
          // The user is logged in
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Authentification is successful!')),
          );

          return response;
        }

        _emailController.clear();
      }
    } on AuthException catch (error) {
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
    return null;
  }

  Future<void> _signOut() async {
    try {
      await _loginController.signOut();
    } on AuthException catch (error) {
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
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    }
  }

  Future<void> performSignInAndNavigate(BuildContext context) async {
    var signInResponse = await _signInWithPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (signInResponse != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.chatHome);
    } else {
      SnackBar(
        content: const Text('Sign in failed'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    }
  }

  @override
  void initState() {
    _redirect();
    _setupAuthListener();
    super.initState();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = supabaseClient.auth.currentSession;
    if (session != null) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.chatHome);
    }
  }

  void _setupAuthListener() {
    supabaseClient.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.chatHome);
      }
    });
  }

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
                fontFamily: AppFonts.FontFamily_Syne,
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
                      controller: _emailController,
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontFamily: AppFonts.FontFamily_Syne,
                      ),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.emailFormLabel,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.emailRequired;
                        } else if (!value.contains('@')) {
                          return AppLocalizations.of(context)!
                              .validEmailRequired;
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password input field
                  Container(
                    width: screenWidth * 0.87,
                    child: TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontFamily: AppFonts.FontFamily_Syne,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context)!.passwordFormLabel,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.passwordRequired;
                        } else if (value.length < 6) {
                          return AppLocalizations.of(context)!
                              .passwordMinimunSizeRequired;
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      onPressed: _isLoading
                          ? null
                          : () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await performSignInAndNavigate(context);
                              setState(() {
                                _isLoading = false;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        foregroundColor: AppColor.white,
                        backgroundColor:
                            AppColor.primary, // Set the button color
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColor.white),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.submit,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: AppFonts.FontFamily_Syne,
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
                        Text(
                          AppLocalizations.of(context)!.donTHaveAnAccount,
                          style: TextStyle(
                            color: AppColor.tertiary,
                            fontFamily: AppFonts.FontFamily_Syne,
                          ),
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.signUp);
                          },
                          child: InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, AppRoutes.signUp),
                            child: Text(
                              AppLocalizations.of(context)!.signup,
                              style: TextStyle(
                                color: AppColor.primary,
                                fontFamily: AppFonts.FontFamily_Syne,
                              ),
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
