// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

import 'package:rivala/models/user_model.dart';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  String? id;
  UserModel? sender;
  String? senderId;
  UserModel? receiver;
  String? receiverId;
  String? content;
  DateTime? createdAt;

  MessageModel({
    this.id,
    this.sender,
    this.senderId,
    this.receiver,
    this.receiverId,
    this.content,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
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

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  final String id;
  final String type;
  final String? title;
  final List<MessageModel> messages;
  final List<Participants> participants;

  ChatModel({
    required this.id,
    required this.type,
    this.title,
    required this.messages,
    required this.participants,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        messages: (json["messages"] as List)
            .map((e) => MessageModel.fromJson(e))
            .toList(),
        participants: (json["participants"] as List)
            .map((e) => Participants.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "messages": messages.map((e) => e.toJson()).toList(),
        "participants": participants.map((e) => e.toJson()).toList(),
      };
}

class Participants {
  final String id;
  final String chatId;
  final String userId;
  final String role;

  Participants({
    required this.id,
    required this.chatId,
    required this.userId,
    required this.role,
  });

  factory Participants.fromJson(Map<String, dynamic> json) => Participants(
        id: json["id"],
        chatId: json["chatId"],
        userId: json["userId"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chatId": chatId,
        "userId": userId,
        "role": role,
      };
}

ChatUser chatUserFromJson(String str) => ChatUser.fromJson(json.decode(str));

String chatUserToJson(ChatUser data) => json.encode(data.toJson());

class ChatUser {
  final String id;
  final String chatId;
  final String name;
  final String? avatarUrl;
  final String? lastMessage;
  final DateTime? lastMessageTime;

  ChatUser({
    required this.id,
    required this.chatId,
    required this.name,
    this.avatarUrl,
    this.lastMessage,
    this.lastMessageTime,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["id"],
        chatId: json["chatId"],
        name: json["name"],
        avatarUrl: json["avatarUrl"],
        lastMessage: json["lastMessage"],
        lastMessageTime: json["lastMessageTime"] != null
            ? DateTime.parse(json["lastMessageTime"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chatId": chatId,
        "name": name,
        "avatarUrl": avatarUrl,
        "lastMessage": lastMessage,
        "lastMessageTime": lastMessageTime?.toIso8601String(),
      };
}
