import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:rivala/config/network/api_config.dart';
import 'package:rivala/config/network/session.dart';

import 'endpoints.dart';

class ApiClient {
  Session session = Session();
  Future<Map<String, String>> _headers() async {
    final token = await session.getAuthToken();

    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    if (token != null && token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }

    return headers;
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await session.getRefreshToken();
      if (refreshToken == null) return false;

      final url = Uri.parse(ApiConfig.baseUrl + Endpoints.refreshToken);

      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"refreshToken": refreshToken}),
      );

      print(res.body);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        await session.saveAuthToken(data["accessToken"]);
        await session.saveRefreshToken(data["refreshToken"]);
        return true;
      }
    } catch (e) {
      print("Refresh token error: $e");
    }

    return false;
  }

  Future<dynamic> _retryRequest(Function requestFn) async {
    final success = await _refreshToken();
    if (!success) {
      session.clearTokens(); // logout user
      throw ApiException(message: "Session expired", response: null);
    }

    return await requestFn(); // retry original request
  }

  dynamic _handleResponse(http.Response res) {
    print("--------------------------------------------------");
    print("API RESPONSE LOG");
    print("URL: ${res.request?.url}");
    print("METHOD: ${res.request?.method}");
    print("STATUS CODE: ${res.statusCode}");
    print(
        "BODY (truncated): ${res.body.length > 500 ? res.body.substring(0, 500) + '...' : res.body}");
    print("--------------------------------------------------");

    if (res.statusCode >= 200 && res.statusCode <= 300) {
      if (res.body.isEmpty) return null;
      return jsonDecode(res.body);
    } else {
      String message = "Something went wrong";
      try {
        final decoded = jsonDecode(res.body);
        if (decoded is Map && decoded.containsKey("error")) {
          message = decoded["error"];
        } else {
          message = "Something went wrong: ${res.body}";
        }
      } catch (e) {
        message = "Something went wrong: ${res.body}";
      }
      throw ApiException(
          message: message, response: res.body, statusCode: res.statusCode);
    }
  }

  Future<dynamic> getResponse({
    required String endpoints,
    Map<String, dynamic>? query,
  }) async {
    final uri = Uri.parse(ApiConfig.baseUrl + endpoints)
        .replace(queryParameters: query);

    final response = await http.get(uri, headers: await _headers());

    // 🔥 Fix: Handle 401 here
    if (response.statusCode == 401) {
      return _retryRequest(() async => await getResponse(
            endpoints: endpoints,
            query: query,
          ));
    }

    return _handleResponse(response);
  }

  Future<dynamic> postResponse(
      {required String endpoints, dynamic data}) async {
    final url = Uri.parse(ApiConfig.baseUrl + endpoints);

    final response = await http.post(
      url,
      headers: await _headers(),
      body: data != null ? jsonEncode(data) : null,
    );

    // if (response.statusCode == 401) {
    //   return _retryRequest(
    //       () async => await postResponse(endpoints: endpoints, data: data));
    // }

    return _handleResponse(response);
  }

  Future<dynamic> patchResponse(
      {required String endpoint, dynamic data}) async {
    final url = Uri.parse(ApiConfig.baseUrl + endpoint);
    final response = await http.patch(url,
        headers: await _headers(),
        body: data != null ? jsonEncode(data) : null);

    // if (response.statusCode == 401) {
    //   return _retryRequest(
    //       () async => await postResponse(endpoints: endpoint, data: data));
    // }

    return _handleResponse(response);
  }

  Future<dynamic> putResponse({required String endpoints, dynamic data}) async {
    final url = Uri.parse(ApiConfig.baseUrl + endpoints);
    final response = await http.put(
      url,
      headers: await _headers(),
      body: data != null ? jsonEncode(data) : null,
    );

    return _handleResponse(response);
  }

  Future<dynamic> deleteRequest({required String endpoint}) async {
    final url = Uri.parse(ApiConfig.baseUrl + endpoint);

    final response = await http.delete(url, headers: await _headers());
    // if (response.statusCode == 401) {
    //   return _retryRequest(() async => await postResponse(
    //         endpoints: endpoint,
    //       ));
    // }
    return _handleResponse(response);
  }

  Future<http.StreamedResponse> uploadMedia(File file,
      {bool authorized = true}) async {
    final mimeType = lookupMimeType(file.path);
    final splitMime = mimeType?.split('/') ?? ['application', 'octet-stream'];

    final url = Uri.parse(ApiConfig.baseUrl + Endpoints.media);
    var request = http.MultipartRequest("POST", url);

    request.headers.addAll(await _headers());

    request.files.add(
      await http.MultipartFile.fromPath(
        "file",
        file.path,
        contentType: MediaType(splitMime[0], splitMime[1]),
      ),
    );

    var response = await request.send();

    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (!refreshed) {
        throw ApiException(message: "Session expired", response: null);
      }

      /// retry upload
      request.headers["Authorization"] =
          "Bearer ${await session.getAuthToken()}";
      response = await request.send();
    }

    final respBody = await response.stream.bytesToString();
    print("--------------------------------------------------");
    print("UPLOAD MEDIA LOG");
    print("URL: $url");
    print("STATUS CODE: ${response.statusCode}");
    print(
        "BODY (truncated): ${respBody.length > 500 ? respBody.substring(0, 500) + '...' : respBody}");
    print("--------------------------------------------------");

    // Reconstruct the response since we consumed the stream
    return http.StreamedResponse(
      Stream.fromIterable([respBody.codeUnits]),
      response.statusCode,
      contentLength: respBody.length,
      request: response.request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
  }

  Future<dynamic> multipartRequest(
      {required String endpoint,
      required Map<String, String> fields,
      File? file,
      String method = "POST"}) async {
    final url = Uri.parse(ApiConfig.baseUrl + endpoint);
    var request = http.MultipartRequest(method, url);

    request.headers.addAll(await _headers());
    request.fields.addAll(fields);

    if (file != null) {
      final mimeType = lookupMimeType(file.path);
      final splitMime = mimeType?.split('/') ?? ['application', 'octet-stream'];

      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          file.path,
          contentType: MediaType(splitMime[0], splitMime[1]),
        ),
      );
    }

    var response = await request.send();

    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (!refreshed) {
        throw ApiException(message: "Session expired", response: null);
      }
      request.headers["Authorization"] =
          "Bearer ${await session.getAuthToken()}";
      response = await request.send();
    }

    final respBody = await response.stream.bytesToString();

    // Quick parse to mock _handleResponse
    final fakeResponse =
        http.Response(respBody, response.statusCode, request: response.request);
    return _handleResponse(fakeResponse);
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? response;

  ApiException(
      {required this.message, this.statusCode, required this.response});

  // String toString() {
  //   return "ApiException: $message (status: $statusCode) \n Response: $response";
  // }

  @override
  String toString() => message;
}
