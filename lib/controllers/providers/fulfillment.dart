import 'package:flutter/cupertino.dart';
import 'package:rivala/models/fulfillment_provider_model.dart';

import '../repos/fulfilment_provider_repo.dart';

class fulfillmentPro extends ChangeNotifier {
  final fulfillmentProviderRepo = FulfilmentProviderRepo();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = "";
  String get error => _error;

  List<FulfillmentProvider>? _allProviders;
  List<FulfillmentProvider>? get allProviders => _allProviders;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> fetchProviders() async {
    setLoading(true);
    try {
      _allProviders = await fulfillmentProviderRepo.fetchFulfilmentProviders();
      _error = '';
    } catch (e) {
      _error = e.toString();
      _allProviders = [];
    } finally {
      setLoading(false);
    }
  }

  Future<FulfillmentProvider?> getProviderById(String id) async {
    setLoading(true);
    try {
      final provider = await fulfillmentProviderRepo.fetchProviderById(id);
      _error = '';
      return provider;
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> createProvider(
      String type, String name, String key, String secret) async {
    setLoading(true);
    try {
      final data = {
        "type": type,
        "name": name,
        "apiKey": key,
        "apiSecret": secret,
      };

      final provider = await fulfillmentProviderRepo.createProvider(data);
      if (provider != null) {
        // Refresh list
        await fetchProviders();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      setLoading(false);
    }
  }
}
