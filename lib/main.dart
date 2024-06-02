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
    url:
        'https://yojnxscjecnlltwblvrn.supabase.co', // Fetch the Supabase URL from the environment variables
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlvam54c2NqZWNubGx0d2JsdnJuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY4ODg1NDUsImV4cCI6MjAzMjQ2NDU0NX0.zH1CZLJPZ-HLO768Vis_8VFgDMmKbpkglVBCYHUcgP0', // Fetch the Supabase public anon key from the environment variables
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
