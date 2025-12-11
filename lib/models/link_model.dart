// To parse this JSON data, do
//
//     final linkModel = linkModelFromJson(jsonString);

import 'dart:convert';

import 'package:rivala/models/store_model.dart';

LinkModel linkModelFromJson(String str) => LinkModel.fromJson(json.decode(str));

String linkModelToJson(LinkModel data) => json.encode(data.toJson());

class LinkModel {
  final String? id;
  final String? name;
  final String? url;
  final String? thumbnailUrl;
  final String? status;
  final StoreModel? store;
  final String? storeId;

  LinkModel({
    this.id,
    this.name,
    this.url,
    this.thumbnailUrl,
    this.status,
    this.store,
    this.storeId,
  });

  LinkModel copyWith({
    String? id,
    String? name,
    String? url,
    String? thumbnailUrl,
    String? status,
    StoreModel? store,
    String? storeId,
  }) =>
      LinkModel(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        status: status ?? this.status,
        store: store ?? this.store,
        storeId: storeId ?? this.storeId,
      );

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
        status: json["status"],
        store:
            json["store"] == null ? null : StoreModel.fromJson(json["store"]),
        storeId: json["storeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
        "status": status,
        "store": store?.toJson(),
        "storeId": storeId,
      };
}
