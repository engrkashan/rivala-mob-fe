import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/user_model.dart';

class SellerRepo {
  ApiClient api = ApiClient();

  Future<List<UserModel>> getAllUsers() async {
    final response = await api.getResponse(endpoints: Endpoints.user);
    final list = response['users'] as List;
    return list.map((item) => UserModel.fromJson(item)).toList();
  }
}
