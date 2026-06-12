import 'package:flutter/foundation.dart';
import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/post_model.dart';
import 'package:rivala/models/user_model.dart';

class PostRepo {
  ApiClient api = ApiClient();

  Future<List<UserModel>> getRecentCreators() async {
    final response = await api.getResponse(endpoints: Endpoints.userWithPosts);
    final list = response['users'] as List;

    return list.map((item) => UserModel.fromJson(item)).toList();
  }

  Future<List<PostModel>> getDiscoverPosts() async {
    final response = await api.getResponse(endpoints: Endpoints.discoverPosts);
    // Assuming response is a list or contains a list under 'posts'
    final list = (response['posts'] ?? response) as List;
    return list.map((item) => PostModel.fromJson(item)).toList();
  }

  Future<dynamic> createPost(dynamic data) async {
    try {
      final response = await api.postResponse(endpoints: Endpoints.posts, data: data);
      return response;
    } catch (e) {
      debugPrint("Error in createPost repo: $e");
      rethrow;
    }
  }

  Future<void> toggleLike(String postId) async {
    try {
      await api.postResponse(endpoints: Endpoints.likePost(postId));
    } catch (e) {
      debugPrint("Error toggling like: $e");
      rethrow;
    }
  }

  Future<List<PostCommentModel>> getComments(String postId) async {
    try {
      final response = await api.getResponse(endpoints: Endpoints.comment(postId));
      if (response != null && response['comments'] != null) {
        return (response['comments'] as List)
            .map((e) => PostCommentModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error getting comments: $e");
      return [];
    }
  }

  Future<PostCommentModel?> postComment(String postId, String content) async {
    try {
      final response = await api.postResponse(endpoints: Endpoints.comment(postId),
          data: {"content": content});
      if (response != null && response['comment'] != null) {
        return PostCommentModel.fromJson(response['comment']);
      }
      return null;
    } catch (e) {
      debugPrint("Error posting comment: $e");
      rethrow;
    }
  }
}
