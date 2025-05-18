import 'package:shared_preferences/shared_preferences.dart';

class FirstTime {
  static bool firstTime = true;

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    firstTime = prefs.getBool('first_time') ?? true;
  }

  static Future<void> save(bool newfirstTime) async {
    final prefs = await SharedPreferences.getInstance();
    firstTime = newfirstTime;
    await prefs.setBool('first_time', firstTime);
  }
}
