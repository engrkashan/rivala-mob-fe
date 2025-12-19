// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:rivala/models/fulfillment.dart';
import 'package:rivala/models/payment_model.dart';
import 'package:rivala/models/product_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? buyerId;

  ProductModel? product; // <-- FIXED (single object)
  String? productId;
  PaymentModel? payment;
  String? status;
  ShippingAddress? shippingAddress;
  FulfillmentModel? fulFillment;

  List<OrdersItem>? orderItems; // <-- FIXED name

  OrderModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.buyerId,
    this.product,
    this.productId,
    this.payment,
    this.status,
    this.shippingAddress,
    this.fulFillment,
    this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        buyerId: json["buyerId"],

        /// API returns product as a single object
        product: json["product"] == null
            ? null
            : ProductModel.fromJson(json["product"]),

        productId: json["productId"],
        payment: json["Payment"] == null
            ? null
            : PaymentModel.fromJson(json["Payment"]),
        status: json["status"],

        shippingAddress: json["shippingAddress"] == null
            ? null
            : ShippingAddress.fromJson(json["shippingAddress"]),

        fulFillment: json["fulFillment"] == null
            ? null
            : FulfillmentModel.fromJson(json["fulFillment"]),

        orderItems: json["OrderItem"] == null
            ? null
            : List<OrdersItem>.from(
                json["OrderItem"].map((x) => OrdersItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "buyerId": buyerId,
        "product": product?.toJson(),
        "productId": productId,
        "Payment": payment?.toJson(),
        "status": status,
        "shippingAddress": shippingAddress?.toJson(),
        "fulFillment": fulFillment?.toJson(),
        "OrderItem": orderItems == null
            ? null
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
}

class OrdersItem {
  String? id;
  String? orderId;
  ProductModel? product;
  String? productId;
  int? quantity;
  double? price;

  OrdersItem({
    this.id,
    this.orderId,
    this.product,
    this.productId,
    this.quantity,
    this.price,
  });

  factory OrdersItem.fromJson(Map<String, dynamic> json) => OrdersItem(
        id: json["id"],
        orderId: json["orderId"],
        product: json["product"] == null
            ? null
            : ProductModel.fromJson(json["product"]),
        productId: json["productId"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "product": product?.toJson(),
        "productId": productId,
        "quantity": quantity,
        "price": price,
      };
}

class ShippingAddress {
  String? address;

  ShippingAddress({
    this.address,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
      };
}
