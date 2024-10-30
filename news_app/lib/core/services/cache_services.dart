import 'package:shared_preferences/shared_preferences.dart';

class CacheServices {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<void> setString(String key, String value) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getInt(key);
  }

  Future<void> setDouble(String key, double value) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getDouble(key);
  }

  Future<void> setStringList(String key, List<String> value) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setStringList(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getStringList(key);
  }

  Future<void> remove(String key) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.remove(key);
  }

  Future<void> clear() async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.clear();
  }
}