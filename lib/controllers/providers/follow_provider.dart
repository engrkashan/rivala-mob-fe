import 'package:flutter/foundation.dart';
import 'package:rivala/models/follow_model.dart';

import '../repos/followers_repo.dart';

class FollowProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<FollowModel> _followers = [];
  List<FollowModel> get followers => _followers;
  List<FollowModel> _following = [];
  List<FollowModel> get following => _following;

  FollowsRepo _repo = FollowsRepo();

  String? _error;

  String? get error => _error;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> loadFollowers() async {
    setLoading(true);
    try {
      _followers = await _repo.getFollowers();
      print("Followers loaded: ${_followers.length}");
      _error = null;
    } catch (e) {
      _error = e.toString();
      _followers = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadFollowings() async {
    setLoading(true);
    try {
      _following = await _repo.getFollowing();
      print("Followers loaded: ${_following.length}");
      _error = null;
    } catch (e) {
      _error = e.toString();
      _followers = [];
    } finally {
      setLoading(false);
    }
  }
}
