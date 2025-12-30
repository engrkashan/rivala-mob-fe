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

  final FollowsRepo _repo = FollowsRepo();

  String? _error;
  String? get error => _error;

  /// Track follow status per brand
  final Map<String, bool> _followedBrands = {};

  /// Check if a brand is followed
  bool isFollowed(String brandId) => _followedBrands[brandId] ?? false;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> loadFollowers() async {
    setLoading(true);
    try {
      _followers = await _repo.getFollowers();
      _error = null;
      print("Followers loaded: ${_followers.length}");
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
      _error = null;
      print("Following loaded: ${_following.length}");
    } catch (e) {
      _error = e.toString();
      _following = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> followBrand(String brandId) async {
    setLoading(true);
    try {
      await _repo.followBrand(brandId);
      _error = null;
      _followedBrands[brandId] = true;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> unfollowBrand(String brandId) async {
    setLoading(true);
    try {
      await _repo.unfollowBrand(brandId);
      _error = null;
      _followedBrands[brandId] = false;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }
}
