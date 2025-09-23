import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_colors.dart';
import '../../data/models/match_history_card_model.dart';
import 'history_card_player_info.dart';
import 'match_card_header.dart';
import 'score_display.dart';

class HistoryListCard extends StatelessWidget {
  final MatchHistoryCardModel match;

  const HistoryListCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color winColor = Colors.green.shade400;
    final Color loseColor = const Color(0xFF7D3130);

    List<Color> cardGradient = [
      const Color(0xFF120D0E),
      AppColors.lightDarkColor,
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
            color: Colors.black.withAlpha((0.5 * 255).toInt()),
            blurRadius: 12.r,
            offset: Offset(0, 6.h),
          ),
        ],
        border: Border.all(color: Colors.white.withAlpha((0.5 * 255).toInt())),
      ),
      child: Column(
        children: [
          MatchCardHeader(
            matchDate: match.matchDate,
            primaryColor: theme.colorScheme.primary,
          ),
          SizedBox(height: 12.h),

          // Main Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HistoryCardPlayerInfo(
                playerName: match.winnerName,
                avatarUrl: match.winnerImage,
                isWinner: true,
                winColor: winColor,
                loseColor: loseColor,
                isLeftSide: true,
              ),
              ScoreDisplay(
                match: match,
                winColor: winColor,
                loseColor: loseColor,
              ),
              HistoryCardPlayerInfo(
                playerName: match.loserName,
                avatarUrl: match.loserImage,
                isWinner: false,
                winColor: winColor,
                loseColor: loseColor,
                isLeftSide: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
