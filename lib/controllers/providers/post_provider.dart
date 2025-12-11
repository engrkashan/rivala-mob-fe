import 'package:flutter/material.dart';
import 'package:rivala/controllers/repos/post_repo.dart';
import 'package:rivala/models/user_model.dart';
import '../../models/post_model.dart';

class PostProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  final PostRepo postRepo = PostRepo();
  List<UserModel>? _users;

  List<UserModel>? get creators => _users;

  bool get isLoading => _isLoading;
  String? get error => _error;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
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
}
