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

  Future<StoreModel> updateStore(StoreModel store) async {
    print("updateStore in repo: ${store.toJson()}");
    final res =
        await api.patchResponse(endpoint: Endpoints.stores, data: store);
    final updatedStore = StoreModel.fromJson(res['store']);
    print("updatedStore $updatedStore");
    // Preserve logoUrl if backend returned null but we had one in input
    if ((updatedStore.logoUrl == null || updatedStore.logoUrl!.isEmpty) &&
        (store.logoUrl != null && store.logoUrl!.isNotEmpty)) {
      return updatedStore.copyWith(logoUrl: store.logoUrl);
    }

    return updatedStore;
  }

  Future<StoreModel> getStoreBySlug(String slug) async {
    final response =
        await api.getResponse(endpoints: Endpoints.storeBySlug(slug));

    return StoreModel.fromJson(response['store']);
  }
}
