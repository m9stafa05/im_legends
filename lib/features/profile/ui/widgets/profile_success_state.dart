import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../logic/cubit/profile_cubit.dart';
import 'states_grid_view.dart';

import '../../../../core/models/players_states_model.dart';
import '../../../../core/models/user_data.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/custom_text_button.dart';
import 'profile_header.dart';

class profileSuccessState extends StatelessWidget {
  const profileSuccessState({
    super.key,
    required this.playerProfile,
    required this.playerStats,
  });

  final UserData playerProfile;
  final PlayerStatsModel playerStats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            ProfileHeader(
              rank: playerStats.rank ?? 0,
              name: playerProfile.name,
              imageUrl: playerProfile.profileImageUrl,
            ),
          ],
        ),
        verticalSpacing(16),

        // Stats Grid
        StatsGridView(
          stats: [
            {
              'label': 'Points',
              'value': playerStats.points,
              'icon': Icons.star,
            },
            {
              'label': 'Matches',
              'value': playerStats.matchesPlayed,
              'icon': Icons.sports_esports,
            },
            {
              'label': 'Wins',
              'value': playerStats.wins,
              'icon': Icons.emoji_events,
            },
            {
              'label': 'Goals Scored',
              'value': playerStats.goalsScored,
              'icon': Icons.sports_soccer,
            },
            {
              'label': 'Goals received',
              'value': playerStats.goalsReceived,
              'icon': Icons.sports_soccer,
            },
            {
              'label': 'Goal Difference',
              'value': playerStats.goalDifference,
              'icon': Icons.sports_soccer,
            },
          ],
        ),
        verticalSpacing(16),

        // Logout Button
        SizedBox(
          width: 200.w,
          child: CustomTextButton(
            buttonText: 'Logout',
            onPressed: () {
              context.read<ProfileCubit>().logout();
            },
            backgroundColor: Colors.red,
          ),
        ),
        verticalSpacing(32),
      ],
    );
  }
}
