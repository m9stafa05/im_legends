import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:im_legends/features/auth/data/repo/auth_repo.dart';

import '../../data/models/user_data.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthRepo authRepo = AuthRepo();

  Future<void> emitLogin({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await authRepo.login(email: email, password: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> emitSignUp({
    required UserData userData,
    required password,
  }) async {
    emit(AuthLoading());
    try {
      await authRepo.signUp(userData: userData, password: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }
}
