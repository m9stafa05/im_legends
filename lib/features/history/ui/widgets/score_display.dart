import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/models/match_data.dart';

class ScoreDisplay extends StatelessWidget {
  final MatchData match;
  final Color winColor;
  final Color loseColor;
  final Color tieColor;

  const ScoreDisplay({
    super.key,
    required this.match,
    required this.winColor,
    required this.loseColor,
    required this.tieColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: match.isTie ? tieColor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: match.isTie ? tieColor.withOpacity(0.3) : Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Text(
            '${match.player1Score}',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
              color: match.player1Won
                  ? winColor
                  : (match.player2Won ? loseColor : Colors.white),
              shadows: [
                if (match.player1Won || match.player2Won)
                  Shadow(
                    color: (match.player1Won ? winColor : loseColor)
                        .withOpacity(0.5),
                    blurRadius: 4.r,
                  ),
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
            '${match.player2Score}',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
              color: match.player2Won
                  ? winColor
                  : (match.player1Won ? loseColor : Colors.white),
              shadows: [
                if (match.player1Won || match.player2Won)
                  Shadow(
                    color: (match.player2Won ? winColor : loseColor)
                        .withOpacity(0.5),
                    blurRadius: 4.r,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
