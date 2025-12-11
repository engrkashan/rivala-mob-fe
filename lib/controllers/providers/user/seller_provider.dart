import 'package:flutter/widgets.dart';

import '../../../models/user_model.dart';
import '../../repos/seller_repo.dart';

class SellerProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<UserModel> _filteredSeller = [];
  List<UserModel> get filteredSeller => _filteredSeller;
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  List<UserModel> _sellers = [];
  List<UserModel> get sellers => _sellers;

  String _error = '';
  String get error => _error;

  SellerRepo _repo = SellerRepo();

  Future<void> loadAllUsers() async {
    setLoading(true);
    try {
      _sellers = await _repo.getAllUsers();
      _filteredSeller = _sellers;
      _error = '';
    } catch (e) {
      _sellers = [];
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  void searchSellers(String query) {
    if (query.isEmpty) {
      _filteredSeller = _sellers;
    } else {
      _filteredSeller = _sellers
          .where((squad) =>
              squad.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
