import 'package:shared_preferences/shared_preferences.dart';

class RussianWrited {
  static List<bool> russianWrited = List.filled(25, false);

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < russianWrited.length; i++) {
      russianWrited[i] = prefs.getBool('learned_$i') ?? false;
    }
  }

  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < russianWrited.length; i++) {
      await prefs.setBool('learned_$i', russianWrited[i]);
    }
  }
}
