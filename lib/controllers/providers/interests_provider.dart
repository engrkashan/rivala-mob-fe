import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/interests_repo.dart';
import 'package:rivala/models/interest_model.dart';

class InterestsProvider extends ChangeNotifier {
  final _interestsRepo = InterestsRepo();

  bool _isLoading = false;
  String? _error;
  List<InterestModel>? _interests;
  List<InterestModel>? _userInterests;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<InterestModel>? get interests => _interests;
  List<InterestModel>? get userInterests => _userInterests;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadAllInterests() async {
    setLoading(true);
    try {
      _interests = await _interestsRepo.getInterests();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _interests = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadUserInterests() async {
    setLoading(true);
    try {
      _userInterests = await _interestsRepo.getCurrentUserInterests();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _userInterests = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateUserInterests(List<String> interestIds) async {
    setLoading(true);
    try {
      await _interestsRepo.updateCurrentUserInterests(interestIds);
      // Reload user interests to confirm update
      await loadUserInterests();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
