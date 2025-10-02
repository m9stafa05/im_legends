import 'package:get_it/get_it.dart';
import '../../features/champion/data/repo/champion_repo.dart';
import '../../features/champion/data/service/champion_service.dart';
import '../../features/champion/logic/cubit/champion_cubit.dart';
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
  // Auth Dependencies
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepo(authService: getIt<AuthService>()),
  );

  // Leaderboard Dependencies
  getIt.registerLazySingleton<LeaderboardService>(() => LeaderboardService());
  getIt.registerLazySingleton<LeaderBoardRepo>(
    () => LeaderBoardRepo(leaderboardService: getIt<LeaderboardService>()),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerFactory<LeaderBoardCubit>(
    () => LeaderBoardCubit(repo: getIt<LeaderBoardRepo>()),
  );

  // Add Match Dependencies
  getIt.registerLazySingleton<AddMatchRepo>(() => AddMatchRepo());
  getIt.registerFactory<AddMatchCubit>(
    () => AddMatchCubit(addMatchRepo: getIt<AddMatchRepo>()),
  );

  //  Champion Dependencies
  getIt.registerLazySingleton<ChampionService>(() => ChampionService());
  getIt.registerLazySingleton<ChampionRepo>(
    () => ChampionRepo(championService: getIt<ChampionService>()),
  );
  getIt.registerFactory<ChampionCubit>(
    () => ChampionCubit(repository: getIt<ChampionRepo>()),
  );

  //  Profile Dependencies
  getIt.registerLazySingleton<ProfileService>(() => ProfileService());
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepo(profileService: getIt<ProfileService>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(profileRepo: getIt<ProfileRepo>()),
  );

  // Notification Dependencies
  getIt.registerLazySingleton<NotificationRepo>(() => NotificationRepo());
  getIt.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(notificationRepo: getIt<NotificationRepo>()),
  );
}
