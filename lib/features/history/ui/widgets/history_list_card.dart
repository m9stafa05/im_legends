import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/themes/app_colors.dart';
import 'package:im_legends/features/history/ui/widgets/history_card_player_info.dart';
import 'package:im_legends/features/history/ui/widgets/match_card_header.dart';
import 'package:im_legends/features/history/ui/widgets/score_display.dart';
import 'package:im_legends/features/history/ui/widgets/tie_message.dart';

import '../../../../core/models/match_data.dart';

// Main History Card Widget using MatchData model
class HistoryCard extends StatelessWidget {
  final MatchData match;

  const HistoryCard({super.key, required this.match});

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Dark mode friendly outcome highlight colors
    final Color winColor = Colors.green.shade400; // bright but calm green
    final Color loseColor = const Color(0xFF7D3130); // muted neutral grey
    final Color tieColor = Colors.amber.shade300; // pastel amber

    List<Color> cardGradient = [
      AppColors.lightDarkColor,
      const Color.fromARGB(255, 18, 13, 14),
    ];

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: cardGradient,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 12.r,
            offset: Offset(0, 6.h),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
      ),
      child: Column(
        children: [
          MatchCardHeader(
            matchDate: match.matchDate,
            primaryColor: theme.colorScheme.primary,
          ),
          SizedBox(height: 12.h),

          // Main Row for players and score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HistoryCardPlayerInfo(
                playerName: match.player1Name,
                avatarUrl: match.player1AvatarUrl,
                isWinner: match.player1Won,
                winColor: winColor,
                loseColor: loseColor,
                isLeftSide: true,
              ),
              ScoreDisplay(
                match: match,
                winColor: winColor,
                loseColor: loseColor,
                tieColor: tieColor,
              ),
              HistoryCardPlayerInfo(
                playerName: match.player2Name,
                avatarUrl: match.player2AvatarUrl,
                isWinner: match.player2Won,
                winColor: winColor,
                loseColor: loseColor,
                isLeftSide: false,
              ),
            ],
          ),

          if (match.isTie) TieMessage(tieColor: tieColor),
        ],
      ),
    );
  }
}
