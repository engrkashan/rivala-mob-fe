class WalletModel {
  final double balance;
  final String currency;

  WalletModel({required this.balance, required this.currency});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      balance: (json['balance'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'USD',
    );
  }
}

class TransactionModel {
  final String id;
  final double amount;
  final String type; // credit, debit
  final DateTime date;
  final String description;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
    required this.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: (json['amount'] ?? 0).toDouble(),
      type: json['type'] ?? 'unknown',
      date: DateTime.parse(json['createdAt']),
      description: json['description'] ?? '',
    );
  }
}
