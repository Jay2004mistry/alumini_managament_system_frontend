import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/storage_service.dart';
import '../config/api_config.dart';

class UserService {

  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final token = await StorageService.getToken();

    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/api/user/me"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }
}