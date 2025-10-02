import '../../../../core/models/players_states_model.dart';
import '../../../../core/models/user_data.dart';

class ChampionPlayerModel {
  final UserData user;
  final PlayerStatsModel stats;
  final int rank; 

  ChampionPlayerModel({
    required this.user,
    required this.stats,
    required this.rank,
  });

  ChampionPlayerModel copyWith({
    UserData? user,
    PlayerStatsModel? stats,
    int? rank,
  }) {
    return ChampionPlayerModel(
      user: user ?? this.user,
      stats: stats ?? this.stats,
      rank: rank ?? this.rank,
    );
  }
}
