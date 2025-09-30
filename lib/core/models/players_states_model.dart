class PlayerStatsModel {
  final String playerId;
  final String playerName;
  final String? profileImage;
  final int matchesPlayed;
  final int wins;
  final int goals;
  final int points;
  final int? rank; 

  PlayerStatsModel({
    required this.playerId,
    required this.playerName,
    this.profileImage,
    this.matchesPlayed = 0,
    this.wins = 0,
    this.goals = 0,
    this.points = 0,
    this.rank = 0, 
  });

  PlayerStatsModel copyWith({
    String? playerId,
    String? playerName,
    String? profileImage,
    int? matchesPlayed,
    int? wins,
    int? goals,
    int? points,
    int? rank,
  }) {
    return PlayerStatsModel(
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      profileImage: profileImage ?? this.profileImage,
      matchesPlayed: matchesPlayed ?? this.matchesPlayed,
      wins: wins ?? this.wins,
      goals: goals ?? this.goals,
      points: points ?? this.points,
      rank: rank ?? this.rank, 
    );
  }
}
