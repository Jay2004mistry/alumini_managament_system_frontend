import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alumni_management/config/api_config.dart';

class AuthService {

  // ===============================
  // REGISTER USER
  // ===============================
  static Future<http.Response> registerUser({
    required String name,
    required String email,
    required String password,
    required String role,
    required String universityNo,
  }) async {

    final url = Uri.parse("${ApiConfig.baseUrl}/api/users");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "universityNumber": universityNo,
          "role": {
            "roleName": role
          }
        }),
      );

      return response;

    } catch (e) {
      throw Exception("Network Error: $e");
    }
  }

  // ===============================
  // LOGIN USER
  // ===============================
  static Future<http.Response> loginUser({
    required String email,
    required String password,
  }) async {

    final url = Uri.parse("${ApiConfig.baseUrl}/api/users/login");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      return response;

    } catch (e) {
      throw Exception("Network Error: $e");
    }
  }
}
