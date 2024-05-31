import 'package:flutter/material.dart';

import '../../constants/app_color.dart';

class CommonText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign alignment;

  const CommonText({
    Key? key,
    required this.text,
    this.fontSize = 14.0,
    this.color = AppColor.black,
    this.fontWeight = FontWeight.w400,
    this.alignment = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontFamily: 'Syne',
      ),
    );
  }
}
