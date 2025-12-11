import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/hero_section_model.dart';

class HeroSectionRepo {
  ApiClient api = ApiClient();

  /// Get hero section
  Future<HeroSectionModel> getHeroSection() async {
    final response = await api.getResponse(endpoints: Endpoints.heroSection);
    return HeroSectionModel.fromJson(response);
  }

  // Note: endpoints.dart doesn't have update/create endpoints explicitly named for hero section
  // other than base /heroSection, suggesting GET might be the primary one or POST/PUT to same URL.
}
