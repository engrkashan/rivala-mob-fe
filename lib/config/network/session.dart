import 'package:shared_preferences/shared_preferences.dart';

class Session {
  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("refreshToken", refreshToken);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("refreshToken");
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("refreshToken");
  }

  Future<void> savePersonalInfo({
    required String name,
    required String username,
    required String email,
    required String bio,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("saved_name", name);
    await prefs.setString("saved_username", username);
    await prefs.setString("saved_email", email);
    await prefs.setString("saved_bio", bio);
  }

  Future<Map<String, String?>> getPersonalInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "name": prefs.getString("saved_name"),
      "username": prefs.getString("saved_username"),
      "email": prefs.getString("saved_email"),
      "bio": prefs.getString("saved_bio"),
    };
  }
}
