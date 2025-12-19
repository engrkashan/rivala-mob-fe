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

  final List<StoreModel> _allStores = [];
  List<StoreModel> get allStores => _allStores;

  List<StoreModel> _filteredStores = [];
  List<StoreModel> get filteredStores => _filteredStores;

  String? get error => _error;

  List<StoreModel> selectedBrands = [];

  void clearCurrentStore() {
    _currentStore = null;
    notifyListeners();
  }

  void toggleBrand(StoreModel brand) {
    if (selectedBrands.any((m) => m.id == brand.id)) {
      selectedBrands.removeWhere((m) => m.id == brand.id);
    } else {
      selectedBrands.add(brand);
    }
    notifyListeners();
  }

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
    clearCurrentStore();
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

  Future<void> loadAllBrands() async {
    setLoading(true);
    try {
      final stores = await _brandsRepo.getAllStores();
      _allStores.addAll(stores);
      _filteredStores.clear();
      _filteredStores.addAll(_allStores);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _allStores.clear();
      _filteredStores.clear();
    } finally {
      setLoading(false);
    }
  }

  void searchBrands(String query) {
    if (query.isEmpty) {
      _filteredStores = List.from(_allStores);
    } else {
      _filteredStores = _allStores
          .where((squad) =>
              squad.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> updateStore(StoreModel store) async {
    setLoading(true);
    try {
      await _brandsRepo.updateStore(store);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadStoreByHandle(String slug) async {
    setLoading(true);
    clearCurrentStore();
    try {
      _currentStore = await _brandsRepo.getStoreBySlug(slug);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
