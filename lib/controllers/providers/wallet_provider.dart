import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/wallet_repo.dart';
import 'package:rivala/models/wallet_model.dart';

class WalletProvider extends ChangeNotifier {
  final WalletRepo _repo = WalletRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = "";
  String get error => _error;

  WalletModel? _wallet;
  WalletModel? get wallet => _wallet;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadWalletData() async {
    setLoading(true);
    _error = "";
    try {
      _wallet = await _repo.getBalance();
      _transactions = await _repo.getTransactions();
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> requestPayout(double amount) async {
    setLoading(true);
    _error = "";
    try {
      await _repo.requestPayout(amount);
      await loadWalletData(); // Refresh balance
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
