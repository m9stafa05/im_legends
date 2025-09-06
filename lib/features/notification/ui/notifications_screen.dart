import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../data/models/notification_model.dart';
import 'widgets/notification_app_bar.dart';
import 'widgets/notification_card.dart';
import 'widgets/notification_empty_state.dart';

import '../../../core/router/routes.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationModel> notifications = [
    // NotificationModel(
    //   id: '1',
    //   title: 'Welcome to the App!',
    //   message:
    //       'Thanks for joining us. Explore all the amazing features we have to offer.',
    //   time: DateTime.now().subtract(const Duration(minutes: 5)),
    //   isRead: false,
    //   type: NotificationType.welcome,
    // ),
    // NotificationModel(
    //   id: '2',
    //   title: 'New Update Available',
    //   message:
    //       'Version 2.1.0 is now available with exciting new features and bug fixes.',
    //   time: DateTime.now().subtract(const Duration(hours: 1)),
    //   isRead: false,
    //   type: NotificationType.update,
    // ),
    // NotificationModel(
    //   id: '3',
    //   title: 'Account Security',
    //   message: 'Your account was successfully logged in from a new device.',
    //   time: DateTime.now().subtract(const Duration(hours: 5)),
    //   isRead: true,
    //   type: NotificationType.security,
    // ),
    // NotificationModel(
    //   id: '4',
    //   title: 'Promotion Available',
    //   message:
    //       'Get 50% off on your next purchase with our exclusive promotion code.',
    //   time: DateTime.now().subtract(const Duration(days: 1)),
    //   isRead: true,
    //   type: NotificationType.promotion,
    // ),
    // NotificationModel(
    //   id: '5',
    //   title: 'System Update',
    //   message:
    //       'We have updated our app with new features and bug fixes. Download now!',
    //   time: DateTime.now().subtract(const Duration(days: 2)),
    //   isRead: true,
    //   type: NotificationType.system,
    // ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (var n in notifications) {
        n.isRead = true;
      }
    });
  }

  void _markAsRead(String id) {
    setState(() {
      final n = notifications.firstWhere((n) => n.id == id);
      n.isRead = true;
    });
  }

  void _deleteNotification(int index, NotificationModel item) {
    setState(() {
      notifications.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification deleted'),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,

          onPressed: () {
            setState(() {
              notifications.insert(index, item);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = notifications.where((n) => !n.isRead).length;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          NotificationAppBar(
            unreadCount: unreadCount,
            onBack: () => Navigator.of(context).pop(),
            onMarkAllAsRead: _markAllAsRead,
          ),
          Expanded(
            child: notifications.isEmpty
                ? const NotificationEmptyState()
                : ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    itemCount: notifications.length,
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return NotificationCard(
                        notification: notification,
                        index: index,
                        onDelete: () =>
                            _deleteNotification(index, notification),
                        onUndo: () {},
                        onTap: () {
                          _markAsRead(notification.id);
                          context.push(
                            Routes.notificationDetailsScreen,
                            extra: notification,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
