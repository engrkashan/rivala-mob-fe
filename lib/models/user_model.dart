// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? username;
  String? email;
  String? password;
  String? gender;
  DateTime? birthday;
  String? bio;
  List<String>? profileLinks;
  String? avatarUrl;
  String? role;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.password,
    this.gender,
    this.birthday,
    this.bio,
    this.profileLinks,
    this.avatarUrl,
    this.role,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        bio: json["bio"],
        profileLinks: json["profileLinks"] == null
            ? []
            : List<String>.from(json["profileLinks"]!.map((x) => x)),
        avatarUrl: json["avatarUrl"],
        role: json["role"],
        isActive: json["isActive"],
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
        "username": username,
        "email": email,
        "password": password,
        "gender": gender,
        "birthday": birthday?.toIso8601String(),
        "bio": bio,
        "profileLinks": profileLinks == null
            ? []
            : List<dynamic>.from(profileLinks!.map((x) => x)),
        "avatarUrl": avatarUrl,
        "role": role,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
