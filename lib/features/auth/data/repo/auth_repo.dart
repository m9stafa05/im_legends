import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_data.dart';
import '../service/auth_service.dart';

class AuthRepo {
  final AuthService _authService;

  AuthRepo({AuthService? authService})
    : _authService = authService ?? AuthService();

  /// Sign up user and return their data
  Future<AuthResponse> signUp({
    required UserData userData,
    required String password,
    File? profileImage,
  }) async {
    try {
      return await _authService.signUp(
        userData: userData,
        password: password,
        profileImage: profileImage,
      );
    } catch (e, stackTrace) {
      debugPrint('Sign-up error: $e\n$stackTrace');
      rethrow; // Keeps original error trace
    }
  }

  /// Login and return user data or auth response
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _authService.login(email: email, password: password);
    } catch (e, stackTrace) {
      debugPrint('Login error: $e\n$stackTrace');
      rethrow;
    }
  }
}
