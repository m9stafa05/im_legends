import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:im_legends/core/router/app_router.dart';
import 'package:im_legends/core/router/routes.dart';
import 'package:im_legends/core/service/supa_base_service.dart';
import 'package:im_legends/core/utils/secure_storage.dart';
import 'local_notifications.dart';
import '../models/notification_model.dart';

class FirebaseNotificationsService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final SupaBaseService _supabaseService = SupaBaseService();

  String? _userId;
  List<NotificationModel> _userNotifications = [];

  /// === Initialize for current user ===
  Future<void> initialize(String userId) async {
    _userId = userId;
    String? _currentToken;
    // Request permission for notifications
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Fetch full user session data including notifications
    _userNotifications = await _supabaseService.getUserNotifications(userId);

    // Save initial token in Supabase using the proper method
    final token = await _messaging.getToken();
    _currentToken = token;

    if (token != null) {
      try {
        await _supabaseService.saveOrUpdateToken(userId, token);
        debugPrint("✅ FCM token saved successfully");
      } catch (e) {
        debugPrint("❌ Failed to save FCM token: $e");
      }
    }

    // Refresh token listener
    _messaging.onTokenRefresh.listen((newToken) async {
      if (_currentToken != null) {
        await _supabaseService.removeUserToken(userId, _currentToken!);
      }
      await _supabaseService.saveOrUpdateToken(userId, newToken);
      _currentToken = newToken;
    });

    // Setup message handlers
    _setupMessageHandlers();

    // Handle initial message (app opened from notification)
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageNavigation(initialMessage);
    }
  }

  /// Setup all message handlers
  void _setupMessageHandlers() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen(_handleIncomingMessage);

    // Background/terminated app - user taps notification
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageNavigation);
  }

  /// Handle incoming messages when app is in foreground
  Future<void> _handleIncomingMessage(RemoteMessage message) async {
    if (_userId == null) return;

    debugPrint("📱 Foreground notification received");

    // Save to Supabase
    await _saveNotificationToDatabase(message, _userId!);

    // Show local notification
    final notification = message.notification;
    if (notification != null) {
      await LocalNotificationService().showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: notification.title,
        body: notification.body,
        userId: _userId!,
        payload: message.data['route'] ?? Routes.notificationScreen,
      );
    }
  }

  /// Handle navigation when user taps notification
  void _handleMessageNavigation(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final data = message.data;
    final route = data['route'] ?? Routes.notificationScreen;

    debugPrint("🔗 Navigating to: $route");

    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != route) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        route ?? Routes.notificationScreen,
        (route) => false,
        arguments: message,
      );
    }
  }

  /// Save notification to database using Supabase service
  Future<void> _saveNotificationToDatabase(
    RemoteMessage message,
    String userId,
  ) async {
    final notification = message.notification;
    if (notification == null) return;

    final messageId =
        message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString();

    // Determine notification type from data payload
    final notificationType = _getNotificationTypeFromData(message.data);

    try {
      // Save notification using Supabase service
      await _supabaseService.insertNotification(
        userId: userId,
        title: notification.title ?? 'New Notification',
        message: notification.body ?? '',
        type: notificationType,
        notificationId: messageId,
      );
      _userNotifications.insert(
        0,
        NotificationModel(
          id: messageId,
          title: notification.title ?? 'New Notification',
          message: notification.body ?? '',
          type: notificationType,
          isRead: false,
          time: DateTime.now(),
        ),
      );

      debugPrint(
        "✅ Notification saved to database for user $userId: $messageId",
      );
    } catch (e) {
      debugPrint("❌ Failed to save notification to database: $e");
    }
  }

  /// Determine notification type from message data
  NotificationType _getNotificationTypeFromData(Map<String, dynamic> data) {
    final typeString = data['type'] as String?;

    if (typeString != null) {
      try {
        return NotificationType.values.firstWhere(
          (type) => type.name == typeString,
          orElse: () => NotificationType.system,
        );
      } catch (e) {
        debugPrint("❌ Invalid notification type: $typeString");
      }
    }

    return NotificationType.system;
  }

  /// Public method for background handler
  Future<void> saveAndShow(RemoteMessage message, String userId) async {
    await _saveNotificationToDatabase(message, userId);
  }

  /// Send local app notification (for testing or internal triggers)
  Future<void> sendLocalAppNotification({
    required String title,
    required String body,
    required String userId,
    NotificationType type = NotificationType.system,
  }) async {
    final notificationId = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      await _supabaseService.insertNotification(
        userId: userId,
        title: title,
        message: body,
        type: type,
        notificationId: notificationId,
      );

      // Show local popup notification
      await LocalNotificationService().showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: title,
        body: body,
        userId: userId,
        payload: Routes.notificationScreen, // or pass a custom route
      );
      _userNotifications.insert(
        0,
        NotificationModel(
          id: notificationId,
          title: title,
          message: body,
          type: type,
          isRead: false,
          time: DateTime.now(),
        ),
      );

      debugPrint("✅ Local notification saved for user $userId");
    } catch (e) {
      debugPrint("❌ Failed to save local notification: $e");
    }
  }

  /// Get user notifications from Supabase
  Future<List<NotificationModel>> getUserNotifications() async {
    if (_userId == null) return [];

    try {
      return await _supabaseService.getUserNotifications(_userId!);
    } catch (e) {
      debugPrint("❌ Failed to fetch user notifications: $e");
      return [];
    }
  }

  /// Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _supabaseService.markAsRead(notificationId);

      final index = _userNotifications.indexWhere(
        (n) => n.id == notificationId,
      );
      if (index != -1) {
        _userNotifications[index] = _userNotifications[index].copyWith(
          isRead: true,
        );
      }

      debugPrint("✅ Notification marked as read: $notificationId");
    } catch (e) {
      debugPrint("❌ Failed to mark notification as read: $e");
    }
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _supabaseService.deleteNotification(notificationId);
      _userNotifications.removeWhere((n) => n.id == notificationId);
      debugPrint("✅ Notification deleted: $notificationId");
    } catch (e) {
      debugPrint("❌ Failed to delete notification: $e");
    }
  }

  /// Get unread notifications count
  Future<int> getUnreadNotificationsCount() async {
    final notifications = await getUserNotifications();
    return notifications.where((n) => !n.isRead).length;
  }

  /// Mark all notifications as read
  Future<void> markAllNotificationsAsRead() async {
    final notifications = await getUserNotifications();
    for (final notification in notifications.where((n) => !n.isRead)) {
      await markNotificationAsRead(notification.id);
    }
  }

  /// Cleanup when user logs out
  Future<void> cleanup() async {
    if (_userId != null) {
      try {
        // Remove all FCM tokens for this user
        await _supabaseService.removeAllTokens(_userId!);
        debugPrint("✅ All FCM tokens removed for user");
      } catch (e) {
        debugPrint("❌ Failed to remove FCM tokens: $e");
      }
    }

    _userId = null;
    _userNotifications = [];
  }

  /// Get current FCM token
  Future<String?> getCurrentToken() async {
    return await _messaging.getToken();
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    final settings = await _messaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  /// Refresh user session data
  Future<void> refreshUserSessionData() async {
    if (_userId != null) {
      _userNotifications = await _supabaseService.getUserNotifications(
        _userId!,
      );
    }
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final secureStorage = SecureStorage();
  final userId = await secureStorage.getUserId();

  if (userId == null) {
    debugPrint("❌ No stored userId, skipping background notification save");
    return;
  }

  final supabaseService = SupaBaseService();

  try {
    await supabaseService.insertNotification(
      userId: userId,
      title: message.notification?.title ?? "New Notification",
      message: message.notification?.body ?? "",
      type: NotificationType.system,
      notificationId: message.messageId ?? DateTime.now().toString(),
    );
  } catch (e) {
    debugPrint("❌ Background notification save failed: $e");
  }
}
