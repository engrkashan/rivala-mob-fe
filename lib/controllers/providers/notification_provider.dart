import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/notification_repo.dart';
import 'package:rivala/models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  final _notificationRepo = NotificationRepo();

  bool _isLoading = false;
  String? _error;
  List<NotificationModel>? _notifications;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<NotificationModel>? get notifications => _notifications;

  int get unreadCount =>
      _notifications?.where((n) => n.read == false).length ?? 0;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadNotifications() async {
    setLoading(true);
    try {
      _notifications = await _notificationRepo.getNotifications();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _notifications = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> markAsRead(String id) async {
    // Optimistic update
    final index = _notifications?.indexWhere((n) => n.id == id);
    if (index != null && index != -1 && _notifications != null) {
      // Need to create a copy or modify if mutable? Models are usually immutable.
      // Assuming immutable, we can't modify directly.
      // But we removed Equatable and made them standard classes, so we might be able to if variables are not final.
      // Checking NotificationModel... all fields are final.
      // So we can't modify in place easily without copyWith or mutable fields.
      // Since I didn't generate copyWith, I will just call API and reload.
      // Or I can rebuild the list replacing the item.
      // For now, simpler to just await call.
    }

    try {
      await _notificationRepo.readNotification(id);
      // Reload to get fresh state or implement manual update if needed
      await loadNotifications();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> markAllAsRead() async {
    setLoading(true);
    try {
      await _notificationRepo.readAllNotifications();
      await loadNotifications();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
