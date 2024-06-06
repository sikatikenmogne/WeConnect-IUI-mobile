import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_connect_iui_mobile/src/model/calendar_model.dart';
import 'package:we_connect_iui_mobile/src/model/chat_model.dart';
import 'package:we_connect_iui_mobile/src/model/comment_model.dart';
import 'package:we_connect_iui_mobile/src/model/post_model.dart';
import 'package:we_connect_iui_mobile/src/model/role_model.dart';
import 'dart:convert';

import 'src/app.dart';
import 'src/controller/settings/settings_controller.dart';
import 'src/service/settings/settings_service.dart';
import 'src/model/user_model.dart' as UserModel;

void main() async {
  // Ensures that the widget binding has been initialized.
  // This is required if you're running code (like plugin initialization)
  // before calling runApp().
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables from the .env file
  await dotenv.load(fileName: "assets/.env.dev");

  // Initialize the connection to Supabase using environment values.
  // 'SUPABASE_URL' is the URL of your Supabase project.
  // 'SUPABASE_ANON_KEY' is the public anon key of your Supabase project.

  // ! Comment the following line to disable the Supabase connection initialize
  await Supabase.initialize(
    url: dotenv.env[
        'SUPABASE_URL']!, // Fetch the Supabase URL from the environment variables
    anonKey: dotenv.env[
        'SUPABASE_ANON_KEY']!, // Fetch the Supabase public anon key from the environment variables
  );

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}

// Get an instance of the Supabase client
// ! Comment this line if Supabase initialization is also commented
final supabaseClient = Supabase.instance.client;
UserModel.User? currentUser;
Map<String, bool>? userSettings;
List<Comment>? commentData;
List<Post>? postData;
List<UserModel.User> userData = [];
List<Calendar>? calendarData;
List<Chat>? chatData;
List<Role> roleData = [
  Role(id: "1", name: "ADMIN"),
  Role(id: "2", name: "INSTRUCTOR"),
  Role(id: "3", name: "LEARNER")
];
Future<void> loadData() async {
  final prefs = await SharedPreferences.getInstance();
 
    // if(prefs.getString("user") != null && prefs.getString("user") != ""){
    //   print("okay");
    //   String? encodedMap = prefs.getString("user") ?? '';
    //   print("okay");
    //   Map<String, dynamic> decodedMap = json.decode(encodedMap);
    //   print("okay");
    //   currentUser = UserModel.User.fromJson(decodedMap.map((key, value) => MapEntry(key, value)));
    // } else{
    //   final user = await supabaseClient.from("users")
    //     .select()
    //     .eq("id", supabaseClient.auth.currentUser!.id)
    //     .single();
    //   currentUser = UserModel.User.fromJson(user);
    // }    

    if(prefs.getString("settings") != null){
      print("okay");
      String? encodedMap = prefs.getString("settings") ?? "No Setting";
      print("okay");
      Map<String, dynamic> decodedMap = json.decode(encodedMap);
      print("okay");
      userSettings = decodedMap.map((key, value) => MapEntry(key, value));
    } else{
      userSettings = {
        "isEnglish": true,
        "isDarkModeEnabled": false,
        "isPostNotificationDisabled": false,
        "isChatNotificationDisabled": false,
      };
    }    
}