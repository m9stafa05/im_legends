part of 'add_match_cubit.dart';

@immutable
sealed class AddMatchState {}

final class AddMatchInitial extends AddMatchState {}

final class AddMatchLoading extends AddMatchState {}

// For players list
final class AddMatchPlayersSuccess extends AddMatchState {
  final List<Map<String, dynamic>> players;
  AddMatchPlayersSuccess(this.players);
}

// For insert match success
final class AddMatchInsertSuccess extends AddMatchState {
  final String message;
  AddMatchInsertSuccess(this.message);
}

final class AddMatchFailure extends AddMatchState {
  final String error;
  AddMatchFailure(this.error);
}
