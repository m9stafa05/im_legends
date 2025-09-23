part of 'match_history_cubit.dart';

@immutable
sealed class MatchHistoryState {}

final class MatchHistoryInitial extends MatchHistoryState {}

final class MatchHistoryLoading extends MatchHistoryState {}

final class MatchHistorySuccess extends MatchHistoryState {
  final List<MatchHistoryCardModel> matches;
  MatchHistorySuccess({required this.matches});
}

final class MatchHistoryError extends MatchHistoryState {
  final String errorMessage;
  MatchHistoryError({required this.errorMessage});
}
