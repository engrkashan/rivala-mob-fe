// To parse this JSON data, do
//
//     final fulfillmentProvider = fulfillmentProviderFromJson(jsonString);

import 'dart:convert';

import 'package:rivala/models/fulfillment.dart';
import 'package:rivala/models/order_model.dart';
import 'package:rivala/models/store_model.dart';

FulfillmentProvider fulfillmentProviderFromJson(String str) =>
    FulfillmentProvider.fromJson(json.decode(str));

String fulfillmentProviderToJson(FulfillmentProvider data) =>
    json.encode(data.toJson());

class FulfillmentProvider {
  String? id;
  String? type;
  String? name;
  String? apiKey;
  String? apiSecret;
  String? contactEmail;
  StoreModel? store;
  OrderModel? order;
  FulfillmentModel? fulfillment;

  FulfillmentProvider({
    this.id,
    this.type,
    this.name,
    this.apiKey,
    this.apiSecret,
    this.contactEmail,
    this.store,
    this.order,
    this.fulfillment,
  });

  factory FulfillmentProvider.fromJson(Map<String, dynamic> json) =>
      FulfillmentProvider(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        apiKey: json["apiKey"],
        apiSecret: json["apiSecret"],
        contactEmail: json["contactEmail"],
        store:
            json["store"] == null ? null : StoreModel.fromJson(json["store"]),
        order:
            json["order"] == null ? null : OrderModel.fromJson(json["order"]),
        fulfillment: json["fulfillment"] == null
            ? null
            : FulfillmentModel.fromJson(json["fulfillment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "apiKey": apiKey,
        "apiSecret": apiSecret,
        "contactEmail": contactEmail,
        "store": store?.toJson(),
        "order": order?.toJson(),
        "fulfillment": fulfillment?.toJson(),
      };
}
