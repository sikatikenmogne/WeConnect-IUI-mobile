import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/view/components/header.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        leading: Icons.arrow_back,
        title: Text('Notifications', style: TextStyle(color: AppColor.black)),
      ),
      // appBar: AppBar(
      //   backgroundColor: AppColor.header,
      //   title: Text('Notifications', style: TextStyle(color: AppColor.black)),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ),
      body: NotificationList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.header,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Calendar has been updated',
      description: 'Ethical hacking: room-B2S3',
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    NotificationItem(
      title: 'Calendar has been updated',
      description: 'Ethical hacking: instructor-Pere Peter',
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    NotificationItem(
      title: 'Jordan TCHOUNGA (X2025) posted',
      description: 'Yo, ça dit quoi?',
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NotificationTile(notification: notifications[index]);
      },
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final DateTime date;

  NotificationItem({
    required this.title,
    required this.description,
    required this.date,
  });
}

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        child: Text(
          'N',
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(notification.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.description,
            style: TextStyle(color: Colors.teal),
          ),
          Text(
            DateFormat('dd MMM').format(notification.date),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      isThreeLine: true,
    );
  }
}
