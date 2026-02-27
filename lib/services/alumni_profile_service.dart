import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/alumni_profile_model.dart';
import '../utils/storage_service.dart';
import '../config/api_config.dart';

class AlumniProfileService {

  static Future<AlumniProfileModel?> getProfile() async {
    try {
      final token = await StorageService.getToken();

      if (token == null) {
        print("❌ JWT token is null");
        return null;
      }

      final response = await http
          .get(
        Uri.parse("${ApiConfig.baseUrl}/api/alumni/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      )
          .timeout(const Duration(seconds: 15));

      print("GET PROFILE STATUS: ${response.statusCode}");
      print("GET PROFILE BODY: ${response.body}");

      if (response.statusCode == 200) {
        return AlumniProfileModel.fromJson(
            jsonDecode(response.body));
      }

      if (response.statusCode == 401) {
        print("⚠ Unauthorized - Token expired or invalid");
      }

      return null;
    } catch (e) {
      print("🔥 Error in getProfile(): $e");
      return null;
    }
  }

  static Future<bool> updateProfile(
      AlumniProfileModel profile) async {
    try {
      final token = await StorageService.getToken();

      if (token == null) {
        print("❌ JWT token is null");
        return false;
      }

      final response = await http
          .put(
        Uri.parse("${ApiConfig.baseUrl}/api/alumni/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(profile.toJson()),
      )
          .timeout(const Duration(seconds: 15));

      print("UPDATE PROFILE STATUS: ${response.statusCode}");
      print("UPDATE PROFILE BODY: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("🔥 Error in updateProfile(): $e");
      return false;
    }
  }
}