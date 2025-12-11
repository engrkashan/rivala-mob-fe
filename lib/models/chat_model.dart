// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

import 'package:rivala/models/user_model.dart';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  String? id;
  UserModel? sender;
  String? senderId;
  UserModel? receiver;
  String? receiverId;
  String? content;
  DateTime? createdAt;

  ChatModel({
    this.id,
    this.sender,
    this.senderId,
    this.receiver,
    this.receiverId,
    this.content,
    this.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        sender:
            json["sender"] == null ? null : UserModel.fromJson(json["sender"]),
        senderId: json["senderId"],
        receiver: json["receiver"] == null
            ? null
            : UserModel.fromJson(json["receiver"]),
        receiverId: json["receiverId"],
        content: json["content"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender": sender?.toJson(),
        "senderId": senderId,
        "receiver": receiver?.toJson(),
        "receiverId": receiverId,
        "content": content,
        "createdAt": createdAt?.toIso8601String(),
      };
}
