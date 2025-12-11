// To parse this JSON data, do
//
//     final collectionModel = collectionModelFromJson(jsonString);

import 'dart:convert';

import 'package:rivala/models/product_model.dart';
import 'package:rivala/models/store_model.dart';
import 'package:rivala/models/user_model.dart';

CollectionModel collectionModelFromJson(String str) =>
    CollectionModel.fromJson(json.decode(str));

String collectionModelToJson(CollectionModel data) =>
    json.encode(data.toJson());

class CollectionModel {
  final String? id;
  final String? name;
  final String? description;
  final StoreModel? store;
  final String? storeId;
  final List<ProductModel>? products; // <-- FIXED: List instead of single
  final List<UserModel>? squadMembers;

  CollectionModel({
    this.id,
    this.name,
    this.description,
    this.store,
    this.storeId,
    this.products,
    this.squadMembers,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      store: json["store"] == null ? null : StoreModel.fromJson(json["store"]),
      storeId: json["storeId"],

      // -------------------------
      // FIX: Parse products list
      // -------------------------
      products: json["products"] == null
          ? []
          : List<ProductModel>.from(
              json["products"].map((x) => ProductModel.fromJson(x)),
            ),

      // Squad members list
      squadMembers: json["squadMembers"] == null
          ? []
          : List<UserModel>.from(
              json["squadMembers"].map((x) => UserModel.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "store": store?.toJson(),
        "storeId": storeId,

        // FIX: Send products list to API
        "products": products?.map((x) => x.toJson()).toList(),

        "squadMembers": squadMembers?.map((x) => x.toJson()).toList(),
      };
}
