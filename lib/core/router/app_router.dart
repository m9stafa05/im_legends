import 'package:flutter/material.dart';
import 'package:im_legends/core/router/routes.dart';



class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case  Routes.onBoardingScreen:
        // return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
