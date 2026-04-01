import 'package:rivala/models/product_model.dart';
import 'package:rivala/models/user_model.dart';

class PostModel {
  final String? id;
  final String? title;
  final String? description;
  final List<String>? media;
  final int? likeCount;
  final int? commentCount;
  final UserModel? author;
  final ProductModel? product;
  final DateTime? createdAt;

  PostModel({
    this.id,
    this.title,
    this.description,
    this.media,
    this.likeCount,
    this.commentCount,
    this.author,
    this.product,
    this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'] ?? json['content'],
      description: json['description'],
      media: (json['media'] as List?)?.map((e) {
        if (e is String) return e;
        if (e is Map) return e['url']?.toString() ?? '';
        return e.toString();
      }).toList(),
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      author: (json['author'] != null)
          ? UserModel.fromJson(json['author'])
          : (json['user'] != null)
              ? UserModel.fromJson(json['user'])
              : null,
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}
