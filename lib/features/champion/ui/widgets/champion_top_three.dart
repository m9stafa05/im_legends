import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/spacing.dart';
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
            Colors.black.withAlpha((0.3 * 255).toInt()),
            Colors.black.withAlpha((0.9 * 255).toInt()),
            const Color(0xFF020D8C).withAlpha((0.9 * 255).toInt()),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),

        border: Border.all(
          color: Colors.white.withAlpha((0.2 * 255).toInt()),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Top 3 Champions',
            style: AppTextStyles.textBebas24WhiteBold,
          ),
          verticalSpacing(24),
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
