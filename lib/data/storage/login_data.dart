import 'dart:convert';
import 'package:frijo/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDataStore {
  static const String _keyLoginData = "login_data";

  /// Save LoginModel to SharedPreferences
  static Future<void> saveLogin(LoginModel loginModel) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(loginModel.toJson());
    await prefs.setString(_keyLoginData, jsonString);
  }

  /// Get LoginModel from SharedPreferences
  static Future<LoginModel?> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyLoginData);
    if (jsonString == null) return null;
    return LoginModel.fromJson(jsonDecode(jsonString));
  }

  /// Remove saved login
  static Future<void> clearLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLoginData);
  }

  /// Check if login exists
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyLoginData);
  }
}
