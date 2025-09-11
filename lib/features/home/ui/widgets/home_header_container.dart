import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/app_assets.dart';

class HomeHeaderContainer extends StatelessWidget {
  final String? userName;
  final String? greeting;
  final VoidCallback? onCreateMatch;

  const HomeHeaderContainer({
    super.key,
    this.userName,
    this.greeting,
    this.onCreateMatch,
  });

  String _getGreeting() {
    if (greeting != null) return greeting!;
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E2128), Color(0xFF2A2D36)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha((0.1 * 255).toInt()),
                border: Border.all(
                  color: Colors.white.withAlpha((0.2 * 255).toInt()),
                  width: 1,
                ),
              ),
              child: SvgPicture.asset(
                AppAssets.appLogo,
                height: 150.h,
                width: 150.w,
              ),
            ),

            verticalSpacing(20),

            // User Info Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _getGreeting(),
                  style: AppTextStyles.textBorel20GreyRegular,
                ),
                verticalSpacing(4),
                Text(
                  userName ?? 'Player',
                  style: AppTextStyles.textBebas20WhiteBold,
                ),
                verticalSpacing(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sports_soccer_rounded,
                      color: const Color(0xFF4A90E2),
                      size: 16.sp,
                    ),
                    horizontalSpacing(4),
                    Text(
                      'Ready to play?',
                      style: AppTextStyles.textFederant20GreyBold.copyWith(
                        color: const Color(0xFF4A90E2),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                verticalSpacing(10),

                // Add Match Button
                SizedBox(
                  width: 200.w,
                  child: CustomTextButton(
                    buttonText: 'Add Match',
                    onPressed: onCreateMatch,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
