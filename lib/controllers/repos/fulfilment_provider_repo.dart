import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/fulfillment_provider_model.dart';

class FulfilmentProviderRepo {
  ApiClient api = ApiClient();

  Future<List<FulfillmentProvider>> fetchFulfilmentProviders() async {
    final res =
        await api.getResponse(endpoints: Endpoints.fullfillmentProvider);
    final list = res['providers'] as List;
    return list.map((e) => FulfillmentProvider.fromJson(e)).toList();
  }

  Future<FulfillmentProvider> fetchProviderById(String id) async {
    final res = await api.getResponse(
        endpoints: Endpoints.fullfillmentProviderWithId(id));
    return FulfillmentProvider.fromJson(res);
  }

  Future<FulfillmentProvider?> createProvider(Map<String, dynamic> data) async {
    try {
      final res = await api.postResponse(
          endpoints: Endpoints.fullfillmentProvider, data: data);

      // Handle response structure differences if any
      if (res is Map<String, dynamic>) {
        if (res.containsKey('provider')) {
          return FulfillmentProvider.fromJson(res['provider']);
        }
        return FulfillmentProvider.fromJson(res);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
