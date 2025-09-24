import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubit/champion_cubit.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'widgets/champion_header.dart';
import 'widgets/champion_states.dart';
import 'widgets/champion_top_three.dart';

class ChampionScreen extends StatelessWidget {
  const ChampionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: 'Champions'),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<ChampionCubit, ChampionState>(
                builder: (context, state) {
                  if (state is ChampionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChampionSuccess) {
                    final champion = state.players[0];
                    final topThree = state.players;
                    return Column(
                      children: [
                        ChampionHeader(name: champion.user.name),
                        ChampionStats(
                          goals: champion.stats.goals,
                          points: champion.stats.points,
                          wins: champion.stats.wins,
                          matches: champion.stats.matchesPlayed,
                        ),
                        ChampionTopThree(topThree: topThree),
                      ],
                    );
                  } else if (state is ChampionFailure) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
