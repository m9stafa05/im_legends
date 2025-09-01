import 'package:get_it/get_it.dart';
import 'package:im_legends/features/auth/data/service/auth_service.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/logic/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // 1. Register AuthService as a singleton (shared instance)
  getIt.registerLazySingleton<AuthService>(() => AuthService());

  // 2. Register AuthRepo as a singleton (depends on AuthService)
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepo(authService: getIt<AuthService>()),
  );

  // 3. Register AuthCubit as a factory (new instance each time)
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepo: getIt<AuthRepo>()),
  );
}
