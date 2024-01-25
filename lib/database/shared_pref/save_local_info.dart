import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance =
  SharedPreferencesService._internal();

  factory SharedPreferencesService() => _instance;

  SharedPreferences? _prefs;

  SharedPreferencesService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> doesKeyExist(String key) async{
    await _checkInstance();
    bool doesKeyExist = _prefs!.getKeys().contains(key);
    return doesKeyExist;
  }

  Future<void> removeKey(String key) async {
    await _checkInstance();
    bool doesKeyExist = _prefs!.getKeys().contains(key);
    if (doesKeyExist) {
      _prefs!.remove(key);
    }
  }

  Future<void> setBool(String key, bool value) async {
    await _checkInstance();
    await _prefs!.setBool(key, value);
  }

  Future<String> getString(String key) async {
    await _checkInstance();
    return _prefs!.getString(key) ?? '';
  }

  Future<void> setString(String key, String value) async {
    await _checkInstance();
    await _prefs!.setString(key, value);
  }

  Future<void> saveToken({required String token}) async {
    await _checkInstance();
    await _prefs!.setString(authTokenIdentifier, token);
  }

  Future<T?> retrieveFromSharedPreference<T>(String key) async {
    await _checkInstance();
    return _prefs!.get(key) as T?;
  }


  Future<int> getInt(String key) async {
    await _checkInstance();
    return _prefs!.getInt(key) ?? 0;
  }
  Future<void> setInt(String key, int value) async {
    await _checkInstance();
    await _prefs!.setInt(key, value);
  }

  Future<double> getDouble(String key) async {
    await _checkInstance();
    return _prefs!.getDouble(key) ?? 0.0;
  }

  Future<void> setDouble(String key, double value) async {
    await _checkInstance();
    await _prefs!.setDouble(key, value);
  }

  Future<void> remove(String key) async {
    await _checkInstance();
    await _prefs!.remove(key);
  }

  Future<void> clear() async {
    await _checkInstance();
    await _prefs!.clear();
  }

  Future<void> _checkInstance() async {
    if (_prefs == null) {
      await init();
    }
  }
}