import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/collection_model.dart';

class CollectionsRepo {
  ApiClient api = ApiClient();

  Future<List<CollectionModel>> getCollectionsList() async {
    final response = await api.getResponse(endpoints: Endpoints.collection);
    final list = response['collections'] as List;
    return list.map((e) => CollectionModel.fromJson(e)).toList();
  }

  Future<CollectionModel> createCollection(
    String name,
    String desc,
    List<String> productIds,
  ) async {
    final res = await api.postResponse(
      endpoints: Endpoints.collection,
      data: {
        "name": name,
        "description": desc,
        "productIds": productIds,
      },
    );

    return CollectionModel.fromJson(res['collection']);
  }

  Future<void> deleteCollection(String id) async {
    await api.deleteRequest(endpoint: Endpoints.collectionWithId(id));
  }
}
