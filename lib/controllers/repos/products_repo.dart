import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/models/product_model.dart';

import '../../config/network/endpoints.dart';

class ProductsRepo {
  ApiClient api = ApiClient();

  Future<List<ProductModel>> getProductsFeed(String type) async {
    final response =
        await api.getResponse(endpoints: Endpoints.productsFeed, query: {
      'type': type,
    });

    final list = response['products'] as List;

    return list.map((item) => ProductModel.fromJson(item)).toList();
  }

  Future<List<ProductModel>> getForYouPrd(String id) async {
    final response =
        await api.getResponse(endpoints: Endpoints.productRecommendations(id));

    final list = response['products'] as List;
    return list.map((item) => ProductModel.fromJson(item)).toList();
  }

  Future<List<ProductReview>> getPrdReview(String id) async {
    final response =
        await api.getResponse(endpoints: Endpoints.productReview(id));

    final list = response['reviews'] as List;

    return list.map((item) => ProductReview.fromJson(item)).toList();
  }

  // Future<List<ProductModel>> getSearchedProducts() async {
  //   final response = await api.postResponse(
  //     endpoints: Endpoints.searchProduct,
  //   );
  // }

  Future<List<ProductModel>> getMyProducts() async {
    final response = await api.getResponse(endpoints: Endpoints.myProducts);

    final list = response['products'] as List;

    return list.map((item) => ProductModel.fromJson(item)).toList();
  }

  Future<List<ProductModel>> getAllProducts() async {
    final response = await api.getResponse(endpoints: Endpoints.products);

    final list = response['products'] as List;

    return list.map((item) => ProductModel.fromJson(item)).toList();
  }

  Future<void> postProduct(ProductModel product) async {
    await api.postResponse(endpoints: Endpoints.products, data: product);
  }

  Future<void> updateProduct(ProductModel product) async {
    await api.patchResponse(
        endpoint: Endpoints.productsById(product.id!), data: product);
  }

  Future<void> deleteProduct(String id) async {
    await api.deleteRequest(endpoint: Endpoints.productsById(id));
  }
}
