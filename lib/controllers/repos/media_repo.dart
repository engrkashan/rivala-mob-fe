import 'dart:convert';
import 'dart:io';

import 'package:rivala/config/network/api_client.dart';

class MediaRepo {
  final ApiClient api;

  MediaRepo(this.api);

  Future<String> uploadFile({required File file}) async {
    final response = await api.uploadMedia(file, authorized: false);
    final jsonBody = jsonDecode(await response.stream.bytesToString());
    print("Image upload Json: $jsonBody");
    print("upload media status Code: ${response.statusCode}");
    if (response.statusCode == 200) {
      if (jsonBody != null &&
          jsonBody['media'] != null &&
          jsonBody['media']['url'] != null) {
        print("Uploaded image url: ${jsonBody}");
        return jsonBody['media']['url'];
      }
      // Fallback in case the structure is different
      if (jsonBody != null && jsonBody['url'] != null) {
        return jsonBody['url'];
      }
      throw "Upload successful but server returned no URL";
    }

    throw jsonBody != null
        ? (jsonBody["message"] ?? "upload Failed")
        : "upload Failed";
  }
}
