import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final SupabaseClient supabaseClient;

  LoginController(this.supabaseClient);

  Future<Session?> signInWithPassword(
      {required String email, required String password}) async {
    final response = await supabaseClient.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );

    if (response.user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      return response.session;
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }
}
