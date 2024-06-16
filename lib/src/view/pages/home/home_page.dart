import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/components/app_drawer.dart';
import 'package:we_connect_iui_mobile/src/view/components/bottom_nav.dart';
import 'package:we_connect_iui_mobile/src/view/components/app_header.dart';
import 'package:we_connect_iui_mobile/src/view/components/header_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:we_connect_iui_mobile/src/view/components/notification_button.dart';
import 'package:we_connect_iui_mobile/src/view/pages/home/components/feed_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _pageController = PageController();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppHeader(
        width: width,
        height: height,
        title: HeaderText(
          "Home",
          fontSize: 25,
        ),
        titleSpacing: width * .05,
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedPage(),
          Center(child: Text('Calendar Page')),
          Center(child: Text('Chat Page')),
          Center(child: Text('Profile Page')),
          // Add more pages as needed
        ],
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Theme.of(context)
          .primaryColor, // Use the primary color of the current theme for the selected item
      unselectedItemColor: Theme.of(context)
          .unselectedWidgetColor, // Use the unselected widget color of the current theme for the unselected items
      showUnselectedLabels: true, // Show labels for unselected items
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined,
              color: Theme.of(context).textTheme.displayMedium!.color,
              size: 40), // Increase the size of the icon
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today,
              color: Theme.of(context).textTheme.displayMedium!.color,
              size: 30), // Increase the size of the icon
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined,
              color: Theme.of(context).textTheme.displayMedium!.color,
              size: 30), // Increase the size of the icon
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined,
              color: Theme.of(context).textTheme.displayMedium!.color,
              size: 30), // Increase the size of the icon
          label: 'Profile',
        ),
        // Add more items as needed
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRoutes.home);
            break;
          case 1:
            Navigator.pushNamed(context, AppRoutes.calendar);
            break;
          case 2:
            Navigator.pushNamed(context, AppRoutes.chatHome);
            break;
          case 3:
            Navigator.pushNamed(context, AppRoutes.profile);
            break;
          // Add more cases as needed
        }
      },
    );
  }
}
