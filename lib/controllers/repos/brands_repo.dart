import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/store_model.dart';

import '../../config/network/api_client.dart';
import '../../config/network/session.dart';

class BrandsRepo {
  final ApiClient api = ApiClient();
  Session session = Session();

  Future<List<StoreModel>> getRecentStore() async {
    final response = await api.getResponse(endpoints: Endpoints.recentStores);

    final list = response['stores'] as List;

    return list.map((item) => StoreModel.fromJson(item)).toList();
  }

  Future<StoreModel> getCurrentStore() async {
    final response = await api.getResponse(endpoints: Endpoints.currentStore);

    final store = response['store'];

    return store;
  }
}
