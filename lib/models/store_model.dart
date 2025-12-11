// To parse this JSON data, use
//
//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

import 'package:rivala/models/user_model.dart';

StoreModel storeModelFromJson(String str) =>
    StoreModel.fromJson(json.decode(str));

String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
  String? id;
  String? name;
  String? slug;
  String? logoUrl;
  String? ownerId;
  String? gender;
  String? themeId;
  String? createdAt;
  String? updatedAt;
  UserModel? owner;

  StoreModel(
      {this.id,
      this.name,
      this.slug,
      this.logoUrl,
      this.ownerId,
      this.themeId,
      this.createdAt,
      this.updatedAt,
      this.owner,
      this.gender});

  StoreModel copyWith(
          {String? id,
          String? name,
          String? slug,
          String? logoUrl,
          String? ownerId,
          String? themeId,
          String? createdAt,
          String? updatedAt,
          UserModel? owner,
          String? gender}) =>
      StoreModel(
          id: id ?? this.id,
          name: name ?? this.name,
          slug: slug ?? this.slug,
          logoUrl: logoUrl ?? this.logoUrl,
          ownerId: ownerId ?? this.ownerId,
          themeId: themeId ?? this.themeId,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          owner: owner ?? this.owner,
          gender: gender ?? this.gender);

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        slug: json["slug"],
        logoUrl: json["logoUrl"] ?? json["avatarUrl"],
        ownerId: json["OwnerId"],
        themeId: json["themeId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        owner: json["owner"] != null ? UserModel.fromJson(json["owner"]) : null,
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
        "owner": owner?.toJson(),
        "gender": gender
      };
}
