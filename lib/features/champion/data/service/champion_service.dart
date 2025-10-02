import '../../../../core/models/players_states_model.dart';
import 'package:im_legends/core/models/user_data.dart';
import '../model/champion_player_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChampionService {
  final supabase = Supabase.instance.client;

  ChampionService();

  /// Fetch matches from DB
  Future<List<Map<String, dynamic>>> _fetchMatches() async {
    return await supabase.from('matches').select('*');
  }

  /// Fetch all users (only needed fields)
  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    return await supabase
        .from('users')
        .select('id, name, profile_image'); // only what we need
  }

  /// Fetch only Top 3 leaderboard with rank
  Future<List<ChampionPlayerModel>> fetchTopThree() async {
    final matches = await _fetchMatches();
    final users = await _fetchUsers();

    // Map userId → stats
    final Map<String, PlayerStatsModel> statsMap = {
      for (var u in users)
        u['id']: PlayerStatsModel(
          playerId: u['id'],
          playerName: u['name'],
          profileImage: u['profile_image'],
        ),
    };

    // Update stats from matches
    for (var match in matches) {
      final winnerId = match['winner_id'] as String;
      final loserId = match['loser_id'] as String;
      final winnerScore = match['winner_score'] as int;
      final loserScore = match['loser_score'] as int;

      // Winner
      final winner = statsMap[winnerId]!;
      statsMap[winnerId] = winner.copyWith(
        matchesPlayed: winner.matchesPlayed + 1,
        wins: winner.wins + 1,
        goals: winner.goals + winnerScore,
        points: winner.points + 3,
      );

      // Loser
      final loser = statsMap[loserId]!;
      statsMap[loserId] = loser.copyWith(
        matchesPlayed: loser.matchesPlayed + 1,
        goals: loser.goals + loserScore,
      );
    }

    // Sort by points DESC
    final sorted = statsMap.values.toList()
      ..sort((a, b) => b.points.compareTo(a.points));

    // Build Top 3 only
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
        email: '', // not needed for champion view
        phoneNumber: '',
        age: 0,
        profileImageUrl: userMap['profile_image'],
      );

      topThree.add(
        ChampionPlayerModel(
          user: user,
          stats: stat,
          rank: i + 1, // assign rank
        ),
      );
    }

    return topThree;
  }
}
