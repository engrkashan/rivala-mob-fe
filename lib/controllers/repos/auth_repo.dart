import 'dart:convert';

import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/config/network/session.dart';
import 'package:rivala/models/user_model.dart';

class AuthRepo {
  final ApiClient api;

  AuthRepo(this.api);

  Session session = Session();

  Future<UserModel> register({required Map<String, dynamic> data}) async {
    final response =
        await api.postResponse(endpoints: Endpoints.register, data: data);
    print("Thi is response $response");

    if (response == null) {
      throw ApiException(
        message: "Registration failed: Server returned an empty response.",
        response: null,
        statusCode: 200,
      );
    }

    final token = response['accessToken'];
    final refreshToken = response['refreshToken'];
    final userData =
        response['seller'] ?? response['data']; // Check both common keys

    if (userData == null) {
      throw ApiException(
        message: "Registration failed: Missing user data in response.",
        response: jsonEncode(response),
        statusCode: 200,
      );
    }

    final user = UserModel.fromJson(userData);

    if (token != null) {
      await session.saveAuthToken(token);
    }
    if (refreshToken != null) {
      await session.saveRefreshToken(refreshToken);
    }

    return user;
  }

  Future<UserModel> login(
      {required String identifier, required String password}) async {
    final response = await api.postResponse(
        endpoints: Endpoints.login,
        data: {"identifier": identifier, "password": password});

    if (response == null) {
      throw ApiException(
        message:
            "Login failed: Server returned an empty response (200 OK without content).",
        response: null,
        statusCode: 200,
      );
    }

    final token = response['accessToken'];
    final refreshToken = response['refreshToken'];
    // Check multiple common keys for user data
    final userData = response['seller'] ?? response['user'] ?? response['data'];

    if (token == null || userData == null) {
      throw ApiException(
        message:
            "Login failed: ${token == null ? "no accessToken found" : "user data not found"} in response.",
        response: jsonEncode(response),
        statusCode: 200,
      );
    }

    await session.saveAuthToken(token);
    if (refreshToken != null) {
      await session.saveRefreshToken(refreshToken);
    }

    final user = UserModel.fromJson(userData);

    return user;
  }

  Future logout() async {
    final refreshToken = await session.getRefreshToken();
    final response = await api.postResponse(
        endpoints: Endpoints.logout, data: {"refreshToken": refreshToken});

    await session.clearTokens();
  }

  Future<void> checkToken() async {
    final response = await api.postResponse(
      endpoints: Endpoints.checkToken,
    );

    print(response['accessToken']);
  }

  Future<void> verifySellerEmail({required String otp}) async {
    final response = await api.postResponse(
      endpoints: Endpoints.verifySellerEmail,
      data: {"otp": otp},
    );
  }

  Future<void> resendSellerOtp({required String identifier}) async {
    final response = await api.postResponse(
        endpoints: Endpoints.resendVerification, data: {"email": identifier});
  }

  Future<UserModel> updateUser(UserModel user) async {
    final response = await api.patchResponse(
      endpoint: Endpoints.user,
      data: user.toJson(),
    );

    final updatedData = response['user'] ?? response['data'] ?? response;
    final updatedUser = UserModel.fromJson(updatedData);

    // Preserve avatarUrl if backend returned null/empty but we had one in the input
    if ((updatedUser.avatarUrl == null || updatedUser.avatarUrl!.isEmpty) &&
        (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)) {
      return updatedUser.copyWith(avatarUrl: user.avatarUrl);
    }

    return updatedUser;
  }
}
