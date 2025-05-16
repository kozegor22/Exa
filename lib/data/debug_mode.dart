import 'package:shared_preferences/shared_preferences.dart';

class DebugMode {
  static bool debugmode = false;

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    debugmode = prefs.getBool('debug_mode') ?? false;
  }

  static Future<void> save(bool newdebugmode) async {
    final prefs = await SharedPreferences.getInstance();
    debugmode = newdebugmode;
    await prefs.setBool('debug_mode', debugmode);
  }
}
