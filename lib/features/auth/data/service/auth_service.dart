import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_data.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  /// ---------------------------
  /// UPLOAD PROFILE IMAGE
  /// ---------------------------
  Future<String> uploadProfileImage(File imageFile, String userId) async {
    final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = '$userId/$fileName';

    try {
      await supabase.storage.from('profile_images').upload(filePath, imageFile);
      return supabase.storage.from('profile_images').getPublicUrl(filePath);
    } on StorageException catch (e) {
      throw Exception('Failed to upload profile image: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while uploading profile image: $e');
    }
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
      final response = await supabase.auth.signUp(
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
        imageUrl = await uploadProfileImage(profileImage, uid);
      }

      // 3. Insert user profile into 'users' table
      final updatedUserData = userData.copyWith(profileImageUrl: imageUrl);
      await supabase.from('users').insert(updatedUserData.toMap(uid));

      debugPrint('Sign-up successful: $uid');
      return response;
    } on AuthException catch (e) {
      throw Exception('Sign-up failed: ${e.message}');
    } on PostgrestException catch (e) {
      throw Exception('Database error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during sign-up: $e');
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
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user?.id == null) {
        throw Exception('Login failed: user not found.');
      }

      debugPrint('Login successful: ${response.user?.id}');
      return response;
    } on AuthException catch (e) {
      throw Exception('Login failed: ${e.message}');
    } on PostgrestException catch (e) {
      throw Exception('Database error during login: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during login: $e');
    }
  }

  /// ---------------------------
  /// LOGOUT
  /// ---------------------------
  Future<void> logout() async {
    await supabase.auth.signOut();
    debugPrint('User logged out.');
  }

  /// ---------------------------
  /// GET CURRENT USER DATA
  /// ---------------------------
  Future<UserData?> getCurrentUserData() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .single();

      return UserData.fromMap(data);
    } on PostgrestException catch (e) {
      debugPrint('Database error fetching current user: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected error fetching current user: $e');
      return null;
    }
  }
}
