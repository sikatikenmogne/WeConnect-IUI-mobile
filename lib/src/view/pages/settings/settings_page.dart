import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/model/setting_model.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_switch.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Settings _settings;
  
  @override
  void initState(){
    super.initState();
    _settings = Settings();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsPagetitle),
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
