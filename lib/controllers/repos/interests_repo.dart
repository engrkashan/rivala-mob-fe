import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/interest_model.dart';

class InterestsRepo {
  ApiClient api = ApiClient();

  /// Get all interests
  Future<List<InterestModel>> getInterests() async {
    final response = await api.getResponse(endpoints: Endpoints.interests);
    final list = response['interests'] as List;
    return list.map((item) => InterestModel.fromJson(item)).toList();
  }

  /// Get interest by ID
  Future<InterestModel> getInterestById(String id) async {
    final response =
        await api.getResponse(endpoints: Endpoints.interestsWithId(id));
    return InterestModel.fromJson(response);
  }

  /// Get current user's interests
  Future<List<InterestModel>> getCurrentUserInterests() async {
    final response =
        await api.getResponse(endpoints: Endpoints.getCurrentUserInterests);
    final list = response['interests'] as List;
    return list.map((item) => InterestModel.fromJson(item)).toList();
  }

  /// Update/Add interests for current user
  /// Assuming it accepts a list of interest IDs or names
  Future<void> updateCurrentUserInterests(List<String> interestIds) async {
    await api.postResponse(
      endpoints: Endpoints.currentUserInterest,
      data: {'interestIds': interestIds},
    );
  }
}
