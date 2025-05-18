import 'package:shared_preferences/shared_preferences.dart';

class HystoryStatistics {
  static List<int> hystoryStats = List.filled(25, -1);

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < hystoryStats.length; i++) {
      hystoryStats[i] = prefs.getInt('hystory_stats_$i') ?? -1;
    }
  }

  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < hystoryStats.length; i++) {
      await prefs.setInt('hystory_stats_$i', hystoryStats[i]);
    }
  }
}
