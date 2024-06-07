import 'package:flutter/material.dart';

class CustomBubble extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isCurrentUser;
  final DateTime createdAt;

  const CustomBubble({
    Key? key,
    required this.child,
    required this.color,
    required this.isCurrentUser,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(isCurrentUser ? 18 : 0),
          bottomRight: Radius.circular(isCurrentUser ? 0 : 18),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          child,
          SizedBox(height: 4), // Adjust spacing between child and timestamp
          Text(
            '${createdAt.hour}:${createdAt.minute}',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}