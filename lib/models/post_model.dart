import 'package:rivala/models/product_model.dart';
import 'package:rivala/models/user_model.dart';

class PostModel {
  final String? id;
  final String? title;
  final String? description;
  final List<String>? media;
  int? likeCount;
  int? commentCount;
  final UserModel? author;
  final ProductModel? product;
  final DateTime? createdAt;
  bool isLikedByMe;

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
    this.isLikedByMe = false,
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
      likeCount: json['_count']?['postLikes'] ?? json['likeCount'],
      commentCount: json['_count']?['postComments'] ?? json['commentCount'],
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
      isLikedByMe: (json['postLikes'] as List?)?.isNotEmpty ?? false,
    );
  }
}

class PostCommentModel {
  final String? id;
  final String? content;
  final UserModel? user;
  final DateTime? createdAt;

  PostCommentModel({
    this.id,
    this.content,
    this.user,
    this.createdAt,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) {
    return PostCommentModel(
      id: json['id'],
      content: json['content'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}
