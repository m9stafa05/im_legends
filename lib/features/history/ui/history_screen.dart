import 'package:flutter/material.dart';
import 'package:im_legends/core/widgets/custom_app_bar.dart';
import 'package:im_legends/features/history/ui/widgets/history_list_card.dart';
import '../../../core/models/match_data.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final match = MatchData(
      player1Name: "mustafa",
      player2Name: "omar",
      player1Score: 5,
      player2Score: 1,
      matchDate: DateTime.now(),
      player1AvatarUrl: null,
      player2AvatarUrl: null,
    );

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: 'History'),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => HistoryCard(match: match),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
