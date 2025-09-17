import 'package:bloc/bloc.dart';
import '../../data/repo/add_match_repo.dart';
import 'package:meta/meta.dart';

part 'add_match_state.dart';

class AddMatchCubit extends Cubit<AddMatchState> {
  final AddMatchRepo addMatchRepo;

  AddMatchCubit({required this.addMatchRepo}) : super(AddMatchInitial());

  Future<void> getPlayersList() async {
    emit(AddMatchLoading());
    try {
      final players = await addMatchRepo.getAllUsers();
      emit(AddMatchSuccess(players));
    } catch (e) {
      emit(AddMatchFailure(e.toString()));
    }
  }
}
