part of 'leader_board_cubit.dart';

@immutable
sealed class LeaderBoardState {}

final class LeaderBoardInitial extends LeaderBoardState {}

final class LeaderBoardLoading extends LeaderBoardState {}

final class LeaderBoardSuccess extends LeaderBoardState {
  final List<PlayerStatsModel> leaderboard;
  LeaderBoardSuccess(this.leaderboard);
}

final class LeaderBoardFailure extends LeaderBoardState {
  final String message;
  LeaderBoardFailure(this.message);
}
