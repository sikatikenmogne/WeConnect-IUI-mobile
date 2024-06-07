import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/controller/login_controller.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_switch.dart';
import 'package:we_connect_iui_mobile/src/view/components/header.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late GoTrueClient auth;
  late User? user;
  
  Future<void> _loadData() async {
    await loadUserAndSettings();
  }
  @override
  void initState(){
    super.initState(); 
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: _loadData(), 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            body: Scaffold(
              body: Center(child: CircularProgressIndicator(color: AppColor.header,),),
            )
          );
        } else if(snapshot.hasError){
          return Scaffold(
            body: Scaffold(
              body: Center(child: InkWell(
                      child: Text("Error: ${snapshot.error}"),
                      onTap: (){
                        LoginController(supabaseClient).signOut();
                        Navigator.pushNamed(context, AppRoutes.signUp);
                      }
              )),
            )
          );
        } else {
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
                      CommonSwitch(value: "isEnglish", width: width)
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Dark mode", style: TextStyle(color: AppColor.black, fontSize: 19)),
                      CommonSwitch(value: "isDarkModeEnabled", width: width)
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Disable post notifications", style: TextStyle(color: AppColor.black, fontSize: 19)),
                      CommonSwitch(value: "isPostNotificationDisabled", width: width)
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Disable chat notifications", style: TextStyle(color: AppColor.black, fontSize: 19)),
                      CommonSwitch(value: "isChatNotificationDisabled", width: width)
                    ],
                  ),              
                ],
              )
            ),
          );
        }
      });
  }
}
