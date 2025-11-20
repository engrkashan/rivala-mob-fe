import 'package:flutter/widgets.dart';
import 'package:rivala/controllers/repos/brands_repo.dart';
import 'package:rivala/models/store_model.dart';

class BrandsProvider extends ChangeNotifier {
  bool _isLoading = false;
  final BrandsRepo _brandsRepo = BrandsRepo();
  List<StoreModel>? _storeModel;
  List<StoreModel>? get store => _storeModel;
  StoreModel? _currentStore;
  StoreModel? get currentStore => _currentStore;
  bool get isLoading => _isLoading;
  String? _error;

  String? get error => _error;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> loadRecentBrands() async {
    setLoading(true);

    try {
      _storeModel = await _brandsRepo.getRecentStore();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _storeModel = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadCurrentStore() async {
    setLoading(true);
    try {
      _currentStore = await _brandsRepo.getCurrentStore();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _storeModel = [];
    } finally {
      setLoading(false);
    }
  }
}
