import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/pages/calendar/add_event.dart';
import 'package:we_connect_iui_mobile/src/view/pages/calendar/calendar.dart';
import 'package:we_connect_iui_mobile/src/view/pages/chat/chat_home_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/login/loginPage.dart';

import 'common_text.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: CommonText(
                text: "CED",
                fontSize: 18,
              ),
              accountEmail: CommonText(
                text: "ced@gmail.comn",
                fontSize: 18,
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
              decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor),
            ),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: Theme.of(context).textTheme.displayMedium!.color,
                size: 30,
              ),
              title: CommonText(
                text: "Home",
                fontSize: 16,
                alignment: TextAlign.start,
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.home);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.calendar_month,
                color: Theme.of(context).textTheme.displayMedium!.color,
              ),
              title: CommonText(
                text: "Calendar",
                fontSize: 16,
                alignment: TextAlign.start,
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
                color: Theme.of(context).textTheme.displayMedium!.color,
              ),
              title: CommonText(
                text: "Chats",
                fontSize: 16,
                alignment: TextAlign.start,
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
                color: Theme.of(context).textTheme.displayMedium!.color,
              ),
              title: CommonText(
                text: "Profile",
                fontSize: 16,
                alignment: TextAlign.start,
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.profile);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).textTheme.displayMedium!.color,
              ),
              title: CommonText(
                text: "Settings",
                fontSize: 16,
                alignment: TextAlign.start,
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.settings);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.note,
                color: Theme.of(context).textTheme.displayMedium!.color,
              ),
              title: CommonText(
                text: "About",
                fontSize: 16,
                alignment: TextAlign.start,
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.about);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).textTheme.displayMedium!.color,
              ),
              title: CommonText(
                text: "Logout",
                fontSize: 16,
                alignment: TextAlign.start,
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.signUp);
              },
            ),
          ],
        ));
  }
}
