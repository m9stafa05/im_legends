import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_colors.dart';
import 'player_info.dart';
import 'rank_and_avatar.dart';
import 'states_section.dart';
import '../../../../core/utils/spacing.dart';

class LeaderBoardCard extends StatelessWidget {
  final String playerName;
  final int points;
  final int wins;
  final int goals;
  final String? avatarAsset;
  final int? rank;
  final bool isCurrentUser;

  const LeaderBoardCard({
    super.key,
    required this.playerName,
    required this.points,
    required this.wins,
    required this.goals,
    this.avatarAsset,
    this.rank,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        height: 88.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isCurrentUser
              ? AppColors.lightDarkColor
              : const Color(0xFF1E2128),
          border: isCurrentUser
              ? Border.all(color: const Color(0xFF4A90E2), width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.2 * 255).toInt()),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Rank and Avatar Section
            RankAndAvatar(
              isCurrentUser: isCurrentUser,
              rank: rank,
              avatarAsset: avatarAsset,
            ),
            horizontalSpacing(12),

            // Player Info Section
            Expanded(
              flex: 2,
              child: PlayerInfo(playerName: playerName, points: points),
            ),

            // Stats Section
            StatesSection(wins: wins, goals: goals),
          ],
        ),
      ),
    );
  }
}
