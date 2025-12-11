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
}
