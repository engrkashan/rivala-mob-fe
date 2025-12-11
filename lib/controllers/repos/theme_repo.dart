import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/theme_model.dart';

class ThemeRepo {
  ApiClient api = ApiClient();

  Future<List<ThemeModel>> getAllThemes() async {
    final response = await api.getResponse(endpoints: Endpoints.theme);
    List<ThemeModel> themes = (response['themes'] as List)
        .map((themeJson) => ThemeModel.fromJson(themeJson))
        .toList();
    return themes;
  }

  Future<void> createCustomTheme(ThemeModel theme) async {
    final res = await api.postResponse(
      endpoints: Endpoints.customTheme,
      data: theme,
    );
  }
}
