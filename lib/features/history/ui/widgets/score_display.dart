import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/match_history_card_model.dart';

class ScoreDisplay extends StatelessWidget {
  final MatchHistoryCardModel match;
  final Color winColor;
  final Color loseColor;

  const ScoreDisplay({
    super.key,
    required this.match,
    required this.winColor,
    required this.loseColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${match.winnerScore}',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: winColor,
            shadows: [
              Shadow(color: winColor.withOpacity(0.5), blurRadius: 4.r),
            ],
          ),
        ),
        Text(
          ' - ',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '${match.loserScore}',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: loseColor,
            shadows: [
              Shadow(color: loseColor.withOpacity(0.5), blurRadius: 4.r),
            ],
          ),
        ),
      ],
    );
  }
}
