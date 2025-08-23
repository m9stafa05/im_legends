import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  /// Create a Dio instance using DioFactory
  // Dio dio = DioFactory.getDio();
  /// Register ApiService as a lazy singleton
  // getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  /// Login
  // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  // getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  /// SigUp
  // getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepo(getIt()));
  // getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
}
