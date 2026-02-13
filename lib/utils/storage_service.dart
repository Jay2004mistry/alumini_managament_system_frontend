import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  // 🔹 Keys (centralized — no magic strings)
  static const String _isLoggedInKey = "isLoggedIn";
  static const String _userNameKey = "userName";
  static const String _userRoleKey = "userRole";
  static const String _tokenKey = "authToken";

  // 🔹 Save Login Status
  static Future<void> saveLoginStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  // 🔹 Get Login Status
  static Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // 🔹 Save User Name
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
  }

  // 🔹 Get User Name
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  // 🔹 Save User Role
  static Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userRoleKey, role);
  }

  // 🔹 Get User Role
  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  // 🔹 Save Token (for JWT future use)
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // 🔹 Get Token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // 🔹 Logout (clear everything)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
