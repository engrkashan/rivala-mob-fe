import 'package:flutter/cupertino.dart';
import 'package:rivala/config/network/endpoints.dart';

import '../../config/network/api_client.dart';
import '../../models/revenue.dart';

class RevenueProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  RevenueResponse? revenueResponse;

  Future<void> fetchRevenue() async {
    setLoading(true);
    try {
      final res = await ApiClient().getResponse(
        endpoints: Endpoints.revenue,
      );

      revenueResponse = RevenueResponse.fromJson(res);

      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
