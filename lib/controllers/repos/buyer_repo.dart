import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/buyer_model.dart';

class BuyerRepo {
  ApiClient api = ApiClient();

  /// Get buyer profile
  Future<BuyerModel> getBuyerProfile() async {
    final response = await api.getResponse(endpoints: Endpoints.buyer);
    return BuyerModel.fromJson(response);
  }

  /// Get buyer by ID
  Future<BuyerModel> getBuyerById(String id) async {
    final response = await api.getResponse(endpoints: Endpoints.buyerById(id));
    return BuyerModel.fromJson(response);
  }
}
