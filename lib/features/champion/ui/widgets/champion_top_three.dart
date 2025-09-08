import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'champions_card.dart';

class ChampionTopThree extends StatelessWidget {
  final List<Map<String, dynamic>> topChampions = const [
    {'name': 'Mustafa Elbaz', 'imageUrl': null, 'rank': 1},
    {'name': 'Alex Johnson', 'imageUrl': null, 'rank': 2},
    {'name': 'Sarah Lee', 'imageUrl': null, 'rank': 3},
  ];

  const ChampionTopThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.blue.shade900.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.w),
      ),
      child: Column(
        children: [
          Text(
            'Top 3 Champions',
            style: AppTextStyles.text20WhiteBold.copyWith(
              shadows: const [Shadow(color: Color(0xFFFBC02D), blurRadius: 4)],
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Second place (left)
              Flexible(child: ChampionsCard(champion: topChampions[1])),
              // First place (center, elevated)
              Flexible(
                child: Transform.translate(
                  offset: Offset(0, -20.h),
                  child: ChampionsCard(champion: topChampions[0]),
                ),
              ),
              // Third place (right)
              Flexible(child: ChampionsCard(champion: topChampions[2])),
            ],
          ),
        ],
      ),
    );
  }
}
