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

  Future<ThemeModel> createCustomTheme(ThemeModel theme) async {
    final res = await api.postResponse(
      endpoints: Endpoints.customTheme,
      data: theme.toJson(),
    );
    return ThemeModel.fromJson(res['theme']);
  }

  Future<void> attachTheme(String themeId) async {
    await api.patchResponse(
      endpoint: Endpoints.theme,
      data: {'themeId': themeId},
    );
  }

  Future<void> detachTheme() async {
    await api.deleteRequest(endpoint: Endpoints.theme);
  }

  Future<String?> getAttachedThemeId() async {
    final response =
        await api.getResponse(endpoints: Endpoints.currentStoreTheme);
    if (response != null && response['store'] != null) {
      return response['store']['themeId'];
    }
    return null;
  }
}
