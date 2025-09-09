import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/notification_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:im_legends/core/router/app_router.dart';
import '../../../../core/utils/shared_prefs.dart';

/// Service to handle local notifications
class LocalNotificationService {
  // Singleton instance
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  final SharedPrefStorage _sharedPrefStorage = SharedPrefStorage.instance;

  /// Initialize local notifications
  Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          _handleNotificationTap(payload);
        }
      },
    );

    // ✅ Ask for POST_NOTIFICATIONS permission on Android 13+
    if (Platform.isAndroid) {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    }

    // ✅ Ask for permission on iOS
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Show a local notification
  Future<void> showNotification({
    required int id,
    required String? title,
    required String? body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      channelDescription: 'Used for general app notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    // ✅ Show system tray notification
    await _localNotifications.show(id, title, body, details, payload: payload);

    // ✅ Save notification to storage
    final notification = NotificationModel(
      id: id.toString(),
      title: title ?? '',
      message: body ?? '',
      time: DateTime.now(),
      type: NotificationType.system,
      isRead: false, // Or dynamic
    );

    final existing = _sharedPrefStorage.getNotifications();
    existing.add(notification);
    await _sharedPrefStorage.setNotifications(existing);
  }

  /// Handle notification tap and navigate
  void _handleNotificationTap(String payload) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    navigatorKey.currentState?.pushNamed(payload);
  }
}
