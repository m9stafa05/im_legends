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
  });
  final String title;
  final Color backgroundColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 250.w,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20.r),
          color: backgroundColor,
        ),
        child: Text(title, style: AppTextsStyle.font14WhiteBold),
      ),
    );
  }
}
