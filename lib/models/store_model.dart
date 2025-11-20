// To parse this JSON data, do
//
//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

StoreModel storeModelFromJson(String str) =>
    StoreModel.fromJson(json.decode(str));

String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
  String? id;
  String? name;
  String? slug;
  String? logoUrl;
  String? ownerId;
  String? themeId;
  String? createdAt;
  String? updatedAt;

  StoreModel({
    this.id,
    this.name,
    this.slug,
    this.logoUrl,
    this.ownerId,
    this.themeId,
    this.createdAt,
    this.updatedAt,
  });

  StoreModel copyWith({
    String? id,
    String? name,
    String? slug,
    String? logoUrl,
    String? ownerId,
    String? themeId,
    String? createdAt,
    String? updatedAt,
  }) =>
      StoreModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        logoUrl: logoUrl ?? this.logoUrl,
        ownerId: ownerId ?? this.ownerId,
        themeId: themeId ?? this.themeId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        logoUrl: json["logoUrl"],
        ownerId: json["OwnerId"],
        themeId: json["themeId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "logoUrl": logoUrl,
        "OwnerId": ownerId,
        "themeId": themeId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
