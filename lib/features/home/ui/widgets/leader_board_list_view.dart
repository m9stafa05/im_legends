import 'package:flutter/material.dart';
import 'leader_board_card.dart';

class LeadBoardListView extends StatelessWidget {
  const LeadBoardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) => const LeaderBoardCard(
        playerName: 'Mustafa Elbaz',
        points: 150,
        wins: 20,
        goals: 55,
        rank: 3,
        isCurrentUser: true,
      ),
    );
  }
}
