class TaxDocumentModel {
  final String? id;
  final String type;
  final String number;
  final String? documentUrl;
  final bool? isVerified;
  final DateTime? createdAt;

  TaxDocumentModel({
    this.id,
    required this.type,
    required this.number,
    this.documentUrl,
    this.isVerified,
    this.createdAt,
  });

  factory TaxDocumentModel.fromJson(Map<String, dynamic> json) {
    return TaxDocumentModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      number: json['number'] ?? '',
      documentUrl: json['documentUrl'],
      isVerified: json['isVerified'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  /// ✅ ADD THIS
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'number': number,
      'documentUrl': documentUrl,
    };
  }
}
