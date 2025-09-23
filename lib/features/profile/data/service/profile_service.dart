import 'package:im_legends/core/models/players_states_model.dart';
import 'package:im_legends/core/models/user_data.dart';
import '../../../../core/service/supa_base_service.dart';

class ProfileService {
  final SupaBaseService supabaseService = SupaBaseService();

  /// ✅ Fetch player stats (calculated from matches)
  Future<PlayerStatsModel> fetchPlayerStats(String userId) async {
    try {
      // 1. Fetch matches where user is winner or loser
      final matches = await supabaseService.supabase
          .from('matches')
          .select()
          .or('winner_id.eq.$userId,loser_id.eq.$userId');

      // 2. Fetch player basic data
      final user = await supabaseService.fetchUserProfileById(userId);
      if (user == null) {
        throw Exception("User not found");
      }

      int matchesPlayed = 0;
      int wins = 0;
      int goals = 0;
      int points = 0;

      for (var match in matches) {
        final winnerId = match['winner_id'] as String;
        final loserId = match['loser_id'] as String;
        final winnerScore = match['winner_score'] as int;
        final loserScore = match['loser_score'] as int;

        if (winnerId == userId) {
          matchesPlayed++;
          wins++;
          goals += winnerScore;
          points += 3; // win = 3 points
        } else if (loserId == userId) {
          matchesPlayed++;
          goals += loserScore;
        }
      }

      return PlayerStatsModel(
        playerId: user['id'],
        playerName: user['name'],
        profileImage: user['profile_image'],
        matchesPlayed: matchesPlayed,
        wins: wins,
        goals: goals,
        points: points,
      );
    } catch (e) {
      print("❌ Error fetching stats: $e");
      rethrow;
    }
  }

  /// ✅ Fetch user base info
  Future<UserData> fetchUserData(String userId) async {
    try {
      final response = await supabaseService.supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single();

      return UserData.fromMap(response);
    } catch (e) {
      print("❌ Error fetching user data: $e");
      rethrow;
    }
  }

  /// ✅ Logout the current user
  Future<void> logout() async {
    try {
      await supabaseService.logoutUser();
      print("✅ User logged out successfully from ProfileService");
    } catch (e) {
      print("❌ Logout failed: $e");
      rethrow;
    }
  }
}
