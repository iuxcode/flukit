import 'package:shared_preferences/shared_preferences.dart';

/// Manage local storage actions and provide a persistent store for simple data with `shared_preferences`.
/// Remember to call [loadPrefs] in order to load and parse the [SharedPreferences] for this app from disk..
///
/// Example:
///
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   /// load and parse the [SharedPreferences] for this app from disk
///   LocalStorageService.loadPrefs();
/// }
///
/// LocalStorageService.setBool("something", true); // Saves a boolean [value] to persistent storage in the background.
///
/// /// Retreive value from prefs
/// final something = LocalStorageService.prefs.getBool("something");
/// ```
class FluStorage {
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

  /// Saves a integer [value] to persistent storage in the background.
  static void setInt(String key, int value) async =>
      await prefs.setInt(key, value);
}
