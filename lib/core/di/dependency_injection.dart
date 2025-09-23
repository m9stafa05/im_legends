import 'package:get_it/get_it.dart';
import '../../features/home/data/repo/leader_board_repo.dart';
import '../../features/home/data/service/leader_board_service.dart';
import '../../features/home/logic/cubit/leader_board_cubit.dart';
import '../../features/add_match/data/repo/add_match_repo.dart';
import '../../features/add_match/logic/cubit/add_match_cubit.dart';
import '../../features/notification/data/repos/notification_repo.dart';
import '../../features/notification/logic/cubit/notifications_cubit.dart';
import '../../features/auth/data/service/auth_service.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/logic/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Services
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<LeaderboardService>(() => LeaderboardService());

  // Repositories
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepo(authService: getIt<AuthService>()),
  );
  getIt.registerLazySingleton<NotificationRepo>(() => NotificationRepo());
  getIt.registerLazySingleton<AddMatchRepo>(() => AddMatchRepo());
  getIt.registerLazySingleton<LeaderBoardRepo>(
    () => LeaderBoardRepo(leaderboardService: getIt<LeaderboardService>()),
  );

  // Cubits (always factory)
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(notificationRepo: getIt<NotificationRepo>()),
  );
  getIt.registerFactory<AddMatchCubit>(
    () => AddMatchCubit(addMatchRepo: getIt<AddMatchRepo>()),
  );
  getIt.registerFactory<LeaderBoardCubit>(
    () => LeaderBoardCubit(repo: getIt<LeaderBoardRepo>()),
  );
}
