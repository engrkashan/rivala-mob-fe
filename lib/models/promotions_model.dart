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
