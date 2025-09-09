import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:im_legends/core/router/app_router.dart';
import 'package:im_legends/core/router/routes.dart';
import 'package:im_legends/core/service/supa_base_service.dart';
import 'package:im_legends/core/utils/shared_prefs.dart';
import 'package:im_legends/features/notification/data/models/notification_model.dart';
import 'package:im_legends/features/notification/data/service/local_notifications.dart';

class FirebaseNotifications {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final LocalNotificationService _localNotifications =
      LocalNotificationService();
  final SharedPrefStorage _sharedPrefStorage = SharedPrefStorage.instance;

  /// Initialize FCM and local notifications
  Future<void> initialize(String userId) async {
    await _messaging.requestPermission();

    // Save initial token
    final token = await _messaging.getToken();
    if (token != null) {
      try {
        await SupaBaseService().saveOrUpdateToken(userId, token);
      } catch (e) {
        debugPrint("❌ Failed to save initial FCM token: $e");
      }
    }

    // Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) async {
      try {
        await SupaBaseService().saveOrUpdateToken(userId, newToken);
      } catch (e) {
        debugPrint("❌ Failed to refresh FCM token: $e");
      }
    });

    // Foreground messages
    FirebaseMessaging.onMessage.listen(_handleIncomingMessage);

    // Background → app opened
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageNavigation);

    // Terminated → app opened
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageNavigation(initialMessage);
    }
  }

  /// Handle incoming foreground message
  Future<void> _handleIncomingMessage(RemoteMessage message) async {
    await _saveAndShow(message);
  }

  /// Navigate when user taps notification
  void _handleMessageNavigation(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final data = message.data;
    final route = data['route'] ?? Routes.notificationScreen;

    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != route) {
      navigatorKey.currentState?.pushNamed(route, arguments: message);
    }
  }

  /// Save notification in SharedPrefs & show locally
  Future<void> _saveAndShow(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    final messageId =
        message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString();

    // ✅ CHECK FOR DUPLICATES FIRST
    final existing = _sharedPrefStorage.getNotifications();
    final isDuplicate = existing.any((n) => n.id == messageId);
    if (isDuplicate) {
      debugPrint("⚠️ Duplicate notification ignored: $messageId");
      return; // Don't save or show if already exists
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch % 2147483647;

    // Show local notification
    await _localNotifications.showNotification(
      id: timestamp,
      title: notification.title,
      body: notification.body,
      payload: Routes.notificationScreen,
    );

    // Save in SharedPrefs
    final model = NotificationModel(
      id: messageId, // Use messageId consistently
      title: notification.title ?? '',
      message: notification.body ?? '',
      time: DateTime.now(),
      type: NotificationType.system,
      isRead: false,
    );

    existing.add(model);
    await _sharedPrefStorage.setNotifications(existing);
    debugPrint("✅ Notification saved: $messageId");
  }

  Future<void> sendLocalAppNotification({
    required String title,
    required String body,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch % 2147483647;
    final notificationId = timestamp.toString();

    // ✅ CHECK FOR DUPLICATES
    final existing = _sharedPrefStorage.getNotifications();
    final isDuplicate = existing.any((n) => n.id == notificationId);
    if (isDuplicate) {
      debugPrint("⚠️ Duplicate local notification ignored: $notificationId");
      return;
    }

    // Show as push notification
    await _localNotifications.showNotification(
      id: timestamp,
      title: title,
      body: body,
      payload: Routes.notificationScreen,
    );

    // Save in SharedPrefs
    final model = NotificationModel(
      id: notificationId,
      title: title,
      message: body,
      time: DateTime.now(),
      type: NotificationType.system,
      isRead: false,
    );

    existing.add(model);
    await _sharedPrefStorage.setNotifications(existing);
    debugPrint("✅ Local notification saved: $notificationId");
  }
}

/// Top-level background handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling background message: ${message.messageId}");
  await FirebaseNotifications()._saveAndShow(message);
}
