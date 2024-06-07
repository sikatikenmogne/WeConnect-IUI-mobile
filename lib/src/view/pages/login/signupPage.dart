import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';
import 'package:we_connect_iui_mobile/src/model/setting_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart' as UserModel;
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/pages/login/loginPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer' as developer;

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

  // Add a new variable to track the loading state
  bool _isLoading = false;

  void initState() {
    super.initState();

    // Écoutez les changements de session
    supabaseClient.auth.onAuthStateChange.listen((event) async {
      if (event == AuthChangeEvent.signedIn) {
        final userName = nameController.text.trim();
        // final website = _websiteController.text.trim();
        final user = supabaseClient.auth.currentUser;

        // Sauvegardez les informations supplémentaires de l'utilisateur
        try {
          final insertResponse = await supabaseClient.from('profiles').insert({
            'id': user!.id,
            'username': userName,
            'updated_at': DateTime.now().toIso8601String(),
          });

          await supabaseClient.from('users').insert({
            'id': user.id,
            'email': user.email,
            'firstname': userName,
            'role_id': '3',
            'created_at': DateTime.now().toIso8601String(),
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

      await supabaseClient.from('users').upsert({
        'id': updates['id'],
        'firstname': updates['username'],
        'updated_at': updates['updated_at'],
      });

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
    // Set loading state to true at the start of the signup process
    setState(() {
      _isLoading = true;
    });
  
    if (password != repeatPassword) {
      developer.log('Password verification failed', name: 'my.app');
      print('Password verification failed');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Invalid verification: the password and the repeat password should be the same')),
      );
      return null;
    }
  
    try {
      developer.log('Starting signup process', name: 'my.app');
      print('Starting signup process');
      final response =
          await supabaseClient.auth.signUp(email: email, password: password);
  
      if (response.user != null) {
        developer.log('Signup successful', name: 'my.app');
        print('Signup successful');
        final newUser = {
          "id": response.user!.id,
          "firstname": nameController.text, 
          "email": response.user!.email,
          "roleid": 3
        };

  
        await supabaseClient.from("users").insert(newUser);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up successful')),
        );
  
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        await prefs.setString('user', json.encode(newUser));
        await prefs.setString('settings', json.encode(userSettings));
        currentUser = UserModel.User.fromJson(newUser);

        return response;
      } else {
        // Sign-up was failed
        developer.log('Signup failed', name: 'my.app');
        print('Signup failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed')),
        );
      }
    } catch (e) {
      // An unexpected error occurred
      developer.log('Unexpected error: $e', name: 'my.app');
      print('Unexpected error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error occurred: $e')),
      );
    }
  
    // Set loading state to false at the end of the signup process
    setState(() {
      _isLoading = false;
    });
  
    return null;
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
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
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        )),
                  ],
                ),
              ),

              SizedBox(height: screenWidth * .2),
              // Login title
              Text(
                AppLocalizations.of(context)!.inscription,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: AppFonts.FontFamily_Syne,
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
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: AppFonts.FontFamily_Syne,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.inputLabelname,
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                          filled: true,
                          fillColor: AppColor.success,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.nameRequired;
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Email input field
                    Container(
                      //height: screenWidth * 0.1,
                      width: screenWidth * 0.87,
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: AppFonts.FontFamily_Syne,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.emailFormLabel,
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          ),
                          filled: true,
                          fillColor: AppColor.success,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.emailRequired;
                          } else if (!value.contains('@') &&
                              !value.contains('.')) {
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
                        controller: passwordController,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: AppFonts.FontFamily_Syne,
                        ),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.password,
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                          filled: true,
                          fillColor: AppColor.success,
                        ),
                        obscureText: true,
                        validator: (value) {
                          int minimalLength = 6;
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .passwordRequired;
                          } else if (value.length < minimalLength) {
                            return AppLocalizations.of(context)!
                                .passwordMinimunSizeRequired(minimalLength);
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    // Repeat password input field
                    const SizedBox(height: 20),
                    Container(
                      width: screenWidth * 0.87,
                      child: TextFormField(
                        controller: repeatPasswordController,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: AppFonts.FontFamily_Syne,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.repeatPassword,
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                          filled: true,
                          fillColor: AppColor.success,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseRepeatYourPassword;
                          } else if (value != passwordController.text) {
                            return AppLocalizations.of(context)!
                                .passwordsDoNotMatch;
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
                                if (_formKey.currentState!.validate()) {
                                  final email = emailController.text;
                                  final password = passwordController.text;
                                  final repeatPassword =
                                      repeatPasswordController.text;

                                  try {
                                    developer.log('Signup started!',
                                        name: 'my.app');
                                    print('Signup started!');

                                    var signUpResponse = await _signUp(
                                        email: email,
                                        password: password,
                                        repeatPassword: repeatPassword);

                                    if (signUpResponse != null &&
                                        signUpResponse.session != null) {
                                      final name = nameController.text.trim();
                                      final user = signUpResponse.user;

                                      final updates = {
                                        'id': user!.id,
                                        'username': name,
                                        'updated_at':
                                            DateTime.now().toIso8601String(),
                                      };

                                      developer.log('Updating profile...',
                                          name: 'my.app');
                                      print('Updating profile...');
                                      await _updateProfile(updates);

                                      // Navigate to the login page
                                      developer.log('Navigating to home...',
                                          name: 'my.app');
                                      print('Navigating to home...');
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.home);
                                    } else {
                                      developer.log('Signup failed!',
                                          name: 'my.app');
                                      print('Signup failed!');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Signup failed! Please try again.')),
                                      );
                                    }
                                  } catch (e) {
                                    developer.log('Unexpected error: $e',
                                        name: 'my.app');
                                    print('Unexpected error: $e');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Unexpected error: $e')),
                                    );
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context)
                              .primaryColor, // Set the button color
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
                                            fontSize: 15,
                                            fontFamily:
                                                AppFonts.FontFamily_Syne,
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                8), // Adjust this width as needed
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
                            AppLocalizations.of(context)!.alreadyHaveAnAccount,
                            style: TextStyle(
                              color: AppColor.tertiary,
                              fontFamily: AppFonts.FontFamily_Syne,
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
                            child: InkWell(
                              onTap: () =>
                                  Navigator.pushNamed(context, AppRoutes.login),
                              child: Text(
                                AppLocalizations.of(context)!.signin,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: AppFonts.FontFamily_Syne,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenWidth * .3)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
