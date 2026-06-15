import 'package:flutter/material.dart';
import 'package:rivala/controllers/repos/post_repo.dart';
import 'package:rivala/models/collection_model.dart';
import 'package:rivala/models/user_model.dart';

import '../../models/post_model.dart';
import '../../models/product_model.dart';

class PostProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  final PostRepo postRepo = PostRepo();
  List<UserModel>? _users;
  List<ProductModel?> tagProducts = [];
  List<CollectionModel?> tagCollections = [];
  List<UserModel>? get creators => _users;
  String? _selectedLocation;
  String? get selectedLocation => _selectedLocation;
  bool get isLoading => _isLoading;
  String? get error => _error;
  void setLocation(String location) {
    _selectedLocation = location;
    notifyListeners(); // UI update
  }

  void toggleTagCollection(CollectionModel collection) {
    final isSelected = tagCollections.any((col) => col?.id == collection.id);

    if (isSelected) {
      tagCollections.removeWhere((col) => col?.id == collection.id);
    } else {
      tagCollections.add(collection);
    }

    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  DateTime? postExpiration;

  void setPostExpiration(DateTime dateTime) {
    postExpiration = dateTime;
    notifyListeners();
  }

  String formattedExpiration(BuildContext context) {
    if (postExpiration == null) return '';
    final dt = postExpiration!;
    return '${dt.month}/${dt.day}/${dt.year}, '
        '${TimeOfDay.fromDateTime(dt).format(context)}';
  }

  Future<void> loadCreators() async {
    setLoading(true);
    try {
      _users = await postRepo.getRecentCreators();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _users = [];
    } finally {
      setLoading(false);
    }
  }

  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;

  Future<void> loadDiscoverPosts() async {
    // Only load if empty or refresh needed (omitted for simplicity, but good practice)
    setLoading(true);
    try {
      _posts = await postRepo.getDiscoverPosts();
      _error = null;
    } catch (e) {
      _error = e.toString();
      // Keep previous posts if any, or clear?
      // _posts = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> createPost(dynamic post) async {
    setLoading(true);
    try {
      final createdPost = await postRepo.createPost(post);
      if (createdPost != null) {
        _posts.removeWhere((item) => item.id == createdPost.id);
        _posts.insert(0, createdPost);
      } else {
        await loadDiscoverPosts();
      }
      tagProducts.clear();
      tagCollections.clear();
      _selectedLocation = null;
      postExpiration = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> toggleLike(PostModel post) async {
    final postId = post.id!;
    try {
      // Optimistic update for the feed
      final index = _posts.indexWhere((p) => p.id == postId);
      if (index != -1) {
        final p = _posts[index];
        p.isLikedByMe = !p.isLikedByMe;
        p.likeCount = (p.likeCount ?? 0) + (p.isLikedByMe ? 1 : -1);
      } else {
        // Optimistic update for the isolated post passed in
        post.isLikedByMe = !post.isLikedByMe;
        post.likeCount = (post.likeCount ?? 0) + (post.isLikedByMe ? 1 : -1);
      }
      notifyListeners();
      
      await postRepo.toggleLike(postId);
    } catch (e) {
      debugPrint("Error toggling like: $e");
      // Revert optimistic update
      final index = _posts.indexWhere((p) => p.id == postId);
      if (index != -1) {
        final p = _posts[index];
        p.isLikedByMe = !p.isLikedByMe;
        p.likeCount = (p.likeCount ?? 0) + (p.isLikedByMe ? 1 : -1);
      } else {
        post.isLikedByMe = !post.isLikedByMe;
        post.likeCount = (post.likeCount ?? 0) + (post.isLikedByMe ? 1 : -1);
      }
      notifyListeners();
    }
  }

  Future<List<PostCommentModel>> getComments(String postId) async {
    try {
      return await postRepo.getComments(postId);
    } catch (e) {
      debugPrint("Error fetching comments: $e");
      return [];
    }
  }

  Future<PostCommentModel?> addComment(PostModel post, String content) async {
    final postId = post.id!;
    try {
      final newComment = await postRepo.postComment(postId, content);
      if (newComment != null) {
        final index = _posts.indexWhere((p) => p.id == postId);
        if (index != -1) {
          final p = _posts[index];
          p.commentCount = (p.commentCount ?? 0) + 1;
        } else {
          post.commentCount = (post.commentCount ?? 0) + 1;
        }
        notifyListeners();
      }
      return newComment;
    } catch (e) {
      debugPrint("Error adding comment: $e");
      return null;
    }
  }
}
