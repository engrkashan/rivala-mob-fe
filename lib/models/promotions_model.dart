// To parse this JSON data, do
//
//     final promotionModel = promotionModelFromJson(jsonString);

import 'dart:convert';

import 'package:rivala/models/product_model.dart';
import 'package:rivala/models/user_model.dart';

PromotionModel promotionModelFromJson(String str) =>
    PromotionModel.fromJson(json.decode(str));

String promotionModelToJson(PromotionModel data) => json.encode(data.toJson());

class PromotionModel {
  final String? id;
  final String? title;
  final String? description;
  final double? discount;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final String? promoCode;
  final String? targetAudience; // NEW
  final List<PromotionTargetModel>? targets; // NEW
  final List<PromotionCriteriaModel>? criteria; // NEW
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? createdBy;
  final ProductModel? product;

  PromotionModel({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
    this.promoCode,
    this.targetAudience,
    this.targets,
    this.criteria,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.product,
    this.discount,
  });

  PromotionModel copyWith({
    String? id,
    String? title,
    String? description,
    double? discount,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? promoCode,
    String? targetAudience,
    List<PromotionTargetModel>? targets,
    List<PromotionCriteriaModel>? criteria,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? createdBy,
    ProductModel? product,
  }) =>
      PromotionModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        discount: discount ?? this.discount,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        status: status ?? this.status,
        promoCode: promoCode ?? this.promoCode,
        targetAudience: targetAudience ?? this.targetAudience,
        targets: targets ?? this.targets,
        criteria: criteria ?? this.criteria,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        createdBy: createdBy ?? this.createdBy,
        product: product ?? this.product,
      );

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        discount: json["discount"]?.toDouble(),
        startDate: _parseDate(json["startDate"]),
        endDate: _parseDate(json["endDate"]),
        status: json["status"],
        promoCode: json["promoCode"],
        targetAudience: json["targetAudience"],
        targets: json["targets"] == null
            ? []
            : List<PromotionTargetModel>.from(
                json["targets"].map((x) => PromotionTargetModel.fromJson(x))),
        criteria: json["criteria"] == null
            ? []
            : List<PromotionCriteriaModel>.from(json["criteria"]
                .map((x) => PromotionCriteriaModel.fromJson(x))),
        createdAt: _parseDate(json["createdAt"]),
        updatedAt: _parseDate(json["updatedAt"]),
        createdBy: json["createdBy"] == null
            ? null
            : UserModel.fromJson(json["createdBy"]),
        product: json["product"] == null
            ? null
            : ProductModel.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "discount": discount,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "status": status,
        "promoCode": promoCode,
        "targetAudience": targetAudience,
        "targets": targets?.map((x) => x.toJson()).toList(),
        "criteria": criteria?.map((x) => x.toJson()).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdBy": createdBy?.toJson(),
        "product": product?.toJson(),
      };

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;

    if (value is DateTime) return value;

    if (value is String) {
      // try default parser
      final iso = DateTime.tryParse(value);
      if (iso != null) return iso;

      // try replacing '/' with '-'
      final fixed = DateTime.tryParse(value.replaceAll('/', '-'));
      if (fixed != null) return fixed;
    }

    return null;
  }
}

class PromotionCriteriaModel {
  final String? id;
  final String? condition;
  final String? action;

  PromotionCriteriaModel({this.id, this.condition, this.action});

  factory PromotionCriteriaModel.fromJson(Map<String, dynamic> json) =>
      PromotionCriteriaModel(
        id: json["id"],
        condition: json["condition"],
        action: json["action"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "condition": condition,
        "action": action,
      };
}

class PromotionTargetModel {
  final String? id;
  final String? targetType;
  final String? productId;
  final String? collectionId;

  PromotionTargetModel({
    this.id,
    this.targetType,
    this.productId,
    this.collectionId,
  });

  factory PromotionTargetModel.fromJson(Map<String, dynamic> json) =>
      PromotionTargetModel(
        id: json["id"],
        targetType: json["targetType"],
        productId: json["productId"],
        collectionId: json["collectionId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "targetType": targetType,
        "type": targetType, // Backend expects 'type'
        "productId": productId,
        "collectionId": collectionId,
        "promo_id": productId ??
            collectionId, // In some cases, 'id' is used for the item id
        "id_val": productId ?? collectionId, // fallback
      };
}
