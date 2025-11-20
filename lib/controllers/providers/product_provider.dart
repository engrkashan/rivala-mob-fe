import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/products_repo.dart';
import 'package:rivala/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final _productRepo = ProductsRepo();

  bool _isLoading = false;
  String? _error;
  List<ProductModel>? _forYouPrd;
  // Stores all product lists by type
  final Map<String, List<ProductModel>> _productsByType = {};

  List<ProductReview>? _prdReviews;

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<ProductReview>? get prdReviews => _prdReviews;
  List<ProductModel>? productsFor(String type) => _productsByType[type];
  List<ProductModel>? get forYouPrd => _forYouPrd;

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

  Future<void> loadForYou(String id) async {
    setLoading(true);
    try {
      _forYouPrd = await _productRepo.getForYouPrd(id);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _forYouPrd = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadPrdreviews(String id) async {
    setLoading(true);
    try {
      _prdReviews = await _productRepo.getPrdReview(id);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _forYouPrd = [];
    } finally {
      setLoading(false);
    }
  }
}
