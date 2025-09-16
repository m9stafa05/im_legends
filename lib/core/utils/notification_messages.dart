import 'package:im_legends/core/router/routes.dart';
import 'package:im_legends/features/notification/data/service/local_notifications.dart';
import '../../features/notification/data/models/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationMessages {
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  static final LocalNotificationService _localNotificationService =
      LocalNotificationService();

  /// Login notification message
  static NotificationModel loginMessage({
    required String userId,
    required String userName,
    required String email,
  }) {
    final now = DateTime.now();
    final message = NotificationModel(
      id: now.millisecondsSinceEpoch.toString(),
      title: "Welcome Back! 👋",
      message:
          "Hi $userName, you logged in successfully on ${_dateFormat.format(now)}.\nEmail: $email",
      time: now,
      type: NotificationType.welcome,
      isRead: false,
    );

    // Show local notification
    _localNotificationService.showNotification(
      id: now.millisecondsSinceEpoch ~/ 1000,
      title: message.title,
      body: message.message,
      userId: userId,
      payload: Routes.notificationScreen,
    );

    return message;
  }

  /// Sign-up notification message
  static NotificationModel signUpMessage({
    required String userId,
    required String userName,
    required String email,
  }) {
    final now = DateTime.now();
    final message = NotificationModel(
      id: now.millisecondsSinceEpoch.toString(),
      title: "Welcome to IM Legends! 🎉",
      message:
          "Hi $userName, your account was created on ${_dateFormat.format(now)}.\nEmail: $email",
      time: now,
      type: NotificationType.welcome,
      isRead: false,
    );

    // Show local notification
    _localNotificationService.showNotification(
      id: now.millisecondsSinceEpoch ~/ 1000,
      title: message.title,
      body: message.message,
      userId: userId,
      payload: Routes.notificationScreen,
    );

    return message;
  }
}
