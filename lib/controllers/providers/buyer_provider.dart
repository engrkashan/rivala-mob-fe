import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/buyer_repo.dart';
import 'package:rivala/models/buyer_model.dart';

class BuyerProvider extends ChangeNotifier {
  final _buyerRepo = BuyerRepo();

  bool _isLoading = false;
  String? _error;
  BuyerModel? _currentBuyer;

  bool get isLoading => _isLoading;
  String? get error => _error;
  BuyerModel? get currentBuyer => _currentBuyer;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadBuyerProfile() async {
    setLoading(true);
    try {
      _currentBuyer = await _buyerRepo.getBuyerProfile();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _currentBuyer = null;
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadBuyerById(String id) async {
    setLoading(true);
    try {
      // Typically used for admin or viewing other public profiles if applicable
      // Storing in same _currentBuyer or different variable?
      // Assuming this is viewing "my" buyer profile primarily.
      // If fetching another, might need separate state.
      // For now, replacing _currentBuyer.
      _currentBuyer = await _buyerRepo.getBuyerById(id);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
