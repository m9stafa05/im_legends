import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/app_colors.dart';

class PlayerFieldAvatar extends StatelessWidget {
  final bool isSelected;

  const PlayerFieldAvatar({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isSelected
            ? const LinearGradient(
                colors: [AppColors.darkRedColor, Color(0xFF357ABD)],
              )
            : LinearGradient(
                colors: [
                  Colors.grey.withAlpha((0.4 * 255).toInt()),
                  Colors.grey.withAlpha((0.2 * 255).toInt()),
                ],
              ),
      ),
      child: Icon(
        isSelected ? Icons.person : Icons.person_outline,
        color: Colors.white,
        size: 20.sp,
      ),
    );
  }
}
