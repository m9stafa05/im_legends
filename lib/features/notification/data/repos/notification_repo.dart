import 'package:flutter/material.dart';
import 'package:im_legends/features/notification/data/models/notification_model.dart';
import 'package:im_legends/features/notification/data/service/firebase_notifications_service.dart';

class NotificationRepo {
  NotificationRepo();


  final FirebaseNotificationsService _firebaseNotificationsService =
      FirebaseNotificationsService();

  /// Get all user notifications (sorted by time, newest first)
  Future<List<NotificationModel>> getNotifications(String userId) async {
    if (userId.isEmpty) {
      debugPrint('❌ User ID is empty, cannot fetch notifications');
      return [];
    }
    try {
      final notifications = await _firebaseNotificationsService
          .getUserNotifications();
      notifications.sort((a, b) => b.time.compareTo(a.time));
      debugPrint(
        '✅ Fetched ${notifications.length} notifications for user $userId',
      );
      return notifications;
    } catch (e) {
      debugPrint('❌ Error fetching notifications: $e');
      return [];
    }
  }

  /// Get unread notifications count
  Future<int> getUnreadCount() async {
    try {
      return await _firebaseNotificationsService.getUnreadNotificationsCount();
    } catch (e) {
      debugPrint('❌ Error fetching unread count: $e');
      return 0;
    }
  }

  /// Mark single notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _firebaseNotificationsService.markNotificationAsRead(
        notificationId,
      );
      debugPrint("✅ Notification marked as read: $notificationId");
    } catch (e) {
      debugPrint("❌ Failed to mark notification as read: $e");
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      await _firebaseNotificationsService.markAllNotificationsAsRead();
      debugPrint("✅ All notifications marked as read");
    } catch (e) {
      debugPrint("❌ Failed to mark all notifications as read: $e");
    }
  }

  /// Delete a notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _firebaseNotificationsService.deleteNotification(notificationId);
      debugPrint("✅ Notification deleted: $notificationId");
    } catch (e) {
      debugPrint("❌ Failed to delete notification: $e");
    }
  }

  /// Refresh notifications from server
  Future<void> refreshSession() async {
    try {
      await _firebaseNotificationsService.refreshUserSessionData();
      debugPrint("✅ User session data refreshed");
    } catch (e) {
      debugPrint("❌ Failed to refresh session data: $e");
    }
  }
}
