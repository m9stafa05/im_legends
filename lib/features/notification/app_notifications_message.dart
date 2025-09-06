import 'package:im_legends/features/notification/data/service/firebase_notifications.dart';

class AppNotificationsMessage {
  static final FirebaseNotifications _firebaseNotifications =
      FirebaseNotifications();

  /// Sign-up message
  static Future<void> sendSignUpMessage(String userName) async {
    await _firebaseNotifications.sendLocalAppNotification(
      title: "Welcome 🎉",
      body: "Hi $userName, your account was created successfully!",
    );
  }

  /// Login message
  static Future<void> sendLoginMessage(String userName) async {
    await _firebaseNotifications.sendLocalAppNotification(
      title: "Login Successful ✅",
      body: "Welcome back, $userName!",
    );
  }

  /// You can add more messages here
  static Future<void> sendPasswordResetMessage(String userName) async {
    await _firebaseNotifications.sendLocalAppNotification(
      title: "Password Reset 🔑",
      body: "Hi $userName, your password has been reset successfully.",
    );
  }
}
