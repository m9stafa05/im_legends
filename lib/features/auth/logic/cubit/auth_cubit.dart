import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repo/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/user_data.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepo authRepo}) : super(AuthInitial());

  final AuthRepo authRepo = AuthRepo();

  Future<void> emitSignUp({
    required UserData userData,
    required String password,
    File? profileImage,
  }) async {
    emit(AuthLoading());
    try {
      final response = await authRepo.signUp(
        userData: userData,
        password: password,
        profileImage: profileImage,
      );
      emit(AuthSuccess(authResponse: response));
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> emitLogin({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final response = await authRepo.login(email: email, password: password);
      emit(AuthSuccess(authResponse: response));
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }
}
