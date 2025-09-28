abstract class Routes {
  // Public routes
  static const String onBoardingScreen = '/onboarding';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/signup';

  // Protected main navigation routes
  static const String homeScreen = '/home';
  static const String addMatchScreen = '/add-match';
  static const String championsScreen = '/champions';
  static const String historyScreen = '/history';
  static const String profile = '/profile';

  // Protected standalone routes
  static const String notificationsScreen = '/notifications';
  static const String notificationDetailsScreen = '/notification-details';

  /// Public route paths that don't require authentication
  static const List<String> publicRoutes = [
    onBoardingScreen,
    loginScreen,
    signUpScreen,
  ];
}
