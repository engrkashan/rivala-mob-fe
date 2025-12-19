import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/store_model.dart';

import '../../config/network/api_client.dart';

class BrandsRepo {
  final ApiClient api = ApiClient();

  Future<List<StoreModel>> getRecentStore() async {
    final response = await api.getResponse(endpoints: Endpoints.recentStores);

    final list = response['stores'] as List;

    return list.map((item) => StoreModel.fromJson(item)).toList();
  }

  Future<StoreModel> getCurrentStore() async {
    final response = await api.getResponse(endpoints: Endpoints.currentStore);

    final store = response['store'];

    return StoreModel.fromJson(store);
  }

  Future<List<StoreModel>> getAllStores() async {
    final response = await api.getResponse(endpoints: Endpoints.stores);

    final list = response['stores'] as List;

    return list.map((item) => StoreModel.fromJson(item)).toList();
  }

  Future<void> updateStore(StoreModel store) async {
    final res = api.patchResponse(endpoint: Endpoints.stores, data: store);
  }

  Future<StoreModel> getStoreBySlug(String slug) async {
    final response =
        await api.getResponse(endpoints: Endpoints.storeBySlug(slug));

    return StoreModel.fromJson(response['store']);
  }
}
