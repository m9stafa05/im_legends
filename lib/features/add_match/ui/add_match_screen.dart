import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'widgets/add_match_button.dart';
import 'widgets/player_select_field/player_select_field.dart';
import 'widgets/score_input_field/score_count_field.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/gradient_background.dart';

class AddMatchScreen extends StatefulWidget {
  const AddMatchScreen({super.key});

  @override
  State<AddMatchScreen> createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  int winnerScore = 0;
  int loserScore = 0;
  String? winnerPlayer;
  String? loserPlayer;

  void _onWinnerScoreChanged(int score) {
    setState(() {
      winnerScore = score;
      if (loserScore > winnerScore) {
        loserScore = winnerScore;
      }
    });
  }

  void _onLoserScoreChanged(int score) {
    setState(() {
      loserScore = score;
    });
  }

  void _onWinnerPlayerChanged(String player) {
    setState(() {
      winnerPlayer = player;
    });
  }

  void _onLoserPlayerChanged(String player) {
    setState(() {
      loserPlayer = player;
    });
  }

  bool get _isAddButtonEnabled =>
      winnerScore > loserScore &&
      winnerPlayer != null &&
      loserPlayer != null &&
      winnerPlayer != loserPlayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: 'Add Match'),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: GradientBackground(
                child: Column(
                  children: [
                    verticalSpacing(20),
                    PlayerSelectField(
                      hint: 'Select Winner',
                      players: ['Mustafa', 'Sayed', 'Ahmed', 'Hassan', 'Ali'],
                      onSelected: _onWinnerPlayerChanged,
                      excludedPlayer: loserPlayer,
                    ),
                    verticalSpacing(5),
                    ScoreCountField(
                      accentColor: Colors.green,
                      initialScore: winnerScore,
                      onScoreChanged: _onWinnerScoreChanged,
                    ),
                    verticalSpacing(50),
                    PlayerSelectField(
                      hint: 'Select Loser',
                      players: ['Mustafa', 'Sayed', 'Ahmed', 'Hassan', 'Ali'],
                      onSelected: _onLoserPlayerChanged,
                      excludedPlayer: winnerPlayer,
                    ),
                    verticalSpacing(5),
                    ScoreCountField(
                      accentColor: Colors.red,
                      initialScore: loserScore,
                      onScoreChanged: _onLoserScoreChanged,
                      maxScore: winnerScore,
                    ),
                    verticalSpacing(50),
                    AddMatchButton(
                      onPressed: _isAddButtonEnabled
                          ? () {
                              context.go(Routes.homeScreen);
                            }
                          : null,
                      isEnabled: _isAddButtonEnabled,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
