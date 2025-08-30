import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_texts_style.dart';

class PlayerFieldInfo extends StatelessWidget {
  final String? selectedPlayer;
  final String hint;

  const PlayerFieldInfo({super.key, this.selectedPlayer, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: AppTextStyles.text18WhiteBold.copyWith(
              color: selectedPlayer == null ? Colors.white54 : Colors.white,
              fontSize: selectedPlayer != null ? 20.sp : 16.sp,
              fontWeight: selectedPlayer != null
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
            child: Text(
              selectedPlayer ?? hint,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (selectedPlayer != null) SizedBox(height: 4.h),
          if (selectedPlayer != null)
            Text(
              'Player Selected',
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
