import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/notification_model.dart';

class NotificationRepo {
  ApiClient api = ApiClient();

  /// Get all notifications for the user
  Future<List<NotificationModel>> getNotifications() async {
    final response = await api.getResponse(endpoints: Endpoints.notifications);
    // Assuming the response lists notifications directly or in a 'notifications' key.
    // Based on other repos, it's likely in a key.
    final list = response['notifications'] as List;
    return list.map((item) => NotificationModel.fromJson(item)).toList();
  }

  /// Get notification by ID
  Future<NotificationModel> getNotificationById(String id) async {
    final response =
        await api.getResponse(endpoints: Endpoints.notificationsWithId(id));
    return NotificationModel.fromJson(response);
  }

  /// Mark notification as read
  Future<void> readNotification(String id) async {
    await api.postResponse(endpoints: Endpoints.readNotification(id));
  }

  /// Mark all notifications as read
  Future<void> readAllNotifications() async {
    await api.postResponse(endpoints: Endpoints.readAllNotifications);
  }
}
