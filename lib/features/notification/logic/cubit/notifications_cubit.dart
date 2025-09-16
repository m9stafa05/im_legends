import 'package:bloc/bloc.dart';
import 'package:im_legends/core/utils/secure_storage.dart';
import '../../data/models/notification_model.dart';
import '../../data/repos/notification_repo.dart';
import 'package:meta/meta.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({required this.notificationRepo})
    : super(NotificationsInitial());

  final NotificationRepo notificationRepo;
  final SecureStorage secureStorage = SecureStorage();

  /// ---------------------------
  /// Fetch notifications for this user
  /// ---------------------------
  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());
    try {
      // Await the getUserId() call since it returns a Future
      final userId = await secureStorage.getUserId();
      if (userId == null || userId.isEmpty) {
        emit(NotificationsFailure(errorMessage: 'User ID not found'));
        return;
      }

      final notifications = await notificationRepo.getNotifications(userId);
      emit(NotificationsSuccess(notifications: notifications));
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// ---------------------------
  /// Mark a single notification as read
  /// ---------------------------
  Future<void> markAsRead(String notificationId) async {
    try {
      await notificationRepo.markAsRead(notificationId);
      await fetchNotifications(); // Refresh state
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// ---------------------------
  /// Mark all notifications as read
  /// ---------------------------
  Future<void> markAllAsRead() async {
    try {
      await notificationRepo.markAllAsRead();
      await fetchNotifications();
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// ---------------------------
  /// Delete a notification by ID
  /// ---------------------------
  Future<void> deleteNotification(String notificationId) async {
    try {
      await notificationRepo.deleteNotification(notificationId);
      await fetchNotifications();
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// ---------------------------
  /// Get unread notifications count
  /// ---------------------------
  Future<int> getUnreadCount() async {
    try {
      return await notificationRepo.getUnreadCount();
    } catch (e) {
      return 0;
    }
  }

  /// ---------------------------
  /// Refresh notifications from server
  /// ---------------------------
  Future<void> refreshNotifications() async {
    try {
      await notificationRepo.refreshSession();
      await fetchNotifications();
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// ---------------------------
  /// Get current user ID (helper method)
  /// ---------------------------
  Future<String?> getCurrentUserId() async {
    try {
      return await secureStorage.getUserId();
    } catch (e) {
      return null;
    }
  }

  /// ---------------------------
  /// Undo delete placeholder
  /// ---------------------------
  void undoDelete() {
    // TODO: Implement restore from Supabase "deleted" status if needed
  }
}
