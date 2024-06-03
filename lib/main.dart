import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_connect_iui_mobile/firebase_options.dart';

import 'src/app.dart';
import 'src/controller/settings/settings_controller.dart';
import 'src/service/settings/settings_service.dart';

void main() async {
  // Load environment variables from the .env file
  await dotenv.load(fileName: ".env.dev");

  // Initialize Firebase for the application.
  // The 'options' parameter specifies the configuration, which is set to the default options for the current platform.

  // ! Uncomment the following line to initialize Firebase connection
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // Initialize the connection to Supabase using environment values.
  // 'SUPABASE_URL' is the URL of your Supabase project.
  // 'SUPABASE_ANON_KEY' is the public anon key of your Supabase project.

  // ! Uncomment the following line to initialize Supabase connection
  // await Supabase.initialize(
  //   url: dotenv.env['SUPABASE_URL']!, // Fetch the Supabase URL from the environment variables
  //   anonKey: dotenv.env['SUPABASE_ANON_KEY']!, // Fetch the Supabase public anon key from the environment variables
  // );

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
  // runApp(ChatHomePage());
}

// Get an instance of the Supabase client
// ! Uncomment this line after initializing Supabase
// final supabase = Supabase.instance.client;