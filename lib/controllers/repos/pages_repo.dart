import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/page_model.dart';

class PagesRepo {
  ApiClient api = ApiClient();

  /// Get page by ID
  Future<PageModel> getPageById(String id) async {
    final response = await api.getResponse(endpoints: Endpoints.pagesById(id));
    return PageModel.fromJson(response);
  }

  /// Get page by Slug
  Future<PageModel> getPageBySlug(String slug) async {
    final response =
        await api.getResponse(endpoints: Endpoints.pagesBySlug(slug));
    return PageModel.fromJson(response);
  }

  /// List all pages for the seller's store
  Future<List<PageModel>> listPages() async {
    final response = await api.getResponse(endpoints: Endpoints.pages);
    final list = (response['pages'] as List);
    return list.map((e) => PageModel.fromJson(e)).toList();
  }

  /// Create a new page
  Future<PageModel> createPage({
    required String title,
    required String slug,
    bool isVisible = true,
  }) async {
    final response = await api.postResponse(
      endpoints: Endpoints.pages,
      data: {
        'title': title,
        'slug': slug,
        'isVisible': isVisible,
      },
    );
    return PageModel.fromJson(response['page']);
  }

  /// Update an existing page
  Future<PageModel> updatePage({
    required String id,
    String? title,
    int? order,
    bool? isVisible,
    List<Map<String, dynamic>>? sections,
  }) async {
    final data = <String, dynamic>{};
    if (title != null) data['title'] = title;
    if (order != null) data['order'] = order;
    if (isVisible != null) data['isVisible'] = isVisible;
    if (sections != null) data['sections'] = sections;

    final response = await api.patchResponse(
      endpoint: Endpoints.pagesById(id),
      data: data,
    );
    return PageModel.fromJson(response['page']);
  }

  /// Delete a page
  Future<void> deletePage(String id) async {
    await api.deleteRequest(endpoint: Endpoints.pagesById(id));
  }

  /// Update page title (and slug)
  Future<PageModel> updatePageTitle({
    required String id,
    required String title,
  }) async {
    final response = await api.patchResponse(
      endpoint: Endpoints.updatePageTitle(id),
      data: {'title': title},
    );
    return PageModel.fromJson(response['page']);
  }
}
