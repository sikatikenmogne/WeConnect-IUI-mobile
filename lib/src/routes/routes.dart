import 'package:flutter/material.dart';
import 'package:we_connect_iui_mobile/src/view/pages/chat/chat_home_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/chat/chat_message_page.dart';
import 'package:we_connect_iui_mobile/src/view/pages/login/loginPage.dart';

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


  static Map<String, WidgetBuilder> getRoutes() {
    return {
      onboarding: (context) => OnboardingView(),
      login: (context) => LoginPage(),
      signUp: (context) => SignupPage(),
      chatHome: (context) => ChatHomePage(),
      chatMessage: (context) {
        // final userId = ModalRoute.of(context)!.settings.arguments as String;
        // return ChatPage(userId: userId);
        return ChatPage();
      }
    };
  }
}
