import 'package:flutter/material.dart';

class CustomBubble extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isCurrentUser;

  const CustomBubble({
    Key? key,
    required this.child,
    required this.color,
    required this.isCurrentUser,
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
      child: child,
    );
  }
}