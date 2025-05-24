import 'package:shared_preferences/shared_preferences.dart';

class HystoryLastAnswers {
  static List<List<String>> feedbacks = List.filled(2, List.filled(1, ""));
  static List<int> scores = List.filled(2, -1);
  static List<int> ticketIds = List.filled(2, -1);
  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < feedbacks.length; i++) {
      feedbacks[i] =
          prefs.getStringList('hystory_last_ans_feedback_$i') ?? [""];
      scores[i] = prefs.getInt('hystory_last_ans_score_$i') ?? -1;
      ticketIds[i] = prefs.getInt('hystory_last_ans_id_$i') ?? -1;
    }
  }

  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < feedbacks.length; i++) {
      await prefs.setStringList('hystory_last_ans_feedback_$i', feedbacks[i]);
      await prefs.setInt('hystory_last_ans_score_$i', scores[i]);
      await prefs.setInt('hystory_last_ans_id_$i', ticketIds[i]);
    }
  }
}
