import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../logic/cubit/profile_cubit.dart';
import 'states_grid_view.dart';
import 'user_card_info.dart';

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
              rank: 1,
              name: playerProfile.name,
              imageUrl: playerProfile.profileImageUrl,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.white, size: 24.sp),
                onPressed: () {},
              ),
            ),
          ],
        ),
        verticalSpacing(16),

        // User Info
        UserInfoCard(
          age: playerProfile.age,
          email: playerProfile.email,
          phoneNumber: playerProfile.phoneNumber,
          isOwnProfile: true,
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
              'label': 'Goals',
              'value': playerStats.goals,
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
