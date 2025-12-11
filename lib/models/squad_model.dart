import 'dart:convert';

import 'product_model.dart';
import 'store_model.dart';
import 'user_model.dart';

SquadModel squadModelFromJson(String str) =>
    SquadModel.fromJson(json.decode(str));

String squadModelToJson(SquadModel data) => json.encode(data.toJson());

class SquadModel {
  String? id;
  String? name;
  String? description;
  String? status;
  String? logo;
  List<UserModel>? members;
  List<ProductModel>? products;
  List<StoreModel>? sellers;
  DateTime? createdAt;
  DateTime? updatedAt;

  SquadModel({
    this.id,
    this.name,
    this.description,
    this.status,
    this.logo,
    this.members,
    this.products,
    this.sellers,
    this.createdAt,
    this.updatedAt,
  });

  factory SquadModel.fromJson(Map<String, dynamic> json) => SquadModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        logo: json["logo"],
        members: json["members"] == null
            ? []
            : List<UserModel>.from(
                json["members"]!.map((x) => UserModel.fromJson(x["user"]))),
        products: json["products"] == null
            ? []
            : List<ProductModel>.from(
                json["products"]!.map((x) => ProductModel.fromJson(x))),
        sellers: json["sellers"] == null
            ? []
            : List<StoreModel>.from(
                json["sellers"]!.map((x) => StoreModel.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "logo": logo,
        "members": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "sellers": sellers == null
            ? []
            : List<dynamic>.from(sellers!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
