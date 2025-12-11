import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/categories_repo.dart';
import 'package:rivala/models/category_model.dart';
import 'package:rivala/models/product_model.dart';

class CategoriesProvider extends ChangeNotifier {
  final _categoriesRepo = CategoriesRepo();

  bool _isLoading = false;
  String? _error;
  List<CategoryModel>? _categories;
  CategoryModel? _currentCategory;
  List<ProductModel>? _categoryProducts;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<CategoryModel>? get categories => _categories;
  CategoryModel? get currentCategory => _currentCategory;
  List<ProductModel>? get categoryProducts => _categoryProducts;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadCategories() async {
    setLoading(true);
    try {
      _categories = await _categoriesRepo.getCategories();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _categories = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadCategoryById(String id) async {
    setLoading(true);
    try {
      _currentCategory = await _categoriesRepo.getCategoryById(id);
      _error = null;
    } catch (e) {
      _error = e.toString();
      // Keep previous currentCategory or set to null? Setting to null for now.
      _currentCategory = null;
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadProductsByCategory(String slug) async {
    setLoading(true);
    try {
      _categoryProducts = await _categoriesRepo.getProductsByCategorySlug(slug);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _categoryProducts = [];
    } finally {
      setLoading(false);
    }
  }
}
