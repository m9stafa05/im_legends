import 'package:im_legends/core/models/players_states_model.dart';
import 'package:im_legends/core/models/user_data.dart';
import '../../../../core/service/supa_base_service.dart';

class ProfileService {
  final SupaBaseService supabaseService = SupaBaseService();

  /// ✅ Fetch player stats including rank
  Future<PlayerStatsModel> fetchPlayerStats(String userId) async {
    try {
      // 1. Fetch all users
      final users = await supabaseService.supabase.from('users').select();

      // 2. Fetch all matches
      final matches = await supabaseService.supabase.from('matches').select();

      // 3. Build initial stats map
      final Map<String, PlayerStatsModel> stats = {
        for (var u in users)
          u['id']: PlayerStatsModel(
            playerId: u['id'],
            playerName: u['name'],
            profileImage: u['profile_image'],
          ),
      };

      // 4. Calculate stats from matches
      for (var match in matches) {
        final winnerId = match['winner_id'] as String;
        final loserId = match['loser_id'] as String;
        final winnerScore = match['winner_score'] as int;
        final loserScore = match['loser_score'] as int;

        // Winner
        final winner = stats[winnerId]!;
        stats[winnerId] = winner.copyWith(
          matchesPlayed: winner.matchesPlayed + 1,
          wins: winner.wins + 1,
          goals: winner.goals + winnerScore,
          points: winner.points + 3,
        );

        // Loser
        final loser = stats[loserId]!;
        stats[loserId] = loser.copyWith(
          matchesPlayed: loser.matchesPlayed + 1,
          goals: loser.goals + loserScore,
        );
      }

      // 5. Sort leaderboard
      final leaderboard = stats.values.toList()
        ..sort((a, b) => b.points.compareTo(a.points));

      // 6. Assign ranks
      for (int i = 0; i < leaderboard.length; i++) {
        leaderboard[i] = leaderboard[i].copyWith(rank: i + 1);
      }

      // 7. Return this user's stats with rank
      final playerStats = leaderboard.firstWhere((p) => p.playerId == userId);

      return playerStats;
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
