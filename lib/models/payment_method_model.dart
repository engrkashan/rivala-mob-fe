class PaymentMethodModel {
  final String? id;
  final String? userId;
  final String? type; // CARD, BANK, DIGITAL_WALLET
  final String? cardholderName;
  final String? cardNumber; // Likely masked from backend
  final String? expirationDate;
  final String? cvc;
  final String? bankName;
  final String? accountNumber;
  final String? routingNumber;
  final String? walletProvider;
  final bool? isDefault;

  const PaymentMethodModel({
    this.id,
    this.userId,
    this.type,
    this.cardholderName,
    this.cardNumber,
    this.expirationDate,
    this.cvc,
    this.bankName,
    this.accountNumber,
    this.routingNumber,
    this.walletProvider,
    this.isDefault,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      type: json['type'] as String?,
      cardholderName: json['cardholderName'] as String?,
      cardNumber: json['cardNumber'] as String?,
      expirationDate: json['expirationDate'] as String?,
      cvc: json['cvc'] as String?,
      bankName: json['bankName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      routingNumber: json['routingNumber'] as String?,
      walletProvider: json['walletProvider'] as String?,
      isDefault: json['isDefault'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'cardholderName': cardholderName,
      'cardNumber': cardNumber,
      'expirationDate': expirationDate,
      'cvc': cvc,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'routingNumber': routingNumber,
      'walletProvider': walletProvider,
      'isDefault': isDefault,
    };
  }
}
