import 'dart:convert';

import 'package:collection/collection.dart'; // For deep equality on lists
import 'package:rivala/models/store_model.dart';
import 'package:rivala/models/user_model.dart';

class ProductModel {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? sku;
  final int? stockQuantity;
  final bool? isActive;
  final int? purchaseCount;
  final double? revenue;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? latitude;
  final double? longitude;
  final String? country;
  final UserModel? owner;
  final String? ownerId;
  final List<String>? image;
  final StoreModel? store;
  final String? storeId;
  final List<String>? sizes;
  final List<String>? colors;
  final List<ProductReview>? reviews; // Fixed typo: review → reviews

  /// Const constructor
  const ProductModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.sku,
    this.stockQuantity,
    this.isActive,
    this.purchaseCount,
    this.revenue,
    this.createdAt,
    this.updatedAt,
    this.latitude,
    this.longitude,
    this.country,
    this.owner,
    this.ownerId,
    this.image,
    this.store,
    this.storeId,
    this.sizes,
    this.colors,
    this.reviews,
  });

  /// Factory from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      sku: json['sku'] as String?,
      stockQuantity: json['stockQuantity'] as int?,
      isActive: json['isActive'] as bool?,
      purchaseCount: json['purchaseCount'] as int?,
      revenue: (json['revenue'] as num?)?.toDouble(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      country: json['country'] as String?,
      owner: json['owner'] != null
          ? UserModel.fromJson(json['owner'] as Map<String, dynamic>)
          : null,
      ownerId: json['ownerId'] as String?,
      storeId: json['storeId'] as String?,
      store: json['store'] != null
          ? StoreModel.fromJson(json['store'] as Map<String, dynamic>)
          : null,
      // Images: handle both [{url: "..."}] and direct ["url1", "url2"]
      image: _parseImageList(json['images'] ?? json['image']),
      // Sizes: handle both [{size: "M"}] and ["M", "L"]
      sizes: _parseSizeList(json['sizes']),
      // Colors: handle both [{hexCode: "#FF0000"}] and ["#FF0000"]
      colors: _parseColorList(json['hexCode'] ?? json['colors']),
      // Reviews
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ProductReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // Helper methods for flexible parsing
  static List<String>? _parseImageList(dynamic data) {
    if (data == null) return null;
    if (data is List) {
      return data
          .map((e) {
            if (e is String) return e;
            if (e is Map<String, dynamic>) return e['url'] as String?;
            return null;
          })
          .whereType<String>()
          .toList();
    }
    return null;
  }

  static List<String>? _parseSizeList(dynamic data) {
    if (data == null) return null;
    if (data is List) {
      return data
          .map((e) {
            if (e is String) return e;
            if (e is Map<String, dynamic>) return e['size'] as String?;
            return null;
          })
          .whereType<String>()
          .toList();
    }
    return null;
  }

  static List<String>? _parseColorList(dynamic data) {
    if (data == null) return null;
    if (data is List) {
      return data
          .map((e) {
            if (e is String) return e;
            if (e is Map<String, dynamic>) return e['hexCode'] as String?;
            return null;
          })
          .whereType<String>()
          .toList();
    }
    return null;
  }

  /// Convert to JSON (for creating/updating product)
  Map<String, dynamic> toJson({bool includeStoreObject = false}) {
    return {
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (sku != null) 'sku': sku,
      if (stockQuantity != null) 'stockQuantity': stockQuantity,
      if (isActive != null) 'isActive': isActive,
      if (purchaseCount != null) 'purchaseCount': purchaseCount,
      if (revenue != null) 'revenue': revenue,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (country != null) 'country': country,
      if (owner != null) 'owner': owner!.toJson(),
      if (ownerId != null) 'ownerId': ownerId,
      if (includeStoreObject && store != null)
        'store': store!.toJson()
      else if (store?.id != null)
        'storeId': store!.id
      else if (storeId != null)
        'storeId': storeId,

      // Flexible image format - adjust based on your backend
      'images': image?.map((url) => {'url': url}).toList() ?? [],
      // Or use this if backend expects plain strings:
      // 'images': image,

      'sizes': sizes?.map((size) => {'size': size}).toList() ?? [],
      'colors': colors?.map((hex) => {'hexCode': hex}).toList() ?? [],
    }..removeWhere((key, value) => value == null);
  }

  /// copyWith - full support
  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? sku,
    int? stockQuantity,
    bool? isActive,
    int? purchaseCount,
    double? revenue,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? latitude,
    double? longitude,
    String? country,
    UserModel? owner,
    String? ownerId,
    List<String>? image,
    StoreModel? store,
    String? storeId,
    List<String>? sizes,
    List<String>? colors,
    List<ProductReview>? reviews,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      sku: sku ?? this.sku,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isActive: isActive ?? this.isActive,
      purchaseCount: purchaseCount ?? this.purchaseCount,
      revenue: revenue ?? this.revenue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      country: country ?? this.country,
      owner: owner ?? this.owner,
      ownerId: ownerId ?? this.ownerId,
      image: image ?? this.image,
      store: store ?? this.store,
      storeId: storeId ?? this.storeId,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      reviews: reviews ?? this.reviews,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.sku == sku &&
        other.stockQuantity == stockQuantity &&
        other.isActive == isActive &&
        other.purchaseCount == purchaseCount &&
        other.revenue == revenue &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.country == country &&
        other.owner == owner &&
        other.ownerId == ownerId &&
        const DeepCollectionEquality().equals(other.image, image) &&
        other.store == store &&
        other.storeId == storeId &&
        const DeepCollectionEquality().equals(other.sizes, sizes) &&
        const DeepCollectionEquality().equals(other.colors, colors) &&
        const DeepCollectionEquality().equals(other.reviews, reviews);
  }

  @override
  int get hashCode {
    return Object.hashAll([
      id,
      title,
      description,
      price,
      sku,
      stockQuantity,
      isActive,
      purchaseCount,
      revenue,
      createdAt,
      updatedAt,
      latitude,
      longitude,
      country,
      owner,
      ownerId,
      const DeepCollectionEquality().hash(image),
      store,
      storeId,
      const DeepCollectionEquality().hash(sizes),
      const DeepCollectionEquality().hash(colors),
      const DeepCollectionEquality().hash(reviews),
    ]);
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, price: $price, storeId: $storeId)';
  }
}

ProductReview productReviewFromJson(String str) =>
    ProductReview.fromJson(json.decode(str));

String productReviewToJson(ProductReview data) => json.encode(data.toJson());

class ProductReview {
  String? id;
  String? userId;
  int? rating;
  String? title;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? user;
  List<String>? images; // Review images uploaded by user

  ProductReview({
    this.id,
    this.userId,
    this.rating,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.images,
  });

  // Fixed: Added 'images' parameter
  ProductReview copyWith({
    String? id,
    String? userId,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? user,
    List<String>? images,
  }) =>
      ProductReview(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        rating: rating ?? this.rating,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
        images: images ?? this.images,
      );

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json["id"] as String?,
      userId: json["userId"] as String?,
      rating: json["rating"] as int?,
      title: json["title"] as String?,
      content: json["content"] as String?,
      createdAt: json["createdAt"] == null
          ? null
          : DateTime.parse(json["createdAt"] as String),
      updatedAt: json["updatedAt"] == null
          ? null
          : DateTime.parse(json["updatedAt"] as String),
      user: json["user"] == null
          ? null
          : UserModel.fromJson(json["user"] as Map<String, dynamic>),
      images: json["images"] == null
          ? null
          : List<String>.from(json["images"] as List),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "rating": rating,
        "title": title,
        "content": content,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "images": images, // Now included
      };
}
