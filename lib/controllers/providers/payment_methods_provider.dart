import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/payment_methods_repo.dart';
import 'package:rivala/models/payment_method_model.dart';

class PaymentMethodsProvider extends ChangeNotifier {
  final _paymentMethodsRepo = PaymentMethodsRepo();

  bool _isLoading = false;
  String? _error;
  List<PaymentMethodModel>? _paymentMethods;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<PaymentMethodModel>? get paymentMethods => _paymentMethods;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadPaymentMethods() async {
    setLoading(true);
    try {
      _paymentMethods = await _paymentMethodsRepo.getPaymentMethods();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _paymentMethods = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> addPaymentMethod(Map<String, dynamic> data) async {
    setLoading(true);
    try {
      await _paymentMethodsRepo.createCardPaymentMethod(data);
      // Reload list to show new method
      await loadPaymentMethods();
      _error = null;
    } catch (e) {
      _error = e.toString();
      // Rethrow to let UI handle specific error display if needed
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
