import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/controller/settings/settings_controller.dart';
import 'package:we_connect_iui_mobile/src/view/pages/about_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/chat/chat_home_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/chat/chat_message_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/login/loginPage.dart';
import 'package:we_connect_iui_mobile/src/view/pages/notification/notification_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/settings/settings_page.dart';

import '../view/pages/login/signupPage.dart';
import '../view/pages/onboarding/onboarding_view.dart';

class Routes {
  static const String onboarding = '/onBoarding';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String sampleItemDetails = '/sampleItemDetails';
  static const String sampleItemList = '/sampleItemList';
  static const String chatHome = '/chat';
  static const String chatMessage = '/chat/chat_message';
  static const String about = '/about';
  static const String notification = '/notification';


  static Map<String, WidgetBuilder> getRoutes({SettingsController? settingsController}) {
  // static Map<String, WidgetBuilder> getRoutes({required SettingsController settingsController}) {
    return {
      onboarding: (context) => OnboardingView(),
      login: (context) => LoginPage(),
      signUp: (context) => SignupPage(),
      chatHome: (context) => ChatHomePage(),
      chatMessage: (context) {
        final userId = ModalRoute.of(context)!.settings.arguments as String;
        return ChatPage(userId: userId);
      },
      // settings: (context) => SettingsPage(controller: settingsController),
      about: (context) => AboutPage(),
      notification: (context) => NotificationPage(),
    };
  }
}
