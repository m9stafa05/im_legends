import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_legends/core/router/routes.dart';
import 'package:im_legends/features/auth/logic/cubit/auth_cubit.dart';
import 'package:im_legends/features/auth/ui/login_screen.dart';
import 'package:im_legends/features/auth/ui/sign_up_screen.dart';
import 'package:im_legends/features/home/ui/home_screen.dart';
import 'package:im_legends/features/onboarding/ui/on_boarding_screen.dart';

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
            create: (context) => AuthCubit(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SignUpScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
