import 'package:im_legends/core/utils/shared_prefs.dart';
import '../models/notification_model.dart';

class NotificationRepo {
  final SharedPrefStorage _sharedPrefs = SharedPrefStorage.instance;

  /// ---------------------------
  /// Remove duplicate notifications
  /// ---------------------------
  Future<void> cleanDuplicates() async {
    try {
      final notifications = _sharedPrefs.getNotifications();
      final uniqueNotifications = {for (var n in notifications) n.id: n};
      await _sharedPrefs.setNotifications(uniqueNotifications.values.toList());
    } catch (e) {
      print('❌ Error cleaning duplicates: $e');
    }
  }

  /// ---------------------------
  /// Fetch all notifications
  /// ---------------------------
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final notifications = _sharedPrefs.getNotifications();
      notifications.sort((a, b) => b.time.compareTo(a.time)); // newest first
      return notifications;
    } catch (e) {
      print('❌ Error fetching notifications: $e');
      return [];
    }
  }

  /// ---------------------------
  /// Mark a single notification as read
  /// ---------------------------
  Future<void> markAsRead(String id) async {
    try {
      final notifications = _sharedPrefs.getNotifications();
      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index] = notifications[index].copyWith(isRead: true);
        await _sharedPrefs.setNotifications(notifications);
      }
    } catch (e) {
      print('❌ Error marking notification as read: $e');
    }
  }

  /// ---------------------------
  /// Mark all notifications as read
  /// ---------------------------
  Future<void> markAllAsRead() async {
    try {
      final notifications = _sharedPrefs.getNotifications();
      bool updated = false;
      for (var i = 0; i < notifications.length; i++) {
        if (!notifications[i].isRead) {
          notifications[i] = notifications[i].copyWith(isRead: true);
          updated = true;
        }
      }
      if (updated) await _sharedPrefs.setNotifications(notifications);
    } catch (e) {
      print('❌ Error marking all notifications as read: $e');
    }
  }

  /// ---------------------------
  /// Delete a notification by ID
  /// ---------------------------
  Future<void> deleteNotification(String id) async {
    try {
      final notifications = _sharedPrefs.getNotifications();
      notifications.removeWhere((n) => n.id == id);
      await _sharedPrefs.setNotifications(notifications);
    } catch (e) {
      print('❌ Error deleting notification: $e');
    }
  }
}
