part of 'champion_cubit.dart';

@immutable
sealed class ChampionState {}

final class ChampionInitial extends ChampionState {}

final class ChampionLoading extends ChampionState {}

final class ChampionSuccess extends ChampionState {
  final List<ChampionPlayerModel> players;

  ChampionSuccess(this.players);
}

final class ChampionFailure extends ChampionState {
  final String errorMessage;

  ChampionFailure(this.errorMessage);
}
