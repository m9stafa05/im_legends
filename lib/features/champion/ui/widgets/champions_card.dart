import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/utils/app_assets.dart';

class ChampionsCard extends StatelessWidget {
  final Map<String, dynamic> champion;
  late final int rank;
  late final bool isFirst;
  late final bool isSecond;

  ChampionsCard({super.key, required this.champion}) {
    rank = champion['rank'] as int;
    isFirst = rank == 1;
    isSecond = rank == 2;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(
                    0xFFFDD835,
                  ).withOpacity(isFirst ? 0.8 : 0.6),
                  width: isFirst ? 4.w : 3.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFFFBC02D,
                    ).withOpacity(isFirst ? 0.5 : 0.3),
                    blurRadius: isFirst ? 10.r : 6.r,
                    spreadRadius: isFirst ? 3.r : 2.r,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: isFirst ? 50.r : 40.r,
                backgroundColor: const Color(0xFFFDD835),
                child: CircleAvatar(
                  radius: isFirst ? 46.r : 36.r,
                  backgroundImage: champion['imageUrl'] != null
                      ? NetworkImage(champion['imageUrl'] as String)
                      : const AssetImage(AppAssets.appLogoPng) as ImageProvider,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(isFirst ? 6.w : 4.w),
              decoration: BoxDecoration(
                color: isFirst
                    ? const Color(0xFFFDD835)
                    : isSecond
                    ? Colors.grey.shade400
                    : const Color(0xFFCD7F32), // Bronze for third
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.w,
                ),
              ),
              child: Text(
                '#$rank',
                style: TextStyle(
                  fontSize: isFirst ? 16.sp : 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              isFirst
                  ? const Color(0xFFFDD835)
                  : isSecond
                  ? Colors.grey.shade400
                  : const Color(0xFFCD7F32),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            champion['name'] as String,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isFirst ? 18.sp : 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: const [Shadow(color: Color(0xFFFBC02D), blurRadius: 3)],
            ),
          ),
        ),
      ],
    );
  }
}
