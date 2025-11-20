import 'dart:convert';
import 'dart:io';

import 'package:rivala/config/network/api_client.dart';

class MediaRepo {
  final ApiClient api;

  MediaRepo(this.api);

  Future<String> uploadFile({required File file}) async {
    final response = await api.uploadMedia(file, authorized: false);
    final jsonBody = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      return jsonBody['data']['url'];
    }

    throw jsonBody["message"] ?? "upload Failed";
  }
}
