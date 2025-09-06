import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseService {
  final supabase = Supabase.instance.client;

  /// ---------------------------
  /// Save or update FCM token
  /// ---------------------------
  Future<void> saveOrUpdateToken(String userId, String token) async {
    try {
      await supabase.from('user_tokens').upsert({
        'user_id': userId,
        'token': token,
      }, onConflict: 'user_id');
      debugPrint('Token upserted for user $userId');
    } catch (e) {
      debugPrint('❌ Error upserting token for user $userId: $e');
    }
  }

  /// ---------------------------
  /// Remove a specific device token
  /// ---------------------------
  Future<void> removeToken(String userId, String token) async {
    try {
      await supabase.from('user_tokens').delete().match({
        'user_id': userId,
        'token': token,
      });
    } catch (e) {
      print('❌ Error removing token for user $userId: $e');
    }
  }

  /// ---------------------------
  /// Remove all tokens for a user
  /// ---------------------------
  Future<void> removeAllTokens(String userId) async {
    try {
      await supabase.from('user_tokens').delete().eq('user_id', userId);
    } catch (e) {
      print('❌ Error removing all tokens for user $userId: $e');
    }
  }

  /// ---------------------------
  /// Get all tokens for a user
  /// ---------------------------
  Future<List<String>> getUserTokens(String userId) async {
    try {
      final response = await supabase
          .from('user_tokens')
          .select('token')
          .eq('user_id', userId);
      return List<String>.from(response.map((row) => row['token'] as String));
    } catch (e) {
      print('❌ Error fetching tokens for user $userId: $e');
      return [];
    }
  }
}
