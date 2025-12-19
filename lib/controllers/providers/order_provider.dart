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
  List<OrderModel> _filteredOrders = [];
  List<OrderModel> get filteredOrders => _filteredOrders;
  Future<void> loadStoreOrders() async {
    setLoading(true);
    try {
      _orders = await _orderRepo.fetchOrders();
      _filteredOrders = List.from(_orders);
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  // void searchOrders(String query){
  //   if (query.isEmpty) {
  //     _filteredOrders = _orders;
  //   } else {
  //     _filteredOrders = _orders!
  //         .where((order) =>
  //         order.products.contains()!.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   }
  //   notifyListeners();
  // }

  List<FulfillmentModel> _fulfillments = [];
  List<FulfillmentModel> get fulfillments => _fulfillments;

  // Future<void> fetchFulfillments() async {
  //   _fulfillments = await _orderRepo.listFulfillments();
  // }
  Future<bool> createOrder(Map<String, dynamic> orderData) async {
    setLoading(true);
    _error = "";
    try {
      await _orderRepo.createOrder(orderData);
      // Ideally update _orders list locally or re-fetch
      // await loadStoreOrders(); // Usually buyer orders are different from store orders
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      setLoading(false);
    }
  }

  // Buyer specific
  List<OrderModel> _buyerOrders = [];
  List<OrderModel> get buyerOrders => _buyerOrders;

  Future<void> loadBuyerOrders() async {
    setLoading(true);
    try {
      _buyerOrders = await _orderRepo.fetchBuyerOrders();
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<OrderModel?> getOrderById(String id) async {
    setLoading(true);
    _error = "";
    try {
      return await _orderRepo.fetchOrderById(id);
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      setLoading(false);
    }
  }
}
