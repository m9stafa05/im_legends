import 'dart:io';
import 'package:flutter/material.dart';
import 'package:im_legends/core/service/supa_base_service.dart';
import 'package:im_legends/core/utils/notification_messages.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../../notification/data/service/firebase_notifications_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_data.dart';

class AuthService {
  final SupaBaseService _supaBaseService = SupaBaseService();

  static Future<bool> isLoggedIn() async {
    String? token = await SharedPrefStorage.instance.getString('userToken');
    return token != null && token.isNotEmpty;
  }

  /// ---------------------------
  /// SIGN UP
  /// ---------------------------
  Future<AuthResponse> signUp({
    required UserData userData,
    required String password,
    File? profileImage,
  }) async {
    try {
      // 1. Create user in Supabase Auth
      final response = await _supaBaseService.signUpUser(
        email: userData.email,
        password: password,
      );

      final uid = response.user?.id;
      if (uid == null) {
        throw Exception('Sign-up failed: UID not found.');
      }

      // 2. Upload profile image if provided
      String? imageUrl;
      if (profileImage != null) {
        imageUrl = await _supaBaseService.uploadProfileImage(profileImage, uid);
      }

      // 3. Insert user profile into 'users' table
      final updatedUserData = userData.copyWith(profileImageUrl: imageUrl);
      await _supaBaseService.insertUserData(updatedUserData.toMap(uid));

      // 4. Save FCM token for this user
      await FirebaseNotificationsService().initialize(uid);

      // Send sign-up notification
      final notification = NotificationMessages.signUpMessage(
        userId: uid,
        userName: userData.name,
        email: userData.email,
      );
      await SupaBaseService().insertNotificationFromModel(notification);

      debugPrint('Sign-up successful: $uid');
      return response;
    } catch (e) {
      debugPrint('❌ Sign-up error: $e');
      throw Exception('Sign-up failed: $e');
    }
  }

  /// ---------------------------
  /// LOGIN
  /// ---------------------------
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supaBaseService.loginUser(
        email: email,
        password: password,
      );

      if (response.user?.id == null) {
        throw Exception('Login failed: user not found.');
      }
      final uid = response.user!.id;

      // Initialize Firebase notifications first
      await FirebaseNotificationsService().initialize(uid);

      // Get user data and send login notification
      try {
        final userData = await _supaBaseService.fetchCurrentUserData();
        if (userData != null && userData['user'] != null) {
          final notification = NotificationMessages.loginMessage(
            userId: userData['user']['id'],
            userName: userData['user']['name'],
            email: userData['user']['email'],
          );
          await SupaBaseService().insertNotificationFromModel(notification);

          debugPrint('✅ Login notification sent successfully');
        } else {
          debugPrint('⚠️ Could not fetch user data for notification');
          // Send basic notification with email as fallback
          final notification = await NotificationMessages.loginMessage(
            userId: uid,
            userName: email.split('@')[0], // Use email prefix as name
            email: email,
          );
          await SupaBaseService().insertNotificationFromModel(notification);
        }
      } catch (notificationError) {
        debugPrint('⚠️ Failed to send login notification: $notificationError');
        // Don't throw - login was successful, notification is just a bonus
      }

      debugPrint('Login successful: ${response.user?.id}');
      return response;
    } catch (e) {
      debugPrint('❌ Login error: $e');
      throw Exception('Login failed: $e');
    }
  }

  /// ---------------------------
  /// LOGOUT
  /// ---------------------------
  Future<void> logout() async {
    try {
      final user = _supaBaseService.currentUser;
      if (user != null) {
        await _supaBaseService.removeAllTokens(user.id);
      }

      await _supaBaseService.logoutUser();
      debugPrint('User logged out.');
    } catch (e) {
      debugPrint('❌ Logout error: $e');
      throw Exception('Logout failed: $e');
    }
  }

  /// ---------------------------
  /// GET CURRENT USER DATA
  /// ---------------------------
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    return await _supaBaseService.fetchCurrentUserData();
  }

  /// ---------------------------
  /// GET USER SESSION DATA BY ID
  /// ---------------------------
  Future<Map<String, dynamic>?> getUserDataById(String userId) async {
    return await _supaBaseService.fetchUserProfileById(userId);
  }

  /// ---------------------------
  /// HELPER METHODS
  /// ---------------------------
  User? get currentUser => _supaBaseService.currentUser;

  bool get isUserLoggedIn => _supaBaseService.currentUser != null;
}
