import 'package:shared_preferences/shared_preferences.dart';

class HystoryBestAnswers {
  static List<List<String>> hystoryBestAnswers = List.filled(25, List.filled(1, "0"));

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < hystoryBestAnswers.length; i++) {
      hystoryBestAnswers[i] = prefs.getStringList('hystory_best_ans_$i') ?? ["0"];
    }
  }

  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < hystoryBestAnswers.length; i++) {
      await prefs.setStringList('hystory_best_ans_$i', hystoryBestAnswers[i]);
    }
  }
}
