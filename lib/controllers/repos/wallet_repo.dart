import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/wallet_model.dart';

class WalletRepo {
  final ApiClient _api = ApiClient();

  Future<WalletModel> getBalance() async {
    final res = await _api.getResponse(endpoints: Endpoints.walletBalance);
    return WalletModel.fromJson(res);
  }

  Future<List<TransactionModel>> getTransactions() async {
    final res = await _api.getResponse(endpoints: Endpoints.walletTransactions);
    final list = res['transactions'] as List;
    return list.map((e) => TransactionModel.fromJson(e)).toList();
  }

  Future<void> requestPayout(double amount) async {
    await _api.postResponse(
      endpoints: Endpoints.walletPayout,
      data: {'amount': amount},
    );
  }
}
