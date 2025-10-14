import '../../../../core/models/players_states_model.dart';
import '../../../../core/models/user_data.dart';
import '../model/champion_player_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChampionService {
  final supabase = Supabase.instance.client;

  ChampionService();

  /// Fetch matches from the database
  Future<List<Map<String, dynamic>>> _fetchMatches() async {
    return await supabase.from('matches').select('*');
  }

  /// Fetch all users (only needed fields)
  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    return await supabase.from('users').select('id, name, profile_image');
  }

  /// Fetch Top 3 leaderboard players
  Future<List<ChampionPlayerModel>> fetchTopThree() async {
    final matches = await _fetchMatches();
    final users = await _fetchUsers();

    // Initialize each player's stats
    final Map<String, PlayerStatsModel> statsMap = {
      for (var u in users)
        u['id']: PlayerStatsModel(
          playerId: u['id'],
          playerName: u['name'],
          profileImage: u['profile_image'],
        ),
    };

    // --- Calculate Stats from Matches ---
    for (var match in matches) {
      final winnerId = match['winner_id'] as String;
      final loserId = match['loser_id'] as String;
      final winnerScore = match['winner_score'] as int;
      final loserScore = match['loser_score'] as int;

      final winner = statsMap[winnerId]!;
      final loser = statsMap[loserId]!;

      // ✅ Winner stats update
      statsMap[winnerId] = winner.copyWith(
        matchesPlayed: winner.matchesPlayed + 1,
        wins: winner.wins + 1,
        goalsScored: winner.goalsScored + winnerScore,
        goalsReceived: winner.goalsReceived + loserScore,
        goalDifference:
            (winner.goalsScored + winnerScore) -
            (winner.goalsReceived + loserScore),
        points: winner.points + 3,
      );

      // ✅ Loser stats update
      statsMap[loserId] = loser.copyWith(
        matchesPlayed: loser.matchesPlayed + 1,
        losses: loser.losses + 1,
        goalsScored: loser.goalsScored + loserScore,
        goalsReceived: loser.goalsReceived + winnerScore,
        goalDifference:
            (loser.goalsScored + loserScore) -
            (loser.goalsReceived + winnerScore),
      );
    }

    // --- Sort leaderboard by standard football ranking ---
    final sorted = statsMap.values.toList()
      ..sort((a, b) {
        if (b.points != a.points) {
          return b.points.compareTo(a.points);
        } else if (b.goalDifference != a.goalDifference) {
          return b.goalDifference.compareTo(a.goalDifference);
        } else {
          return b.goalsScored.compareTo(a.goalsScored);
        }
      });

    // --- Build Top 3 Champions ---
    final topThree = <ChampionPlayerModel>[];
    for (int i = 0; i < sorted.length && i < 3; i++) {
      final stat = sorted[i];
      final userMap = users.firstWhere(
        (u) => u['id'] == stat.playerId,
        orElse: () => {},
      );

      if (userMap.isEmpty) continue;

      final user = UserData(
        name: userMap['name'] ?? '',
        email: '', // not needed for champion section
        phoneNumber: '',
        age: 0,
        profileImageUrl: userMap['profile_image'],
      );

      topThree.add(
        ChampionPlayerModel(
          user: user,
          stats: stat.copyWith(rank: i + 1),
          rank: i + 1,
        ),
      );
    }

    return topThree;
  }
}
