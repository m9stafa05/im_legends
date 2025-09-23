import 'package:supabase_flutter/supabase_flutter.dart';

class HistoryService {
  final SupabaseClient supabase = Supabase.instance.client;

  /// Fetch matches with winner and loser info joined
  Future<List<Map<String, dynamic>>> fetchMatches() async {
    try {
      final response = await supabase
          .from('matches')
          .select('''
            id,
            winner_score,
            loser_score,
            created_at,
            winner:users!matches_winner_fkey (
              id,
              name,
              profile_image
            ),
            loser:users!matches_loser_fkey (
              id,
              name,
              profile_image
            )
          ''')
          .order('created_at', ascending: false);

      // Supabase returns dynamic → cast it properly
      if (response.isNotEmpty) {
        return response.cast<Map<String, dynamic>>();
      }

      return [];
    } catch (e) {
      // Log error if needed
      print('Error fetching matches: $e');
      return [];
    }
  }
}
