import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/view/pages/login/loginPage.dart';
import 'package:we_connect_iui_mobile/src/view/pages/sample_item/sample_item_details_view.dart';
import 'package:we_connect_iui_mobile/src/view/pages/sample_item/sample_item_list_view.dart';
import 'package:we_connect_iui_mobile/src/view/pages/splashscreen.dart';

import '../view/pages/login/signupPage.dart';
import '../view/pages/onboarding/onboarding_view.dart';

class AppRoutes {
  static const String splashscreen = '/splashscreen';
  static const String onboarding = '/onBoarding';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String sampleItemDetails = '/sampleItemDetails';
  static const String sampleItemList = '/sampleItemList';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashscreen: (context) => Splashscreen(),
      onboarding: (context) => OnboardingView(),
      login: (context) => LoginPage(),
      signUp: (context) => SignupPage(),
      home: (context) => SampleItemListView(),
      sampleItemDetails: (context) => SampleItemDetailsView(),
    };
  }
}
