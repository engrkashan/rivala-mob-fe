import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/order_model.dart';

import '../../models/fulfillment.dart';

class OrderRepo {
  ApiClient api = ApiClient();

  Future<List<OrderModel>> fetchOrders() async {
    final res = await api.getResponse(endpoints: Endpoints.storeOrders);
    final list = res['orders'] as List;

    return list.map((e) => OrderModel.fromJson(e)).toList();
  }

  Future<List<FulfillmentModel>> listFulfillments() async {
    final res = await api.getResponse(endpoints: Endpoints.fullfillment);
    final list = res['fulfillments'] as List;

    return list.map((e) => FulfillmentModel.fromJson(e)).toList();
  }

  Future<OrderModel?> createOrder(Map<String, dynamic> data) async {
    // Ideally the backend returns the created order
    try {
      final res =
          await api.postResponse(endpoints: Endpoints.orders, data: data);
      if (res != null) {
        // If response is the order object directly
        if (res is Map<String, dynamic> && res.containsKey('id')) {
          return OrderModel.fromJson(res);
        }
        // If response is { order: ... }
        if (res is Map<String, dynamic> && res.containsKey('order')) {
          return OrderModel.fromJson(res['order']);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> fetchBuyerOrders() async {
    final res = await api.getResponse(endpoints: Endpoints.buyerOrder);
    final list = res['orders'] as List;

    return list.map((e) => OrderModel.fromJson(e)).toList();
  }

  Future<OrderModel?> fetchOrderById(String id) async {
    try {
      final res =
          await api.getResponse(endpoints: Endpoints.buyerOrderById(id));
      if (res != null) {
        if (res is Map<String, dynamic> && res.containsKey('order')) {
          return OrderModel.fromJson(res['order']);
        }
        return OrderModel.fromJson(res);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
