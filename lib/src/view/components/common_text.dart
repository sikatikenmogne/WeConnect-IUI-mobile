import 'package:flutter/material.dart';

import '../../constants/app_color.dart';

class CommonText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const CommonText({
    Key? key,
    required this.text,
    this.fontSize = 14.0,
    this.color = AppColor.black,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontFamily: 'Syne',
      ),
    );
  }
}
