import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_button.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const ProfileButton(
    this.text, {
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.20;
    double height = MediaQuery.of(context).size.height * 0.05;
    return SizedBox(
      width: width,
      height: height,
      child: CommonButton(
        onPressed: onPressed,
        text: text,
        fontFamily: AppFonts.FontFamily_RedHatDisplay,
        fontWeight: FontWeight.w700,
        color: AppColor.color3,
        fontStyle: FontStyle.italic,
        borderCircularRadius: 10,
        buttonSize: Size.new(width, height),
      ),
    );
  }
}
