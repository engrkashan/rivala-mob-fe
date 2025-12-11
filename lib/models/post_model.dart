import 'package:rivala/models/product_model.dart';
import 'package:rivala/models/user_model.dart';

class PostModel {
  final String? id;
  final String? content;
  final List<String>? media;
  final int? likeCount;
  final int? commentCount;
  final UserModel? owner;
  final ProductModel? product;
  final DateTime? createdAt;

  PostModel({
    this.id,
    this.content,
    this.media,
    this.likeCount,
    this.commentCount,
    this.owner,
    this.product,
    this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      content: json['content'],
      media: (json['media'] as List?)?.map((e) => e.toString()).toList(),
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      owner: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}
