import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/payment_method_model.dart';

class PaymentMethodsRepo {
  ApiClient api = ApiClient();

  /// Get all payment methods
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    final response = await api.getResponse(endpoints: Endpoints.paymentMethods);
    final list = response['paymentMethods'] as List; // Assuming 'methods' key
    return list.map((item) => PaymentMethodModel.fromJson(item)).toList();
  }

  /// Get payment method by ID
  Future<PaymentMethodModel> getPaymentMethodById(String id) async {
    final response =
        await api.getResponse(endpoints: Endpoints.paymentMethodsById(id));
    return PaymentMethodModel.fromJson(response['paymentMethods']);
  }

  /// Create payment method (e.g. Card)
  Future<PaymentMethodModel> createCardPaymentMethod(
      Map<String, dynamic> data, String type) async {
    final response = await api.postResponse(
      endpoints: Endpoints.paymentMethods,
      data: {
        'type': type.toUpperCase(),
        ...data,
      },
    );
    return PaymentMethodModel.fromJson(response);
  }

  Future<PaymentMethodModel> updatePaymentMethod(
      Map<String, dynamic> data, String type, String id) async {
    final response = await api.patchResponse(
      endpoint: Endpoints.paymentMethodsById(id),
      data: {
        'type': type.toUpperCase(),
        ...data,
      },
    );
    return PaymentMethodModel.fromJson(response);
  }

  /// Delete payment method
  Future<void> deletePaymentMethod(String id) async {
    await api.deleteRequest(endpoint: Endpoints.paymentMethodsById(id));
  }
}
