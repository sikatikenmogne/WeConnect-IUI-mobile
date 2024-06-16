import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';

import '../../constants/app_color.dart';

class CommonText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign alignment;
  final String fontFamily;
  final FontStyle fontStyle;

  const CommonText({
    Key? key,
    required this.text,
    this.fontSize = 14.0,
    this.color,
    this.fontWeight = FontWeight.w400,
    this.alignment = TextAlign.center,
    this.fontFamily = AppFonts.FontFamily_Syne,
    this.fontStyle = FontStyle.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? Theme.of(context).textTheme.displayMedium!.color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
      ),
    );
  }
}
