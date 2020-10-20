import 'package:shared_preferences/shared_preferences.dart';

 abstract class Utils {

  static Future<void> setToken(String token) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setString('token', token);
  }


}