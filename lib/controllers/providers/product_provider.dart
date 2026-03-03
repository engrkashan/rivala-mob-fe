import 'package:flutter/foundation.dart';
import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/controllers/repos/products_repo.dart';
import 'package:rivala/models/product_model.dart';

import '../debouncer.dart';

class ProductProvider extends ChangeNotifier {
  final _productRepo = ProductsRepo();

  bool _isLoading = false;
  String? _error;
  List<ProductModel>? _prds;
  // Stores all product lists by type
  final Map<String, List<ProductModel>> _productsByType = {};

  List<ProductModel>? searchProductsList;

  List<ProductReview>? _prdReviews;

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<ProductReview>? get prdReviews => _prdReviews;
  List<ProductModel>? productsFor(String type) => _productsByType[type];
  List<ProductModel>? get prds => _prds;

  List<ProductModel>? _filteredPrds;
  List<ProductModel>? get filteredPrds => _filteredPrds;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadFeed(String type) async {
    setLoading(true);

    try {
      final products = await _productRepo.getProductsFeed(type);
      _productsByType[type] = products;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _productsByType[type] = [];
    } finally {
      setLoading(false);
    }
  }

  Future<ProductModel?> createProduct(ProductModel product) async {
    setLoading(true);
    print("Create products in provider: ${product.toJson()}");
    try {
      final response = await ApiClient().postResponse(
        endpoints: Endpoints.products,
        data: product.toJson(),
      );

      final productData = response['product'] ??
          response['data']?['product'] ??
          response['data'];

      if (productData != null) {
        final created = ProductModel.fromJson(productData);

        // Ensure lists are initialized
        _prds ??= [];
        _filteredPrds ??= [];

        // Avoid duplicates if already added by some other logic
        if (!_prds!.any((p) => p.id == created.id)) {
          _prds!.add(created);
        }

        if (!_filteredPrds!.any((p) => p.id == created.id)) {
          _filteredPrds!.add(created);
        }
        _error = null;
        setLoading(false);
        return created;
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
      debugPrint("Error in createProduct: $e");
      // rethrow;
    }
    setLoading(false);
    return null;
  }

  Future<void> loadForYou(String id) async {
    setLoading(true);
    try {
      _prds = await _productRepo.getForYouPrd(id);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _prds = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadPrdReviews(String id) async {
    setLoading(true);
    try {
      _prdReviews = await _productRepo.getPrdReview(id);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _prds = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadCurrentProducts() async {
    setLoading(true);
    try {
      _prds = await _productRepo.getMyProducts();
      _filteredPrds = _prds;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _prds = [];
    } finally {
      setLoading(false);
    }
  }

  List<ProductModel> selectedMembers = [];

  void toggleMember(ProductModel prd) {
    if (selectedMembers.any((m) => m.id == prd.id)) {
      selectedMembers.removeWhere((m) => m.id == prd.id);
    } else {
      selectedMembers.add(prd);
    }
    notifyListeners();
  }

  Future<void> loadAllProducts() async {
    setLoading(true);
    try {
      final allProducts = await _productRepo.getAllProducts();
      _prds = allProducts;
      _filteredPrds = List.from(allProducts); // always copy
      _error = null;
    } catch (e) {
      _error = e.toString();
      _prds = [];
      _filteredPrds = [];
    } finally {
      setLoading(false);
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredPrds = _prds;
    } else {
      _filteredPrds = _prds!
          .where((squad) =>
              squad.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> uploadProduct(ProductModel model) async {
    setLoading(true);
    try {
      await _productRepo.postProduct(model);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateProduct(ProductModel model) async {
    setLoading(true);
    try {
      await _productRepo.updateProduct(model);
      _error = null;
      await loadAllProducts(); // Refresh list
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteProduct(String id) async {
    setLoading(true);
    try {
      await _productRepo.deleteProduct(id);
      _error = null;
      await loadCurrentProducts(); // Refresh "My Products" list
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> getSearchProducts(String query) async {
    setLoading(true);
    try {
      searchProductsList = await _productRepo.searchProducts(query);
      _error = null;
    } catch (e) {
      _error = e.toString();
      searchProductsList = [];
    } finally {
      setLoading(false);
    }
  }

  final _debouncer = Debouncer(milliseconds: 400);
  final _cache = <String, List<ProductModel>>{};

  String _lastQuery = "";

  void onSearchChanged(String query) {
    if (query.trim().length < 2 || query == _lastQuery) return;

    _debouncer.run(() async {
      _lastQuery = query;

      // 🔁 Cache hit
      if (_cache.containsKey(query)) {
        searchProductsList = _cache[query];
        notifyListeners();
        return;
      }
      getSearchProducts(query);
    });
  }
}
