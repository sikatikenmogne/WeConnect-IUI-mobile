import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/constants/app_fonts.dart';
import 'package:we_connect_iui_mobile/src/view/components/common_text.dart';

import '../../constants/app_color.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Size buttonSize;
  final double borderCircularRadius;
  final IconData? buttonIcon;
  final VoidCallback? onPressed;
  final String fontFamily;
  final FontWeight fontWeight;
  final FontStyle fontStyle;

  const CommonButton({
    Key? key,
    required this.text,
    this.color = AppColor.black,
    this.textColor = AppColor.buttonText,
    this.buttonSize = const Size(203, 37),
    this.borderCircularRadius = 5,
    this.onPressed,
    this.buttonIcon = null,
    this.fontFamily = AppFonts.FontFamily_Syne,
    this.fontWeight = FontWeight.w400,
    this.fontStyle = FontStyle.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // background color
        minimumSize: buttonSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(borderCircularRadius)), // adjust as needed
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CommonText(
              text: text,
              fontSize: 16,
              color: textColor,
              fontFamily: fontFamily,
              fontWeight: fontWeight,
              fontStyle: fontStyle),
          if (buttonIcon != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(buttonIcon, color: this.textColor),
            )
        ],
      ),
    );
  }
}
