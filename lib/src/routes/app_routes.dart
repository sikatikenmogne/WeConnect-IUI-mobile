import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/controller/settings/settings_controller.dart';
import 'package:we_connect_iui_mobile/src/service/settings/settings_service.dart';
import 'package:we_connect_iui_mobile/src/view/pages/about_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/chat/chat_home_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/chat/chat_message_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/login/loginPage.dart';
import 'package:we_connect_iui_mobile/src/view/pages/profile/edit_profile_view.dart';
import 'package:we_connect_iui_mobile/src/view/pages/profile/profile_view.dart';
import 'package:we_connect_iui_mobile/src/view/pages/sample_item/sample_item_details_view.dart';
import 'package:we_connect_iui_mobile/src/view/pages/sample_item/sample_item_list_view.dart';
import 'package:we_connect_iui_mobile/src/view/pages/settings/settings_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/settings/settings_view.dart';
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
  static const String editProfile = '/profile/edit';
  static const String settings = '/settings';
  static const String sampleItemDetails = '/sampleItemDetails';
  static const String sampleItemList = '/sampleItemList';
  static const String chatHome = '/chat';
  static const String chatMessage = '/chat/chat_message';
  static const String about = '/about';

  static Map<String, WidgetBuilder> getRoutes() {
    final settingsController = SettingsController(SettingsService());

    return {
      splashscreen: (context) => Splashscreen(),
      onboarding: (context) => OnboardingView(),
      login: (context) => LoginPage(),
      signUp: (context) => SignupPage(),
      home: (context) => SampleItemListView(),
      sampleItemDetails: (context) => SampleItemDetailsView(),
      chatHome: (context) => ChatHomePage(),
      chatMessage: (context) => ChatPage(),
      editProfile: (context) => EditProfileView(),
      settings: (context) => SettingsPage(),
      about: (context) => AboutPage(),
    };
  }
}
