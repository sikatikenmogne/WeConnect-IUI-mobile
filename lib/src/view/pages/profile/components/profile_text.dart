import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_text.dart';

class ProfileText extends StatelessWidget {
  final String data;
  final Color color;
  const ProfileText(this.data, {Key? key, this.color = AppColor.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonText(
        text: this.data,
        fontFamily: AppFonts.FontFamily_RedHatDisplay,
        fontSize: 17,
        color: this.color,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic);
  }
}
