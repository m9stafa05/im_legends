import 'package:bloc/bloc.dart';
import '../../data/models/match_model.dart';
import '../../data/repo/add_match_repo.dart';
import 'package:meta/meta.dart';

part 'add_match_state.dart';

class AddMatchCubit extends Cubit<AddMatchState> {
  final AddMatchRepo addMatchRepo;

  AddMatchCubit({required this.addMatchRepo}) : super(AddMatchInitial());

  // Fetch players
  Future<void> getPlayersList() async {
    emit(AddMatchLoading());
    try {
      final players = await addMatchRepo.getAllUsers();
      emit(AddMatchPlayersSuccess(players));
    } catch (e) {
      emit(AddMatchFailure(e.toString()));
    }
  }

  // Insert a match
  Future<void> addMatch(MatchModel match) async {
    emit(AddMatchLoading());
    try {
      final success = await addMatchRepo.addMatch(match);
      if (success) {
        emit(AddMatchInsertSuccess("✅ Match inserted successfully"));
      } else {
        emit(AddMatchFailure("⚠️ Failed to insert match"));
      }
    } catch (e) {
      emit(AddMatchFailure(e.toString()));
    }
  }
}
