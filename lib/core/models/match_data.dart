// Match model for adding and history screens
// Place this in a models/ directory, e.g., lib/models/match.dart
class MatchData {
  final String player1Name; // Winner (or player1 for history)
  final String player2Name; // Loser (or player2 for history)
  final int player1Score; // Winner's score (higher than player2Score)
  final int player2Score; // Loser's score (lower than player1Score)
  final DateTime matchDate;
  final String? player1AvatarUrl;
  final String? player2AvatarUrl;

  const MatchData({
    required this.player1Name,
    required this.player2Name,
    required this.player1Score,
    required this.player2Score,
    required this.matchDate,
    this.player1AvatarUrl,
    this.player2AvatarUrl,
  });

  // Helper getters for winner determination (useful for history UI)
  bool get player1Won => player1Score > player2Score;
  bool get player2Won => player2Score > player1Score;
  bool get isTie => player1Score == player2Score;

  // Optional: Copy with method for immutability (if using in state management)
  MatchData copyWith({
    String? player1Name,
    String? player2Name,
    int? player1Score,
    int? player2Score,
    DateTime? matchDate,
    String? player1AvatarUrl,
    String? player2AvatarUrl,
  }) {
    return MatchData(
      player1Name: player1Name ?? this.player1Name,
      player2Name: player2Name ?? this.player2Name,
      player1Score: player1Score ?? this.player1Score,
      player2Score: player2Score ?? this.player2Score,
      matchDate: matchDate ?? this.matchDate,
      player1AvatarUrl: player1AvatarUrl ?? this.player1AvatarUrl,
      player2AvatarUrl: player2AvatarUrl ?? this.player2AvatarUrl,
    );
  }

  // Optional: toJson for serialization (e.g., to save in local DB or send to backend)
  Map<String, dynamic> toJson() {
    return {
      'player1Name': player1Name,
      'player2Name': player2Name,
      'player1Score': player1Score,
      'player2Score': player2Score,
      'matchDate': matchDate.toIso8601String(),
      'player1AvatarUrl': player1AvatarUrl,
      'player2AvatarUrl': player2AvatarUrl,
    };
  }

  // Optional: fromJson for deserialization
  factory MatchData.fromJson(Map<String, dynamic> json) {
    return MatchData(
      player1Name: json['player1Name'],
      player2Name: json['player2Name'],
      player1Score: json['player1Score'],
      player2Score: json['player2Score'],
      matchDate: DateTime.parse(json['matchDate']),
      player1AvatarUrl: json['player1AvatarUrl'],
      player2AvatarUrl: json['player2AvatarUrl'],
    );
  }
}
