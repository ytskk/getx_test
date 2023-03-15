import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late final SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  Future<bool> setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  Future<bool> setInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  String getString(String key, {String defaultValue = ''}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }
}
