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

  Future<void> setCollection(String name, String desc, BuildContext context,
      {List<String>? productIds}) async {
    setLoading(true);
    final prdId = productIds ??
        context
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
    // Find collection
    final index = _allCollections.indexWhere((c) => c.id == collectionId);
    if (index == -1) return;

    final col = _allCollections[index];
    final currentIds = col.products?.map((p) => p.id!).toList() ?? [];
    if (!currentIds.contains(productId)) {
      currentIds.add(productId);
    } else {
      // Already exists
      return;
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

  Future<void> removeProductFromCollection(
      String collectionId, String productId) async {
    final index = _allCollections.indexWhere((c) => c.id == collectionId);
    if (index == -1) return;

    final col = _allCollections[index];
    final currentIds = col.products?.map((p) => p.id!).toList() ?? [];

    if (currentIds.contains(productId)) {
      currentIds.remove(productId);
    } else {
      return;
    }

    setLoading(true);
    try {
      await CollectionsRepo().updateCollection(collectionId, {
        "name": col.name,
        "description": col.description,
        "productIds": currentIds
      });
      await loadAllCollections();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateCollectionDetails(
      String collectionId, String name, String description) async {
    final index = _allCollections.indexWhere((c) => c.id == collectionId);
    if (index == -1) return;

    final col = _allCollections[index];

    // Check if anything actually changed to avoid unnecessary API calls
    if (col.name == name && col.description == description) return;

    final currentIds = col.products?.map((p) => p.id!).toList() ?? [];

    setLoading(true);
    try {
      await CollectionsRepo().updateCollection(collectionId,
          {"name": name, "description": description, "productIds": currentIds});
      await loadAllCollections();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
