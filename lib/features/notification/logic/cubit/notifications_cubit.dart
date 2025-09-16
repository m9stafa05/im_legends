import 'package:bloc/bloc.dart';
import 'package:im_legends/core/utils/secure_storage.dart';
import '../../data/repos/notification_repo.dart';
import '../../data/models/notification_model.dart';
import 'package:meta/meta.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({required this.notificationRepo})
    : super(NotificationsInitial());

  final NotificationRepo notificationRepo;
  final SecureStorage secureStorage = SecureStorage();

  /// Fetch notifications for the current user
  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());
    try {
      final userId = await secureStorage.getUserId();
      if (userId == null || userId.isEmpty) {
        emit(NotificationsFailure(errorMessage: 'User ID not found'));
        return;
      }

      final notifications = await notificationRepo.getUserNotifications(userId);
      emit(NotificationsSuccess(notifications: notifications));
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// Send login notification
  Future<void> sendLoginNotification({
    required String userId,
    required String userName,
    required String email,
  }) async {
    try {
      await notificationRepo.sendLoginNotification(
        userId: userId,
        userName: userName,
        email: email,
      );
      await fetchNotifications(); // Refresh notifications
    } catch (e) {
      emit(
        NotificationsFailure(
          errorMessage: 'Failed to send login notification: $e',
        ),
      );
    }
  }

  /// Send sign-up notification
  Future<void> sendSignUpNotification({
    required String userId,
    required String userName,
    required String email,
  }) async {
    try {
      await notificationRepo.sendSignUpNotification(
        userId: userId,
        userName: userName,
        email: email,
      );
      await fetchNotifications(); // Refresh notifications
    } catch (e) {
      emit(
        NotificationsFailure(
          errorMessage: 'Failed to send sign-up notification: $e',
        ),
      );
    }
  }

  /// Mark a single notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await notificationRepo.markAsRead(notificationId);
      await fetchNotifications(); // Refresh state
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// Mark all notifications as read for the current user
  Future<void> markAllAsRead() async {
    try {
      final userId = await secureStorage.getUserId();
      if (userId == null || userId.isEmpty) {
        emit(NotificationsFailure(errorMessage: 'User ID not found'));
        return;
      }
      await notificationRepo.markAllAsRead(userId);
      await fetchNotifications(); // Refresh state
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// Delete a notification by ID
  Future<void> deleteNotification(String notificationId) async {
    try {
      await notificationRepo.deleteNotification(notificationId);
      await fetchNotifications(); // Refresh state
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// Get unread notifications count
  Future<int> getUnreadCount() async {
    try {
      final userId = await secureStorage.getUserId();
      if (userId == null || userId.isEmpty) return 0;
      return await notificationRepo.getUnreadCount(userId);
    } catch (e) {
      return 0;
    }
  }
}
