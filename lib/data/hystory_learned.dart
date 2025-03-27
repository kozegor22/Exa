import 'package:shared_preferences/shared_preferences.dart';

class HystoryLearned {
  static List<bool> hystoryLearned = List.filled(25, false);

  static Future<void> loadLearned() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < hystoryLearned.length; i++) {
      hystoryLearned[i] = prefs.getBool('learned_$i') ?? false;
    }
  }

  static Future<void> saveLearned() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < hystoryLearned.length; i++) {
      await prefs.setBool('learned_$i', hystoryLearned[i]);
    }
  }
}
