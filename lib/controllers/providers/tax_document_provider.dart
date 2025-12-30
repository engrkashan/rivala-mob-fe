import 'package:flutter/material.dart';
import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';

import '../../models/tax_document.dart';

class TaxDocumentProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<TaxDocumentModel> _documents = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<TaxDocumentModel> get documents => _documents;

  Future<void> fetchTaxDocuments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response =
          await ApiClient().getResponse(endpoints: Endpoints.taxDocument);
      final data = response['documents'] as List;

      _documents = data.map((e) => TaxDocumentModel.fromJson(e)).toList();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createDocument(TaxDocumentModel model) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await ApiClient()
          .postResponse(endpoints: Endpoints.taxDocument, data: model);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateDocument(String id, TaxDocumentModel model) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await ApiClient()
          .patchResponse(endpoint: Endpoints.taxDocumentById(id), data: model);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _documents.clear();
    notifyListeners();
  }
}
