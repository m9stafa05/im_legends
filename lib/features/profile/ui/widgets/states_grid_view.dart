import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'state_card.dart';

class StatsGridView extends StatelessWidget {
  final List<Map<String, dynamic>> stats;

  const StatsGridView({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 1.5,
      children: stats.map((stat) {
        return StateCard(
          label: stat['label'] as String,
          value: stat['value'],
          icon: stat['icon'] as IconData,
        );
      }).toList(),
    );
  }
}
