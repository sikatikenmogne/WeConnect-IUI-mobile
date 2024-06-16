import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/routes/app_routes.dart';
import 'package:we_connect_iui_mobile/src/view/components/app_drawer.dart';
import 'package:we_connect_iui_mobile/src/view/components/app_header.dart';
import 'package:we_connect_iui_mobile/src/view/components/header_text.dart';
import 'package:we_connect_iui_mobile/src/view/pages/calendar/add_event.dart';
import 'package:we_connect_iui_mobile/src/view/components/bottom_nav.dart';
import 'package:we_connect_iui_mobile/src/view/pages/chat/chat_home_page.dart'; // Import the CustomBottomNavBar

class Calendar extends StatefulWidget {
  const Calendar({Key? key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, AppRoutes.home);
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Calendar()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatHomePage()));
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(now);
    String startTime = '09:00';
    String subject = 'Math';
    String endTime = '10:00';
    String room = 'Room 101';
    String teacher = 'Mr. Smith';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: AppDrawer(),
      appBar: AppHeader(
        title: HeaderText(
          "Calendar",
          fontSize: 25,
        ),
        height: screenHeight,
        width: screenWidth,
        // iconTheme: IconThemeData(color: AppColor.black),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: AppColor.success,
                  height: screenHeight * 0.04,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Today - $formattedDate",
                          style: TextStyle(
                            color: AppColor.mutexText,
                            fontFamily: "Syne",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: AppColor.success,
                  height: screenHeight * 0.09,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              startTime,
                              style: TextStyle(color: AppColor.mutexText),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Text(
                            subject,
                            style:
                                TextStyle(color: AppColor.black, fontSize: 25),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              endTime,
                              style: TextStyle(color: AppColor.mutexText),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Text(
                            room,
                            style: TextStyle(color: AppColor.mutexText),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              teacher,
                              style: TextStyle(color: AppColor.mutexText),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios_new,
                            color: Theme.of(context).appBarTheme.backgroundColor),
                        iconSize: 50,
                      ),
                      SizedBox(height: 20),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_ios,
                              color: Theme.of(context).appBarTheme.backgroundColor),
                          iconSize: 50),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: screenHeight * 0.04,
                  color: AppColor.success,
                  child: Row(
                    children: [
                      Text(
                        "Upcoming days ...",
                        style: TextStyle(color: AppColor.mutexText),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: screenWidth * 0.02,
            right: screenHeight * 0.02,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEventCalendar()));
              },
              icon: Icon(Icons.add_circle, color: Theme.of(context).appBarTheme.backgroundColor),
              iconSize: 50,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
