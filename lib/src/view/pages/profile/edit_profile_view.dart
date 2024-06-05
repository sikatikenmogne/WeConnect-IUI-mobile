import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_button.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_text.dart';
import 'package:we_connect_iui_mobile/src/view/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'components/avatar.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<EditProfileView> {
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _numberController = TextEditingController();
  final _emailController = TextEditingController();

  String? _avatarUrl;
  var _loading = true;

  String dropdownValue2 = '2025';
  String dropdownValue1 = 'X';

  /// Called once a user id is received within `onAuthenticated()`
  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabaseClient.auth.currentSession!.user.id;
      final data = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      _usernameController.text = (data['username'] ?? '') as String;
      _websiteController.text = (data['website'] ?? '') as String;
      _avatarUrl = (data['avatar_url'] ?? '') as String;
    } on PostgrestException catch (error) {
      if (mounted) {
        SnackBar(
          content: CommonText(
              text: error.message,
              fontFamily: AppFonts.FontFamily_RedHatDisplay),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } catch (error) {
      if (mounted) {
        SnackBar(
          content: const CommonText(
              text: 'Unexpected error occurred',
              fontFamily: AppFonts.FontFamily_RedHatDisplay),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  /// Called when user taps `Update` button
  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
    final userName = _usernameController.text.trim();
    final website = _websiteController.text.trim();
    final user = supabaseClient.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userName,
      'website': website,
      'updated_at': DateTime.now().toIso8601String(),
    };
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
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await supabaseClient.auth.signOut();
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
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  /// Called when image has been uploaded to supabaseClient storage from within Avatar widget
  Future<void> _onUpload(String imageUrl) async {
    try {
      final userId = supabaseClient.auth.currentUser!.id;
      await supabaseClient.from('profiles').upsert({
        'id': userId,
        'avatar_url': imageUrl,
      });
      if (mounted) {
        const SnackBar(
          content: Text('Updated your profile image!'),
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
    if (!mounted) {
      return;
    }

    setState(() {
      _avatarUrl = imageUrl;
    });
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppHeader(
        title: Row(
          children: [
            Icon(Icons.arrow_back_ios),
            CommonText(
              text: AppLocalizations.of(context)!.backTextButton,
              fontFamily: AppFonts.FontFamily_RedHatDisplay,
              fontWeight: FontWeight.w700,
              fontSize: 17,
              fontStyle: FontStyle.italic,
            ),
          ],
        ),
        height: height,
        width: width,
        leading: null,
        actions: [
          CommonText(
            text: AppLocalizations.of(context)!.editProfile,
            fontFamily: AppFonts.FontFamily_RedHatDisplay,
            fontWeight: FontWeight.w700,
            fontSize: 17,
            fontStyle: FontStyle.italic,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              children: [
                Avatar(
                  imageUrl: _avatarUrl,
                  onUpload: _onUpload,
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.userName,
                    prefixIcon: Icon(Icons.person_outlined),
                    labelStyle: TextStyle(
                      fontFamily: AppFonts.FontFamily_RedHatDisplay,
                      fontWeight: FontWeight.w600,
                      color: AppColor.tertiary,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: AppFonts.FontFamily_RedHatDisplay,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColor.tertiary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.people_outlined),
                      CommonText(
                        text: AppLocalizations.of(context)!.promotion,
                        fontFamily: AppFonts.FontFamily_RedHatDisplay,
                        color: AppColor.tertiary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                      DropdownButton<String>(
                        value: dropdownValue1,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue1 = newValue!;
                          });
                        },
                        items: <String>['X', 'IP', 'FA', 'O', 'I']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: CommonText(
                              text: value,
                              fontFamily: AppFonts.FontFamily_RedHatDisplay,
                              color: AppColor.tertiary,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue2,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue2 = newValue!;
                          });
                        },
                        items: <String>['2025', '2026', '2027', '2028']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: CommonText(
                              text: value,
                              fontFamily: AppFonts.FontFamily_RedHatDisplay,
                              color: AppColor.tertiary,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // const SizedBox(height: 18),
                TextFormField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.number,
                    prefixIcon: Icon(Icons.local_phone_outlined),
                    labelStyle: TextStyle(
                      fontFamily: AppFonts.FontFamily_RedHatDisplay,
                      fontWeight: FontWeight.w600,
                      color: AppColor.tertiary,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontFamily: AppFonts.FontFamily_RedHatDisplay,
                    fontWeight: FontWeight.w600,
                    color: AppColor.tertiary,
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                    prefixIcon: Icon(Icons.email),
                    labelStyle: TextStyle(
                      fontFamily: AppFonts.FontFamily_RedHatDisplay,
                      fontWeight: FontWeight.w600,
                      color: AppColor.tertiary,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontFamily: AppFonts.FontFamily_RedHatDisplay,
                    fontWeight: FontWeight.w600,
                    color: AppColor.tertiary,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 18),
                CommonButton(
                  onPressed: _loading ? null : _updateProfile,
                  text: _loading
                      ? AppLocalizations.of(context)!.saving
                      : AppLocalizations.of(context)!.submit,
                  fontFamily: AppFonts.FontFamily_RedHatDisplay,
                  fontWeight: FontWeight.w700,
                  color: AppColor.color3,
                  fontStyle: FontStyle.italic,
                ),
                // const SizedBox(height: 18),
                // TextButton(onPressed: _signOut, child: const Text('Sign Out')),
              ],
            ),
    );
  }
}
