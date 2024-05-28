import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:we_connect_iui_mobile/firebase_options.dart';

import 'src/app.dart';
import 'src/controller/settings_controller.dart';
import 'src/service/settings_service.dart';

void main() async {
  // Load environment variables from the .env file
  await dotenv.load(fileName: ".env");

  // Initialize Firebase for the application.
  // The 'options' parameter specifies the configuration, which is set to the default options for the current platform.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
