import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

final GoRouter router = GoRouter(
  initialLocation: Routes.homeScreen,
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: [
    GoRoute(
      path: Routes.onBoardingScreen,
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
      path: Routes.loginScreen,
      builder: (context, state) => BlocProvider(
        create: (_) => AuthCubit(authRepo: getIt<AuthRepo>()),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: Routes.signUpScreen,
      builder: (context, state) => BlocProvider(
        create: (_) => AuthCubit(authRepo: getIt<AuthRepo>()),
        child: const SignUpScreen(),
      ),
    ),
    // Main scaffold as root for bottom nav
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
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
