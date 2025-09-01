import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'widgets/add_match_button.dart';
import 'widgets/player_select_field/player_select_field.dart';
import 'widgets/score_input_field/score_count_field.dart';
import '../../../core/utils/spacing.dart';

class AddMatchScreen extends StatelessWidget {
  const AddMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: 'Add Match'),
          verticalSpacing(20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const PlayerSelectField(
                    hint: 'Select Winner',
                    players: ['Mustafa', 'Sayed', 'Ahmed', 'Hassan', 'Ali'],
                  ),
                  verticalSpacing(5),
                  const ScoreCountField(accentColor: Colors.green),
                  verticalSpacing(50),
                  const PlayerSelectField(
                    hint: 'Select Loser',
                    players: ['Mustafa', 'Sayed', 'Ahmed', 'Hassan', 'Ali'],
                  ),
                  verticalSpacing(5),
                  const ScoreCountField(accentColor: Colors.red),
                  verticalSpacing(50),
                  AddMatchButton(
                    onPressed: () {
                      context.go(Routes.homeScreen);
                    },
                    isEnabled: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
