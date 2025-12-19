import 'dart:convert';

import 'package:rivala/models/user_model.dart';
import 'package:rivala/models/collection_model.dart';
import 'package:rivala/models/product_model.dart';
import 'package:rivala/models/link_model.dart';
import 'package:rivala/models/follow_model.dart';

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
  List<CollectionModel> collections;
  List<ProductModel> products;
  List<LinkModel> links;
  List<FollowModel> followers;
  List<FollowModel> followings;

  StoreModel({
    this.id,
    this.name,
    this.slug,
    this.logoUrl,
    this.ownerId,
    this.gender,
    this.themeId,
    this.createdAt,
    this.updatedAt,
    this.owner,
    List<CollectionModel>? collections,
    List<ProductModel>? products,
    List<LinkModel>? links,
    List<FollowModel>? followers,
    List<FollowModel>? followings,
  })  : collections = collections ?? [],
        products = products ?? [],
        links = links ?? [],
        followers = followers ?? [],
        followings = followings ?? [];

  // ---------------- COPY WITH ----------------

  StoreModel copyWith({
    String? id,
    String? name,
    String? slug,
    String? logoUrl,
    String? ownerId,
    String? gender,
    String? themeId,
    String? createdAt,
    String? updatedAt,
    UserModel? owner,
    List<CollectionModel>? collections,
    List<ProductModel>? products,
    List<LinkModel>? links,
    List<FollowModel>? followers,
    List<FollowModel>? followings,
  }) {
    return StoreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      logoUrl: logoUrl ?? this.logoUrl,
      ownerId: ownerId ?? this.ownerId,
      gender: gender ?? this.gender,
      themeId: themeId ?? this.themeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      owner: owner ?? this.owner,
      collections: collections ?? this.collections,
      products: products ?? this.products,
      links: links ?? this.links,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
    );
  }

  // ---------------- FROM JSON ----------------

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      gender: json["gender"],
      logoUrl: json["logoUrl"] ?? json["avatarUrl"],
      ownerId: json["ownerId"] ?? json["OwnerId"],
      themeId: json["themeId"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      owner: json["owner"] != null ? UserModel.fromJson(json["owner"]) : null,
      collections: (json["collections"] as List?)
              ?.map((e) => CollectionModel.fromJson(e))
              .toList() ??
          [],
      products: (json["products"] as List?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
          [],
      links: (json["links"] as List?)
              ?.map((e) => LinkModel.fromJson(e))
              .toList() ??
          [],
      followers: (json["followers"] as List?)
              ?.map((e) => FollowModel.fromJson(e))
              .toList() ??
          [],
      followings: (json["followings"] as List?)
              ?.map((e) => FollowModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  // ---------------- TO JSON ----------------

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "logoUrl": logoUrl,
      "ownerId": ownerId,
      "gender": gender,
      "themeId": themeId,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "owner": owner?.toJson(),
      "collections": collections.map((e) => e.toJson()).toList(),
      "products": products.map((e) => e.toJson()).toList(),
      "links": links.map((e) => e.toJson()).toList(),
      "followers": followers.map((e) => e.toJson()).toList(),
      "followings": followings.map((e) => e.toJson()).toList(),
    };
  }
}
