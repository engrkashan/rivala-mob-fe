import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/user_model.dart';
import 'package:rivala/models/post_model.dart';

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
}
