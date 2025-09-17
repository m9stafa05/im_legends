part of 'add_match_cubit.dart';

@immutable
sealed class AddMatchState {}

final class AddMatchInitial extends AddMatchState {}

final class AddMatchLoading extends AddMatchState {}

final class AddMatchSuccess extends AddMatchState {
  final List<Map<String, dynamic>> players;
  AddMatchSuccess(this.players);
}

final class AddMatchFailure extends AddMatchState {
  final String error;
  AddMatchFailure(this.error);
}
