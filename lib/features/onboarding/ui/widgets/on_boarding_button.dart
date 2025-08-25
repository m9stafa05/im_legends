import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_texts_style.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({
    super.key,
    required this.title,
    this.backgroundColor = AppColors.darkColor,
    this.onTap,
    this.icon,
  });

  final String title;

  final Color backgroundColor;

  final VoidCallback? onTap;

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onTap == null;

    return Material(
      color: isDisabled
          ? backgroundColor.withValues(alpha: 0)
          : backgroundColor,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          width: 250.w,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(title, style: AppTextStyles.text14WhiteBold)],
          ),
        ),
      ),
    );
  }
}
