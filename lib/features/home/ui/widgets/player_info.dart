import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/themes/app_colors.dart';

import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/spacing.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({super.key, required this.playerName, required this.points});

  final String playerName;
  final int points;
  final bool isCurrentUser = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          playerName,
          style: AppTextStyles.textBebas20WhiteBold,
          overflow: TextOverflow.ellipsis,
        ),
        verticalSpacing(2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.star, size: 14.sp, color: AppColors.goldColor),
            horizontalSpacing(4),
            Text('$points Points', style: AppTextStyles.textBebas14GreyBold),
          ],
        ),
      ],
    );
  }
}
