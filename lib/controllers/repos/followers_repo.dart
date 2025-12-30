import 'package:rivala/config/network/api_client.dart';

import '../../config/network/endpoints.dart';
import '../../models/follow_model.dart';

class FollowsRepo {
  ApiClient api = ApiClient();

  Future<List<FollowModel>> getFollowers() async {
    final response = await api.getResponse(endpoints: Endpoints.followers);
    final List<dynamic> data = response['followers'] ?? [];
    return data.map((item) => FollowModel.fromJson(item)).toList();
  }

  Future<List<FollowModel>> getFollowing() async {
    final response =
        await api.getResponse(endpoints: Endpoints.currentFollowing);
    final data = response['followingStores'] as List;
    return data.map((item) => FollowModel.fromJson(item)).toList();
  }

  Future<void> followBrand(String brandId) async {
    await api.postResponse(
      endpoints: Endpoints.brandWithId(brandId),
    );
  }

  Future<void> unfollowBrand(String brandId) async {
    await api.deleteRequest(endpoint: Endpoints.brandWithId(brandId));
  }
}
