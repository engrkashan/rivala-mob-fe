import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/controllers/providers/product_provider.dart';

import '../../models/collection_model.dart';
import '../repos/collections_repo.dart';

class CollectionProvider extends ChangeNotifier {
  List<CollectionModel> _allCollections = [];
  List<CollectionModel> get allCollections => _allCollections;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  String _error = '';
  String get error => _error;

  Future<void> loadAllCollections() async {
    setLoading(true);
    try {
      _allCollections = await CollectionsRepo().getCollectionsList();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> setCollection(
      String name, String desc, BuildContext context) async {
    setLoading(true);
    final prdId = context
        .read<ProductProvider>()
        .selectedMembers
        .map((e) => e.id)
        .whereType<String>() // removes nulls and casts to String
        .toList();

    try {
      final col = await CollectionsRepo().createCollection(name, desc, prdId);
      _allCollections.add(col);
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteCollection(String id) async {
    setLoading(true);
    try {
      await CollectionsRepo().deleteCollection(id);
      _allCollections.removeWhere((element) => element.id == id);
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> addProductToCollection(
      String collectionId, String productId) async {
    // Ideally we fetch the specific collection first to get its current products,
    // but for now we assume we can just send the update if we want to add one.
    // Or we simply update the local list if we have it.

    // Find collection
    final index = _allCollections.indexWhere((c) => c.id == collectionId);
    if (index == -1) return;

    final col = _allCollections[index];
    final currentIds = col.products?.map((p) => p.id!).toList() ?? [];
    if (!currentIds.contains(productId)) {
      currentIds.add(productId);
    }

    setLoading(true);
    try {
      await CollectionsRepo().updateCollection(collectionId, {
        "name": col.name,
        "description": col.description,
        "productIds": currentIds
      });
      // Update local (reload to be safe or update local model)
      await loadAllCollections();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
