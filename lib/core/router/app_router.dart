import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/champion/data/repo/champion_repo.dart';
import '../../features/champion/logic/cubit/champion_cubit.dart';
import '../../features/home/data/repo/leader_board_repo.dart';
import '../../features/profile/data/repo/profile_repo.dart';
import '../../features/profile/logic/cubit/profile_cubit.dart';
import '../../features/history/logic/cubit/match_history_cubit.dart';
import '../../features/home/logic/cubit/leader_board_cubit.dart';
import '../../features/add_match/data/repo/add_match_repo.dart';
import '../../features/add_match/logic/cubit/add_match_cubit.dart';
import '../../features/auth/data/service/auth_service.dart';
import 'package:im_legends/features/notification/data/repos/notification_repo.dart';
import '../../features/notification/logic/cubit/notifications_cubit.dart';
import '../../features/notification/data/models/notification_model.dart';
import '../../features/notification/ui/notifications_screen.dart';
import '../../features/notification/ui/widgets/notification_details_screen.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';
import '../../features/auth/logic/cubit/auth_cubit.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/sign_up_screen.dart';
import '../../features/onboarding/ui/on_boarding_screen.dart';
import '../../features/add_match/ui/add_match_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/champion/ui/champion_screen.dart';
import '../../features/history/ui/history_screen.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../widgets/not_screen_found.dart';
import '../widgets/main_scaffold.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: Routes.onBoardingScreen,
  errorBuilder: (context, state) => const NotFoundScreen(),
  redirect: (context, state) async {
    final isLoggedIn = await AuthService.isLoggedIn();

    // Allow access to login and signup screens without redirect
    final loggingScreens = [Routes.loginScreen, Routes.signUpScreen];

    if (!isLoggedIn && !loggingScreens.contains(state.matchedLocation)) {
      return Routes.onBoardingScreen;
    }

    if (isLoggedIn && state.matchedLocation == Routes.onBoardingScreen) {
      return Routes.homeScreen;
    }

    return null;
  },

  routes: [
    GoRoute(
      path: Routes.onBoardingScreen,
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
      path: Routes.loginScreen,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit(authRepo: getIt<AuthRepo>())),
          BlocProvider(
            create: (_) =>
                NotificationsCubit(notificationRepo: getIt<NotificationRepo>()),
          ),
        ],
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: Routes.signUpScreen,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit(authRepo: getIt<AuthRepo>())),
          BlocProvider(
            create: (_) =>
                NotificationsCubit(notificationRepo: getIt<NotificationRepo>()),
          ),
        ],
        child: const SignUpScreen(),
      ),
    ),
    GoRoute(
      path: Routes.notificationScreen,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            NotificationsCubit(notificationRepo: getIt<NotificationRepo>())
              ..fetchNotifications(),
        child: const NotificationsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.notificationDetailsScreen,
      builder: (context, state) {
        final notification = state.extra as NotificationModel;
        return NotificationDetailsScreen(notification: notification);
      },
    ),

    /// -------------------------------
    /// Main scaffold as root for bottom nav
    /// -------------------------------
    ShellRoute(
      builder: (context, state, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                LeaderBoardCubit(repo: getIt<LeaderBoardRepo>())
                  ..loadLeaderboard(),
          ),
          BlocProvider(create: (_) => MatchHistoryCubit()..getMatchHistory()),
          BlocProvider(
            create: (context) =>
                AddMatchCubit(addMatchRepo: getIt<AddMatchRepo>()),
          ),
          BlocProvider(
            create: (_) =>
                ProfileCubit(profileRepo: getIt<ProfileRepo>())..fetchProfile(),
          ),
          BlocProvider(
            create: (_) =>
                ChampionCubit(repository: getIt<ChampionRepo>())
                  ..fetchTopThree(),
          ),
          BlocProvider(
            create: (_) =>
                NotificationsCubit(notificationRepo: getIt<NotificationRepo>()),
          ),
        ],
        child: MainScaffold(child: child),
      ),
      routes: [
        GoRoute(
          path: Routes.homeScreen,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: Routes.addMatchScreen,
          builder: (context, state) => const AddMatchScreen(),
        ),
        GoRoute(
          path: Routes.championsScreen,
          builder: (context, state) => const ChampionScreen(),
        ),
        GoRoute(
          path: Routes.historyScreen,
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: Routes.profileScreen,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
