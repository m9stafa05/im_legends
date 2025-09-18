import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchMatches() async {
    final response = await supabase.from('matches').select('*');

    if (response.isEmpty) return [];
    return response;
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response = await supabase
        .from('users')
        .select('id, name, profile_image');
    return response;
  }
}
