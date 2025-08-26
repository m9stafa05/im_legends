class OnBoardingInfo {
  final String title;
  final String subTitle;

  const OnBoardingInfo({required this.title, required this.subTitle});
  // Centralized onboarding data for easier scaling/localization
  static const List<OnBoardingInfo> cardsData = [
    OnBoardingInfo(
      title: 'Track Your Rankings',
      subTitle:
          'See how you stack up against friends in real-time leaderboards.',
    ),
    OnBoardingInfo(
      title: 'Log New Matches',
      subTitle: 'Record scores & stats with ease after every thrilling game.',
    ),
    OnBoardingInfo(
      title: 'Earn Badges & Rewards',
      subTitle: 'Unlock milestones and show off your football achievements.',
    ),
    OnBoardingInfo(
      title: 'Play Anywhere, Anytime',
      subTitle: 'No internet? No problem. Enjoy offline mode features.',
    ),
  ];
}
