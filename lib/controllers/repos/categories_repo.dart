import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/category_model.dart';
import 'package:rivala/models/product_model.dart';

class CategoriesRepo {
  ApiClient api = ApiClient();

  /// Get all categories
  Future<List<CategoryModel>> getCategories() async {
    final response = await api.getResponse(endpoints: Endpoints.categories);
    final list = response['categories'] as List;
    return list.map((item) => CategoryModel.fromJson(item)).toList();
  }

  /// Get category by ID
  Future<CategoryModel> getCategoryById(String id) async {
    final response =
        await api.getResponse(endpoints: Endpoints.categoryById(id));
    return CategoryModel.fromJson(response);
  }

  /// Get products by category slug
  Future<List<ProductModel>> getProductsByCategorySlug(String slug) async {
    final response =
        await api.getResponse(endpoints: Endpoints.categoryBySlud(slug));
    final list = response['products'] as List;
    return list.map((item) => ProductModel.fromJson(item)).toList();
  }
}
