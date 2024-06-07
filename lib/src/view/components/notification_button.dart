import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';

class NotificationButton extends StatelessWidget {
  final int notificationCount;
  final IconData icon;
  final Function() onPressed;
  NotificationButton(
      {this.icon = Icons.notifications,
      required this.notificationCount,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(
            this.icon,
            color: Theme.of(context).textTheme.displayMedium!.color,
          ),
          onPressed: () {
            // Handle notification icon press
          },
        ),
        Positioned(
          right: 7,
          top: 7,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: AppColor.inputText,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: Text(
              '$notificationCount',
              style: TextStyle(
                color: Theme.of(context).textTheme.displayMedium!.color,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
