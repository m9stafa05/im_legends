import 'package:bloc/bloc.dart';
import '../../data/model/profile_model.dart';
import 'package:meta/meta.dart';
import '../../data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  /// ✅ Fetch profile with stats
  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    try {
      final player = await profileRepo.getProfileWithStats();
      if (player != null) {
        emit(ProfileSuccess(player: player));
      } else {
        emit(ProfileFailure("Profile not found"));
      }
    } catch (e) {
      emit(ProfileFailure("❌ Failed to fetch profile: $e"));
    }
  }

  /// ✅ Logout the current user
  Future<void> logout() async {
    emit(ProfileLoading());
    try {
      await profileRepo.logout();
      emit(ProfileLoggedOut()); // 🔥 new dedicated state
    } catch (e) {
      emit(ProfileFailure("❌ Logout failed: $e"));
    }
  }
}
