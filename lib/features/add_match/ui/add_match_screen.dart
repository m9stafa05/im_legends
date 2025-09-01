import 'package:flutter/material.dart';
import 'package:im_legends/core/router/routes.dart';
import 'package:im_legends/core/utils/extensions.dart';
import 'package:im_legends/core/widgets/custom_app_bar.dart';
import 'package:im_legends/features/add_match/ui/widgets/add_match_button.dart';
import 'package:im_legends/features/add_match/ui/widgets/player_select_field/player_select_field.dart';
import 'package:im_legends/features/add_match/ui/widgets/score_input_field/score_count_field.dart';

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
                      context.pushReplacementNamed(Routes.homeScreen);
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
