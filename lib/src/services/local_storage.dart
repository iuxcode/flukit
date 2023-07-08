import 'package:shared_preferences/shared_preferences.dart';

/// Manage local storage actions and provide a persistent store for simple data.
/// Remember to call [initPrefs] in order to initialize [prefs].
class LocalStorageService {
  /// Current instance of [SharedPreferences]
  static late final SharedPreferences prefs;

  /// Loads and parses the [SharedPreferences] for this app from disk.
  static Future<SharedPreferences> loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  /// Saves a boolean [value] to persistent storage in the background.
  static void setBool(String key, bool value) async =>
      await prefs.setBool(key, value);

  /// Saves a string [value] to persistent storage in the background.
  static void setString(String key, String value) async =>
      await prefs.setString(key, value);
}
