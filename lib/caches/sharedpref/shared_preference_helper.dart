import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {

  static Future<void> initSharedPrefs() async {
    await SharedPreferences.getInstance();
  }
  Future<SharedPreferences>? _sharedPreference;
  static const String is_dark_mode = "is_dark_mode";
  static const String language_code = "language_code";

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  //Theme module
  Future<void> changeTheme(bool value) {
    return _sharedPreference!.then((prefs) {
      return prefs.setBool(is_dark_mode, value);
    });
  }

  Future<bool> get isDarkMode {
    return _sharedPreference!.then((prefs) {
      return prefs.getBool(is_dark_mode) ?? false;
    });
  }

  //Locale module
  Future<String>? get appLocale {
    return _sharedPreference?.then((prefs) {
      return prefs.getString(language_code) ?? 'en';
    });
  }

  Future<void> changeLanguage(String value) {
    return _sharedPreference!.then((prefs) {
      return prefs.setString(language_code, value);
    });
  }
}
