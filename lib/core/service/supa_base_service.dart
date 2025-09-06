import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseService {
  final supabase = Supabase.instance.client;

  Future<void> saveTokenToSupabase(String userId, String token) async {
    await supabase.from('user_tokens').upsert({
      'user_id': userId,
      'token': token,
    });
  }
}
