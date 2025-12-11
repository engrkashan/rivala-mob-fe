import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/reports_repo.dart';

class ReportsProvider extends ChangeNotifier {
  final _reportsRepo = ReportsRepo();

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> submitReport(String targetId, String reason) async {
    setLoading(true);
    try {
      await _reportsRepo.createReport(targetId: targetId, reason: reason);
      _error = null;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
