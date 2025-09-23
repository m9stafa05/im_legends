import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../logic/cubit/match_history_cubit.dart';
import 'widgets/history_list_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: 'History'),
          BlocBuilder<MatchHistoryCubit, MatchHistoryState>(
            builder: (context, state) {
              if (state is MatchHistoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MatchHistorySuccess) {
                final matches = state.matches;
                print(matches.length);
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) =>
                        HistoryListCard(match: matches[index]),
                    itemCount: matches.length,
                  ),
                );
              } else if (state is MatchHistoryError) {
                return Center(child: Text(state.errorMessage));
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
