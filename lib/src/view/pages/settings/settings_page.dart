import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';
import 'package:we_connect_iui_mobile/src/controller/settings/settings_controller.dart';
import 'package:we_connect_iui_mobile/src/model/setting_model.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_switch.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:we_connect_iui_mobile/src/view/components/header.dart';
import 'package:we_connect_iui_mobile/src/view/components/header_text.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.controller});

  static const routeName = '/settings';
  final SettingsController controller;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Settings _settings;
  late SupabaseClient supabaseClient;
  late GoTrueClient auth;
  late User? user;

  @override
  void initState() {
    super.initState();
    _settings = Settings();

    // supabaseClient = Supabase.instance.client;
    // auth = supabaseClient.auth;
    // user = auth.currentUser;

    // if (user == null){
    //   Navigator.pushNamed(context, AppRoutes.login);
    // }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppHeader(
        width: width,
        height: height,
        // leading: Icons.arrow_back_ios,
        leading: null,
        title: HeaderText(
          AppLocalizations.of(context)!.backTextButton,
          color: Theme.of(context).textTheme.displayMedium!.color!,
          fontSize: 22,
        ),
        titleSpacing: -width * .001,
        actions: [
          HeaderText(
            AppLocalizations.of(context)!.settingsPagetitle,
            fontSize: 22,
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(width * .08),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.languageEnglishFrench,
                      style: TextStyle(fontSize: 19)),
                  CommonSwitch(value: _settings.isEnglish, width: width)
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  DropdownButton<ThemeMode>(
                    value: widget.controller.themeMode,
                    onChanged: (ThemeMode? value) {
                      widget.controller.updateThemeMode(value);
                      switch (value) {
                        case ThemeMode.light:
                          _settings.isDarkModeEnabled = false;
                          break;
                        case ThemeMode.dark:
                          _settings.isDarkModeEnabled = true;
                          break;
                        default:
                          _settings.isDarkModeEnabled = false;
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text(
                          AppLocalizations.of(context)!.systemTheme,
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: AppFonts.FontFamily_Syne,
                            color: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .color,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(
                          AppLocalizations.of(context)!.lightTheme,
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: AppFonts.FontFamily_Syne,
                            color: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .color,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(
                          AppLocalizations.of(context)!.darkTheme,
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: AppFonts.FontFamily_Syne,
                            color: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .color,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.disablePostNotifications,
                      style: TextStyle(fontSize: 19)),
                  CommonSwitch(
                      value: _settings.isPostNotificationDisabled, width: width)
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.disableChatNotifications,
                      style: TextStyle(fontSize: 19)),
                  CommonSwitch(
                      value: _settings.isChatNotificationDisabled, width: width)
                ],
              ),
            ],
          )),
    );
  }
}
