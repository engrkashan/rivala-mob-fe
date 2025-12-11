import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/controllers/providers/brands_provider.dart';
import 'package:rivala/models/link_model.dart';

class LinkRepo {
  ApiClient api = ApiClient();

  Future<List<LinkModel>> getLinks(BuildContext context) async {
    await context.read<BrandsProvider>().loadCurrentStore();
    final storeId = context.read<BrandsProvider>().currentStore?.id;
    final res = await api
        .getResponse(endpoints: Endpoints.links, query: {"storeId": storeId});
    final list = res['links'] as List;
    return list.map((e) => LinkModel.fromJson(e)).toList();
  }

  Future<void> createLink(LinkModel link) async {
    await api.postResponse(endpoints: Endpoints.links, data: link);
  }
}
