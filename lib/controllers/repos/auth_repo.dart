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

    final token = response['accessToken'];
    final refreshToken = response['refreshToken'];
    final userData = response['data'];
    final user = UserModel.fromJson(userData);

    if (token != null) {
      await session.saveAuthToken(token);
    }
    if (refreshToken != null) {
      await session.saveRefreshToken(refreshToken);
    }

    return user;
  }

// Assuming 'api' and 'session' are globally available or instantiated

  Future<UserModel> login(
      {required String identifier, required String password}) async {

    final response = await api.postResponse(
        endpoints: Endpoints.login,
        data: {"identifier": identifier, "password": password});

    // 1. 🛑 CRITICAL NULL CHECK: If response is null, the body was empty,
    // which is a failure for a login endpoint.
    if (response == null) {
      throw ApiException(
        message: "Login failed: Server returned an empty response (200 OK without content).",
        response: null,
        statusCode: 200,
      );
    }

    // 2. Safely access keys now that 'response' is guaranteed to be a Map
    final token = response['accessToken'];
    final refreshToken = response['refreshToken'];
    final userData = response['data'];

    // 3. Add checks for missing keys if they are mandatory
    if (token == null || userData == null) {
      throw ApiException(
        message: "Login failed: Missing 'accessToken' or user 'data' in the response.",
        response: jsonEncode(response),
        statusCode: 200,
      );
    }

    await session.saveAuthToken(token);
    await session.saveRefreshToken(refreshToken);

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

  Future<void> resendSellerOtp({required String email}) async {
    final response = await api.postResponse(
        endpoints: Endpoints.resendVerification, data: {"email": email});
  }
}
