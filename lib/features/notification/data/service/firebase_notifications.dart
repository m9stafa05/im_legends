import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:im_legends/core/router/app_router.dart';
import 'package:im_legends/core/router/routes.dart';
import 'package:im_legends/features/notification/data/models/notification_model.dart';
import '../../../../core/service/supa_base_service.dart';
import 'local_notifications.dart';
import '../../../../core/utils/shared_prefs.dart';

/// Handles FCM push notifications and token management
class FirebaseNotifications {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final LocalNotificationService _localNotifications =
      LocalNotificationService();
  final SharedPrefStorage _sharedPrefStorage = SharedPrefStorage.instance;

  /// Initialize FCM, request permissions, and setup listeners
  Future<void> initialize() async {
    // Request user permission for iOS
    await _messaging.requestPermission();

    // Print FCM Token (send to backend if needed)
    final token = await _messaging.getToken();
    debugPrint('FCM Token: $token');

    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint('New FCM Token: $newToken');
      SupaBaseService().saveTokenToSupabase(token!, newToken);
    });

    // Foreground messages → show + save
    FirebaseMessaging.onMessage.listen((message) {
      _handleIncomingMessage(message);
    });

    // When the app is in background and user taps the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessageNavigation(message);
    });

    // When the app is terminated
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageNavigation(initialMessage);
    }
  }

  /// Handle and save incoming push notification
  Future<void> _handleIncomingMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification != null) {
      // ✅ Show & save using LocalNotificationService
      await _localNotifications.showNotification(
        id: message.hashCode,
        title: notification.title,
        body: notification.body,
        payload: Routes.notificationScreen,
      );

      // ✅ Also store a record in SharedPrefStorage
      final model = NotificationModel(
        id: message.messageId ?? message.hashCode.toString(),
        title: notification.title ?? '',
        message: notification.body ?? '',
        time: DateTime.now(),
        type: NotificationType.system,
        isRead: false, // you can adjust type if needed
      );

      final existing = _sharedPrefStorage.getNotifications();
      existing.add(model);
      await _sharedPrefStorage.setNotifications(existing);
    }
  }

  /// Navigate user based on notification payload
  void _handleMessageNavigation(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != Routes.notificationScreen) {
      navigatorKey.currentState?.pushNamed(
        Routes.notificationScreen,
        arguments: message,
      );
    }
  }
}

/// Must be a top-level function for background FCM messages
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling background message: ${message.messageId}");

  final notification = message.notification;
  if (notification != null) {
    await LocalNotificationService().showNotification(
      id: message.hashCode,
      title: notification.title,
      body: notification.body,
      payload: Routes.notificationScreen,
    );

    // ✅ Save into SharedPrefStorage too
    final model = NotificationModel(
      id: message.messageId ?? message.hashCode.toString(),
      title: notification.title ?? '',
      message: notification.body ?? '',
      time: DateTime.now(),
      type: NotificationType.system,
      isRead: false,
    );

    final storage = SharedPrefStorage.instance;
    final existing = storage.getNotifications();
    existing.add(model);
    await storage.setNotifications(existing);
  }
}
