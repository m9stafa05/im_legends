import 'dart:convert';
import '../../features/notification/data/models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStorage {
  SharedPrefStorage._();
  static final SharedPrefStorage instance = SharedPrefStorage._();

  late final SharedPreferences _prefs;
  bool _initialized = false;

  /// Call this once before using (in main.dart)
  Future<void> init() async {
    if (_initialized) return;
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  void _checkInit() {
    if (!_initialized) {
      throw Exception('SharedPrefs not initialized. Call init() before use.');
    }
  }

  // --------------------
  // Basic methods
  // --------------------

  Future<bool> setString(String key, String value) async {
    _checkInit();
    return _prefs.setString(key, value);
  }

  String? getString(String key) {
    _checkInit();
    return _prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    _checkInit();
    return _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    _checkInit();
    return _prefs.getBool(key);
  }

  Future<bool> setInt(String key, int value) async {
    _checkInit();
    return _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    _checkInit();
    return _prefs.getInt(key);
  }

  Future<bool> setDouble(String key, double value) async {
    _checkInit();
    return _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    _checkInit();
    return _prefs.getDouble(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    _checkInit();
    return _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    _checkInit();
    return _prefs.getStringList(key);
  }

  // --------------------
  // Advanced methods
  // --------------------

  /// Save a list of NotificationModel
  Future<bool> setNotifications(List<NotificationModel> notifications) async {
    _checkInit();
    final jsonList = notifications.map((n) => json.encode(n.toJson())).toList();
    return _prefs.setStringList('notifications', jsonList);
  }

  /// Get all saved notifications
  List<NotificationModel> getNotifications() {
    _checkInit();
    final jsonList = _prefs.getStringList('notifications') ?? [];
    return jsonList
        .map(
          (jsonString) => NotificationModel.fromJson(json.decode(jsonString)),
        )
        .toList();
  }

  Future<bool> remove(String key) async {
    _checkInit();
    return _prefs.remove(key);
  }

  Future<bool> clearAll() async {
    _checkInit();
    return _prefs.clear();
  }

  bool containsKey(String key) {
    _checkInit();
    return _prefs.containsKey(key);
  }
}
