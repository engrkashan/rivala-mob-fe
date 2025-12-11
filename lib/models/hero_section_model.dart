class HeroSectionModel {
  final String? id;
  final String? storeId;
  final String? header;
  final String? bodyText;
  final String? heroImageUrl;
  final String? logoUrl;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const HeroSectionModel({
    this.id,
    this.storeId,
    this.header,
    this.bodyText,
    this.heroImageUrl,
    this.logoUrl,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory HeroSectionModel.fromJson(Map<String, dynamic> json) {
    return HeroSectionModel(
      id: json['id'] as String?,
      storeId: json['storeId'] as String?,
      header: json['header'] as String?,
      bodyText: json['bodyText'] as String?,
      heroImageUrl: json['heroImageUrl'] as String?,
      logoUrl: json['logoUrl'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'header': header,
      'bodyText': bodyText,
      'heroImageUrl': heroImageUrl,
      'logoUrl': logoUrl,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
