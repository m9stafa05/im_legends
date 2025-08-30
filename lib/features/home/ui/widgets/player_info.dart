import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/spacing.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({super.key, required this.playerName, required this.points});

  final String playerName ;
  final int points ;
  final bool isCurrentUser = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          playerName,
          style: AppTextStyles.text16WhiteBold.copyWith(
            color: isCurrentUser ? const Color(0xFF4A90E2) : Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        verticalSpacing(4),
        Row(
          children: [
            Icon(
              Icons.star_rounded,
              size: 14.sp,
              color: const Color(0xFFFFB800),
            ),
            horizontalSpacing(4),
            Text(
              '$points Points',
              style: AppTextStyles.text12GreyRegular.copyWith(
                color: const Color(0xFFFFB800),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
