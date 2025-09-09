import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'widgets/champion_header.dart';
import 'widgets/champion_states.dart';
import 'widgets/champion_top_three.dart';

class ChampionScreen extends StatelessWidget {
  const ChampionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: 'Champions'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ChampionHeader(name: 'Mustafa Elbaz'),
                  ChampionStats(goals: 10, points: 50, wins: 5, matches: 7),
                  ChampionTopThree(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
