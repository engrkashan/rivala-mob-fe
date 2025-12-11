import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/promotions_model.dart';

class PromoRepo {
  ApiClient api = ApiClient();

  Future<List<PromotionModel>> getPromos() async {
    final res = await api.getResponse(endpoints: Endpoints.promotions);
    final list = res["promotions"] as List;

    return list.map((e) => PromotionModel.fromJson(e)).toList();
  }

  Future<void> createPromo(PromotionModel model) async {
    await api.postResponse(endpoints: Endpoints.promotions, data: model);
  }
}
