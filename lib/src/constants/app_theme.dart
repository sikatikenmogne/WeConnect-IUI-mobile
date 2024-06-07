import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColor.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.appBarLight,
      color: AppColor.appBarLight,
    ),
    colorScheme: ThemeData.light().colorScheme.copyWith(
          secondary: AppColor.secondary,
          error: AppColor.danger,
        ),
    scaffoldBackgroundColor: AppColor.scaffoldLight,
    indicatorColor: AppColor.warning,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.buttonLight,
    ),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: AppColor.textLight,
          displayColor: AppColor.textLight,
          fontFamily: AppFonts.FontFamily_RedHatDisplay,
        ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColor.secondary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.appBarDark,
      color: AppColor.appBarDark,
    ),
    colorScheme: ThemeData.dark().colorScheme.copyWith(
          secondary: AppColor.primary,
          error: AppColor.danger,
        ),
    scaffoldBackgroundColor: AppColor.scaffoldDark,
    indicatorColor: AppColor.warning,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.buttonDark,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: AppColor.textDark,
          displayColor: AppColor.textDark,
          fontFamily: AppFonts.FontFamily_RedHatDisplay,
        ),
  );
}
