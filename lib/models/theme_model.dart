import 'dart:convert';

import 'package:rivala/models/store_model.dart';
import 'package:rivala/models/user_model.dart';

ThemeModel themeModelFromJson(String str) =>
    ThemeModel.fromJson(json.decode(str));

String themeModelToJson(ThemeModel data) => json.encode(data.toJson());

class ThemeModel {
  String? id;
  String? name;
  String? coverImage;

  /// Always stores color in #RRGGBB format
  String? colorDark;
  String? color1;
  String? color2;
  String? color3;
  String? colorLight;

  String? primaryFont;
  String? secondaryFont;
  String? bodyFont;

  bool? isCustom;
  UserModel? creator;
  DateTime? createdAt;
  StoreModel? store;

  ThemeModel({
    this.id,
    this.name,
    this.coverImage,
    this.colorDark,
    this.color1,
    this.color2,
    this.color3,
    this.colorLight,
    this.primaryFont,
    this.secondaryFont,
    this.bodyFont,
    this.isCustom,
    this.creator,
    this.createdAt,
    this.store,
  }) {
    /// Normalize all color fields as #RRGGBB
    colorDark = _normalizeColor(colorDark);
    color1 = _normalizeColor(color1);
    color2 = _normalizeColor(color2);
    color3 = _normalizeColor(color3);
    colorLight = _normalizeColor(colorLight);
  }

  /// -----------------------
  /// JSON FACTORY
  /// -----------------------
  factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
        id: json["id"],
        name: json["name"],
        coverImage: json["coverImage"],
        colorDark: json["colorDark"],
        color1: json["color1"],
        color2: json["color2"],
        color3: json["color3"],
        colorLight: json["colorLight"],
        primaryFont: json["primaryFont"],
        secondaryFont: json["secondaryFont"],
        bodyFont: json["bodyFont"],
        isCustom: json["isCustom"],
        creator: json["creator"] == null
            ? null
            : UserModel.fromJson(json["creator"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        store:
            json["store"] == null ? null : StoreModel.fromJson(json["store"]),
      );

  /// -----------------------
  /// JSON OUTPUT
  /// -----------------------
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coverImage": coverImage,
        "colorDark": colorDark,
        "color1": color1,
        "color2": color2,
        "color3": color3,
        "colorLight": colorLight,
        "primaryFont": primaryFont,
        "secondaryFont": secondaryFont,
        "bodyFont": bodyFont,
        "isCustom": isCustom,
        "creator": creator?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "store": store?.toJson(),
      };

  /// -----------------------
  /// Color Normalization
  /// -----------------------
  /// Converts any ARGB / RGB / RRGGBB to #RRGGBB
  String? _normalizeColor(String? hex) {
    if (hex == null || hex.isEmpty) return null;

    String value = hex.replaceAll("#", "").toUpperCase();

    // ARGB → Remove alpha
    if (value.length == 8) {
      value = value.substring(2); // Remove FF
    }

    // Already correct RRGGBB
    if (value.length == 6) {
      return "#$value";
    }

    // Convert #RGB → #RRGGBB
    if (value.length == 3) {
      value = value.split('').map((c) => "$c$c").join();
      return "#$value";
    }

    return "#000000"; // fallback safe color
  }
}
