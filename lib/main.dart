import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app.dart';
import 'src/controller/settings/settings_controller.dart';
import 'src/service/settings/settings_service.dart';

void main() async {
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
