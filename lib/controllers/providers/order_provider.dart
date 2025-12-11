import 'package:flutter/foundation.dart';

import '../../models/fulfillment.dart';
import '../../models/order_model.dart';
import '../repos/order_repo.dart';

class OrderProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _error = "";
  String get error => _error;
  final OrderRepo _orderRepo = OrderRepo();

  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;
  Future<void> loadStoreOrders() async {
    setLoading(true);
    try {
      _orders = await _orderRepo.fetchOrders();
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  List<FulfillmentModel> _fulfillments = [];
  List<FulfillmentModel> get fulfillments => _fulfillments;

  // Future<void> fetchFulfillments() async {
  //   _fulfillments = await _orderRepo.listFulfillments();
  // }
}
