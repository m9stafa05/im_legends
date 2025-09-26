import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'champion_state_item.dart';

class ChampionStats extends StatelessWidget {
  final int goals;
  final int points;
  final int wins;
  final int matches;

  const ChampionStats({
    super.key,
    required this.goals,
    required this.points,
    required this.wins,
    required this.matches,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withAlpha((0.3 * 255).toInt()),
            Colors.black.withAlpha((0.9 * 255).toInt()),
            const Color(0xFF020D8C).withAlpha((0.9 * 255).toInt()),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.3 * 255).toInt()),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
        border: Border.all(
          color: Colors.white.withAlpha((0.3 * 255).toInt()),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ChampionStateItem(
            label: 'Matches',
            value: matches,
            icon: Icons.sports_esports,
          ),
          ChampionStateItem(
            label: 'Wins',
            value: wins,
            icon: Icons.emoji_events,
          ),
          ChampionStateItem(label: 'Points', value: points, icon: Icons.star),
          ChampionStateItem(
            label: 'Goals',
            value: goals,
            icon: Icons.sports_soccer,
          ),
        ],
      ),
    );
  }
}
