import 'package:shared_preferences/shared_preferences.dart';

class SimplePreferences {
  static SharedPreferences? _preferences;
  static const _keyHighScore = 'highscore';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setHighScore(int highScore) async =>
      await _preferences!.setInt(_keyHighScore, highScore);
  static int? getHighScore() => _preferences!.getInt(_keyHighScore);
}
