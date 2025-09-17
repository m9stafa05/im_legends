import 'package:get_it/get_it.dart';
import '../../features/notification/data/repos/notification_repo.dart';
import '../../features/notification/logic/cubit/notifications_cubit.dart';
import '../../features/auth/data/service/auth_service.dart';
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

  // 4. Register NotificationRepo as a singleton (shared instance)
  getIt.registerLazySingleton<NotificationRepo>(() => NotificationRepo());

  getIt.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(notificationRepo: getIt<NotificationRepo>()),
  );
}
