import 'package:get_it/get_it.dart';
import '../../features/profile/data/repo/profile_repo.dart';
import '../../features/profile/data/service/profile_service.dart';
import '../../features/profile/logic/cubit/profile_cubit.dart';
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
  getIt.registerLazySingleton<ProfileService>(() => ProfileService());

  // Repositories
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepo(authService: getIt<AuthService>()),
  );
  getIt.registerLazySingleton<NotificationRepo>(() => NotificationRepo());
  getIt.registerLazySingleton<AddMatchRepo>(() => AddMatchRepo());
  getIt.registerLazySingleton<LeaderBoardRepo>(
    () => LeaderBoardRepo(leaderboardService: getIt<LeaderboardService>()),
  );
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepo(profileService: getIt<ProfileService>()),
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
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(profileRepo: getIt<ProfileRepo>()),
  );
}
