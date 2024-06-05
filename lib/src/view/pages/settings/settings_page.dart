import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/model/setting_model.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_switch.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:we_connect_iui_mobile/src/view/components/header.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Settings _settings;
  late SupabaseClient supabaseClient;
  late GoTrueClient auth;
  late User? user;
  
  @override
  void initState(){
    super.initState();
    _settings = Settings();

    supabaseClient = Supabase.instance.client;
    auth = supabaseClient.auth;
    user = auth.currentUser;

    if (user == null){
      Navigator.pushNamed(context, AppRoutes.login);
    }

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppHeader(
        width: width, 
        height: height,
        leading: Icons.arrow_back_ios,
        title: Text("Back", style: TextStyle(color: AppColor.black),),
        titleSpacing: -width*.001,
        actions: [Text(
            AppLocalizations.of(context)!.settingsPagetitle, 
            style: TextStyle(color: AppColor.black, fontSize: 22),
          )],
      ),
      body: Container(
        color: AppColor.white,
        padding: EdgeInsets.all(width*.08),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Language: english/french", style: TextStyle(color: AppColor.black, fontSize: 19)),
                CommonSwitch(value: _settings.isEnglish, width: width)
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark mode", style: TextStyle(color: AppColor.black, fontSize: 19)),
                CommonSwitch(value: _settings.isDarkModeEnabled, width: width)
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Disable post notifications", style: TextStyle(color: AppColor.black, fontSize: 19)),
                CommonSwitch(value: _settings.isPostNotificationDisabled, width: width)
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Disable chat notifications", style: TextStyle(color: AppColor.black, fontSize: 19)),
                CommonSwitch(value: _settings.isChatNotificationDisabled, width: width)
              ],
            ),
          ],
        )
      ),
    );
  }
}
