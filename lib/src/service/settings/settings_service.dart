import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<ThemeMode> themeMode() async {
    final SharedPreferences prefs = await _prefs;
    return (prefs.getString('themeMode') ?? 'system') == 'light'
        ? ThemeMode.light
        : (prefs.getString('themeMode') == 'dark' ? ThemeMode.dark : ThemeMode.system);
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    final SharedPreferences prefs = await _prefs;
    String themeString;
    switch (theme) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      default:
        themeString = 'system';
    }
    await prefs.setString('themeMode', themeString);
  }
}
