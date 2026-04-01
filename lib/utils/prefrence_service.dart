import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static SharedPreferences? _prefs;

  /// Initialize once (call in main)
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save User ID
  static Future setUserId(String userId) async {
    await _prefs?.setString('user_id', userId);
  }

  /// Save User ID
  static Future setBool(String boolVar, bool value) async {
    await _prefs?.setBool('boolVar', value);
  }

  /// Save User ID
  static bool? getBool(String boolVar) {
    return _prefs?.getBool(boolVar);
  }

  /// Get User ID
  static String? getUserId() {
    return _prefs?.getString('user_id');
  }

  /// Remove User ID (logout)
  static Future removeUserId() async {
    await _prefs?.remove('user_id');
  }

  /// Clear all data
  static Future clearAll() async {
    await _prefs?.clear();
  }
}