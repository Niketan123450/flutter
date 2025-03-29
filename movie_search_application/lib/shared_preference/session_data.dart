import 'package:shared_preferences/shared_preferences.dart';

class SessionData {
  static bool? isLogin;
  static String? email;
  static String? username;
  static String? address;

  static Future<void> storeSessiondata({
    required bool isLogin,
    required String email,
    required String username,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool("isLogin", isLogin);
    pref.setString("email", email);
    pref.setString("username", username);

    getSessiondata();
  }

  static Future<void> getSessiondata() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isLogin = pref.getBool("isLogin") ?? false;
    email = pref.getString("email") ?? "";
    username = pref.getString("username") ?? "";
  }
}
