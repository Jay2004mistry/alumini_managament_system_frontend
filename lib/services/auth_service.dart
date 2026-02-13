import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class AuthService {

  static Future<http.Response> registerUser({
    required String name,
    required String email,
    required String password,
    required String role,
  }) {
    return http.post(
      Uri.parse("${ApiConfig.baseUrl}/api/users"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "role": role,
      }),
    );
  }

  static Future<http.Response> loginUser({
    required String email,
    required String password,
  }) {
    return http.post(
      Uri.parse("${ApiConfig.baseUrl}/api/users/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
  }
}
