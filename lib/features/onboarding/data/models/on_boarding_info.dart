import 'package:flutter/material.dart';

class OnBoardingInfo {
  final String title;
  final String subTitle;
  final IconData? icon;
  final List<Color>? gradient;

  const OnBoardingInfo({
    required this.title,
    required this.subTitle,
    this.icon,
    this.gradient,
  });

  // Centralized onboarding data for friends football match tracking app
  static const List<OnBoardingInfo> cardsData = [
    OnBoardingInfo(
      title: 'Record Friend Matches',
      subTitle:
          'Store every goal, assist and epic moment from your crew\'s games.',
      icon: Icons.sports_soccer,
    // Red gradient
    ),
    OnBoardingInfo(
      title: 'Championship Mode',
      subTitle:
          'Create tournaments and crown the ultimate champion in your squad.',
      icon: Icons.emoji_events,
    ),
    OnBoardingInfo(
      title: 'Friends Leaderboard',
      subTitle: 'See who\'s dominating with goals, wins and bragging rights.',
      icon: Icons.leaderboard,

    ),
    OnBoardingInfo(
      title: 'Match History',
      subTitle: 'Never forget those legendary games and comeback victories.',
      icon: Icons.history,

    ),
    OnBoardingInfo(
      title: 'Player Stats',
      subTitle:
          'Track individual performance and become the GOAT of your group.',
      icon: Icons.bar_chart,

    ),
    OnBoardingInfo(
      title: 'Squad Management',
      subTitle:
          'Organize teams, invite friends and build your football empire.',
      icon: Icons.group,

    ),
  ];

  // Method to get cards in pairs for grid layout
  static List<List<OnBoardingInfo>> get cardsPairs {
    List<List<OnBoardingInfo>> pairs = [];
    for (int i = 0; i < cardsData.length; i += 2) {
      if (i + 1 < cardsData.length) {
        pairs.add([cardsData[i], cardsData[i + 1]]);
      } else {
        pairs.add([cardsData[i]]);
      }
    }
    return pairs;
  }

  // Method to get featured cards (first 4 for main onboarding)
  static List<OnBoardingInfo> get featuredCards => cardsData.take(4).toList();
}
