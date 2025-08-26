import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/spacing.dart';

class OnBoardingCustomCard extends StatelessWidget {
  const OnBoardingCustomCard({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;
  static const Color _cardColor = Color(0xFF262A33);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      width: 200.w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: _cardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.text16WhiteBold.copyWith(letterSpacing: -1),
            textAlign: TextAlign.center,
          ),
          verticalSpacing(5),
          Text(
            subTitle,
            style: AppTextStyles.text12GreyRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
