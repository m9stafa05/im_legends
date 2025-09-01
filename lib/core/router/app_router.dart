import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_legends/core/widgets/not_screen_found.dart';
import 'package:im_legends/features/add_match/ui/add_match_screen.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';
import '../widgets/main_scaffold.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/logic/cubit/auth_cubit.dart';
import '../../features/auth/ui/login_screen.dart';
import 'package:im_legends/features/auth/ui/sign_up_screen.dart';
import '../../features/champion/ui/champion_screen.dart';
import '../../features/history/ui/history_screen.dart';
import 'package:im_legends/features/onboarding/ui/on_boarding_screen.dart';
import '../../features/profile/ui/profile_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(authRepo: getIt<AuthRepo>()),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(authRepo: getIt<AuthRepo>()),
            child: const SignUpScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const MainScaffold());
      case Routes.addMatchScreen:
        return MaterialPageRoute(builder: (_) => const AddMatchScreen());
      case Routes.championsScreen:
        return MaterialPageRoute(builder: (_) => const ChampionScreen());
      case Routes.historyScreen:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundScreen(),
        );
    }
  }
}
