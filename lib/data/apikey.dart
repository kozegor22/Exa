import 'package:shared_preferences/shared_preferences.dart';

class ApiKey {
  static String apiKey = '';

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    apiKey = prefs.getString('api_key') ?? '';
  }

  static Future<void> save(String newApiKey) async {
    final prefs = await SharedPreferences.getInstance();
    apiKey = newApiKey;
    await prefs.setString('api_key', apiKey);
  }
}
