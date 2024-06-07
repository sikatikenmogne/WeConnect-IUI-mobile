import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_button.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_text.dart';
import 'package:we_connect_iui_mobile/src/view/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:we_connect_iui_mobile/src/view/pages/profile/components/profile_button.dart';

import 'components/avatar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? _avatarUrl;
  Map<String, String>? _avatarData;
  var _loading = true;
  final _numberController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();

  /// Called when image has been uploaded to supabaseClient storage from within Avatar widget
  Future<void> _onUpload(String imageUrl) async {
    try {
      final userId = supabaseClient.auth.currentUser!.id;
      await supabaseClient.from('users').upsert({
        'id': userId,
        'profile_picture': imageUrl,
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

  /// Called once a user id is received within `onAuthenticated()`
  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabaseClient.auth.currentSession!.user.id;
      final data =
          await supabaseClient.from('users').select().eq('id', userId).single();
      _usernameController.text = (data['firstname'] ?? '') as String;
      // _websiteController.text = (data['website'] ?? '') as String;
      _avatarUrl = (data['profile_picture'] ?? '') as String;
      _avatarData = {
        'imageUrl': _avatarUrl!,
        'username': _usernameController.text,
        'promotion': "X2025",
      };
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
          // CommonText(
          //   text: AppLocalizations.of(context)!.editProfile,
          //   fontFamily: AppFonts.FontFamily_RedHatDisplay,
          //   fontWeight: FontWeight.w700,
          //   fontSize: 17,
          //   fontStyle: FontStyle.italic,
          // ),
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
                  editMode: false,
                  data: _avatarData,
                ),
                const SizedBox(height: 18),
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
                  enabled: false,
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
                  enabled: false,
                ),
                const SizedBox(height: 18),
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                ProfileButton(AppLocalizations.of(context)!.editProfile,
                    onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.editProfile);
                }),
              ],
            ),
    );
  }
}
