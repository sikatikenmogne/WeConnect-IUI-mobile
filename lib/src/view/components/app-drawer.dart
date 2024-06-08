import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/pages/calendar/add_event.dart';
import 'package:we_connect_iui_mobile/src/view/pages/calendar/calendar.dart';
import 'package:we_connect_iui_mobile/src/view/pages/chat/chat_home_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/login/loginPage.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: AppColor.white,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "CED",
                style: TextStyle(
                  color: AppColor.white,
                  fontFamily: "Syne",
                  fontSize: 18,
                ),
              ),
              accountEmail: Text(
                "ced@gmail.comn",
                style: TextStyle(
                  color: AppColor.white,
                  fontFamily: "Syne",
                  fontSize: 18,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://imgv3.fotor.com/images/gallery/cartoon-character-generated-by-Fotor-ai-art-creator.jpg',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: AppColor.header),
            ),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: AppColor.black,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  color: AppColor.black,
                  fontFamily: "Syne",
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.home);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.calendar_month,
                color: AppColor.black,
              ),
              title: Text(
                "Calendar",
                style: TextStyle(
                  color: AppColor.black,
                  fontFamily: "Syne",
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Calendar()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.chat,
                color: AppColor.black,
              ),
              title: Text(
                "Chats",
                style: TextStyle(
                  color: AppColor.black,
                  fontFamily: "Syne",
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatHomePage()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.person,
                color: AppColor.black,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  color: AppColor.black,
                  fontFamily: "Syne",
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.profile);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: AppColor.black,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  color: AppColor.black,
                  fontFamily: "Syne",
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.settings);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.note,
                color: AppColor.black,
              ),
              title: Text(
                "About",
                style: TextStyle(
                  color: AppColor.black,
                  fontFamily: "Syne",
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.about);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: AppColor.black,
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                  color: AppColor.black,
                  fontFamily: "Syne",
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.signUp);
              },
            ),
          ],
        ));
  }
}
