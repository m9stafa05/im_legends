import 'package:bloc/bloc.dart';
import 'package:im_legends/features/notification/data/models/notification_model.dart';
import 'package:im_legends/features/notification/data/repos/notification_repo.dart';
import 'package:meta/meta.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  final NotificationRepo _notificationRepo = NotificationRepo();

  /// ---------------------------
  /// Clean up duplicate notifications (call once)
  /// ---------------------------
  Future<void> cleanDuplicates() async {
    try {
      await _notificationRepo.cleanDuplicates();
      await fetchNotifications(); // Refresh the UI
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// ---------------------------
  /// Fetch notifications
  /// ---------------------------
  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());
    try {
      final notifications = await _notificationRepo.getNotifications();
      emit(NotificationsSuccess(notifications: notifications));
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// ---------------------------
  /// Mark a single notification as read
  /// ---------------------------
  Future<void> markAsRead(String id) async {
    try {
      await _notificationRepo.markAsRead(id);
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
      final currentState = state;
      if (currentState is NotificationsSuccess) {
        await _notificationRepo.markAllAsRead();
      }
      await fetchNotifications(); // Refresh state
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// ---------------------------
  /// Delete a notification by ID
  /// ---------------------------
  Future<void> deleteNotification(String id) async {
    try {
      final currentState = state;
      if (currentState is NotificationsSuccess) {
        await _notificationRepo.deleteNotification(id);
      }
      await fetchNotifications(); // Refresh state
    } catch (e) {
      emit(NotificationsFailure(errorMessage: e.toString()));
    }
  }

  /// ---------------------------
  /// Undo delete placeholder
  /// ---------------------------
  void undoDelete() {}
}
