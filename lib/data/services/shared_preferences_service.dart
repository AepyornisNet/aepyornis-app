import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const _baseUrl = 'BASE_URL';
  static const _apiKey = 'API_KEY';
  static const _syncHealthConnect = 'SYNC_HEALTH_CONNECT';
  static const _legacySyncPedometer = 'SYNC_PEDOMETER';

  Future<void> setUrl(String? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await prefs.remove(_baseUrl);
    } else {
      await prefs.setString(_baseUrl, value);
    }
  }

  Future<String?> getUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_baseUrl);
  }

  Future<void> setApiKey(String? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await prefs.remove(_apiKey);
    } else {
      await prefs.setString(_apiKey, value);
    }
  }

  Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_apiKey);
  }

  Future<void> setSyncHealthConnect(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_syncHealthConnect, value);
    await prefs.remove(_legacySyncPedometer);
  }

  Future<bool> getSyncHealthConnect() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_syncHealthConnect)) {
      return prefs.getBool(_syncHealthConnect) ?? true;
    }
    return prefs.getBool(_legacySyncPedometer) ?? true;
  }

  @Deprecated('Use setSyncHealthConnect instead')
  Future<void> setSyncPedometer(bool value) => setSyncHealthConnect(value);

  @Deprecated('Use getSyncHealthConnect instead')
  Future<bool> getSyncPedometer() => getSyncHealthConnect();
}
