import 'package:im_legends/features/auth/data/service/auth_service.dart';

class AuthRepo {
  final AuthService _authService = AuthService();

  Future<void> login({required String email, required String password}) async {
    try {
      await _authService.login(email: email, password: password);
    } catch (e) {
      // Rethrow so Cubit can handle the error
      throw Exception(e.toString());
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _authService.signUp(email: email, password: password);
    } catch (e) {
      // Rethrow so Cubit can handle the error
      throw Exception(e.toString());
    }
  }
}
