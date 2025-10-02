import '../../../../core/models/players_states_model.dart';
import '../service/leader_board_service.dart';

class LeaderBoardRepo {
  final LeaderboardService _leaderboardService;

  LeaderBoardRepo({required LeaderboardService leaderboardService})
    : _leaderboardService = leaderboardService;

  Future<List<PlayerStatsModel>> calculateLeaderboard() async {
    final matches = await _leaderboardService.fetchMatches();
    final users = await _leaderboardService.fetchUsers();

    final Map<String, PlayerStatsModel> stats = {
      for (var u in users)
        u['id']: PlayerStatsModel(
          playerId: u['id'],
          playerName: u['name'],
          profileImage: u['profile_image'],
        ),
    };

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

    final leaderboard = stats.values.toList()
      ..sort((a, b) => b.points.compareTo(a.points));

    // Assign ranks
    for (int i = 0; i < leaderboard.length; i++) {
      leaderboard[i] = leaderboard[i].copyWith(rank: i + 1);
    }

    return leaderboard;
  }
}
