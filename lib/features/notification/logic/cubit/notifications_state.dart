part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoading extends NotificationsState {}

final class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> notifications;
  NotificationsSuccess({required this.notifications});
}

final class NotificationsFailure extends NotificationsState {
  final String errorMessage;
  NotificationsFailure({required this.errorMessage});
}
