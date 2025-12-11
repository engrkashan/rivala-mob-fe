import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/order_model.dart';

import '../../models/fulfillment.dart';

class OrderRepo {
  ApiClient api = ApiClient();

  Future<List<OrderModel>> fetchOrders() async {
    final res = await api.getResponse(endpoints: Endpoints.storeOrders);
    final list = res['storeOrders'] as List;

    return list.map((e) => OrderModel.fromJson(e)).toList();
  }

  Future<List<FulfillmentModel>> listFulfillments() async {
    final res = await api.getResponse(endpoints: Endpoints.fullfillment);
    final list = res['fulfillments'] as List;

    return list.map((e) => FulfillmentModel.fromJson(e)).toList();
  }
}
