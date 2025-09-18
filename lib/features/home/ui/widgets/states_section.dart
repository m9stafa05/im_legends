import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'states_column.dart';
import '../../../../core/utils/spacing.dart';

class StatesSection extends StatelessWidget {
  const StatesSection({super.key, required this.Match, required this.goals});
  final int Match;
  final int goals;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.black.withAlpha((0.2 * 255).toInt()),
      ),
      child: Row(
        children: [
          StatesColumn(
            label: 'Matches',
            value: Match,
            icon: Icons.sports_esports,
          ),
          horizontalSpacing(16),
          StatesColumn(label: 'Goals', value: goals, icon: Icons.sports_soccer),
        ],
      ),
    );
  }
}
