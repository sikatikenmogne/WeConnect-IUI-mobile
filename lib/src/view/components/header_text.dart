import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_text.dart';

class HeaderText extends StatelessWidget {
  final String data;
  final Color? color;
  final double fontSize;
  const HeaderText(this.data,
      {Key? key, this.color, this.fontSize = 17})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonText(
        text: this.data,
        fontFamily: AppFonts.FontFamily_RedHatDisplay,
        fontSize: this.fontSize,
        color: this.color ?? Theme.of(context).textTheme.displayMedium!.color!,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic);
  }
}
