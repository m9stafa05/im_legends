import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/themes/app_colors.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/functions/get_rank_color.dart';
import 'package:im_legends/core/utils/spacing.dart';

class ProfileHeader extends StatelessWidget {
  final int rank;

  const ProfileHeader({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h, // Reduced height for compact layout
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.lightDarkColor, Color.fromARGB(255, 18, 13, 14)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.4 * 255).toInt()),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 50.r,
            backgroundColor: Colors.grey.shade700,
            child: CircleAvatar(
              radius: 46.r,
              backgroundImage: const AssetImage('assets/images/ImLogo.png'),
            ),
          ),
          SizedBox(height: 10.h),
          // Username
          Text(
            'Mustafa',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 12.h),
          // Rank Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: getRankColor(rank),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Colors.white.withAlpha((0.3 * 255).toInt()),
                width: 1.w,
              ),
              boxShadow: rank <= 3
                  ? [
                      BoxShadow(
                        color: getRankColor(rank),
                        blurRadius: 6.r,
                        offset: Offset(0, 2.h),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.emoji_events, size: 16.sp, color: Colors.white),
                SizedBox(width: 8.w),
                Text(
                  'Rank: #$rank',
                  style: TextStyle(
                    fontSize: 16.sp, // Slightly larger for emphasis
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          verticalSpacing(32),
          // Favorite Team Badge
          Text('Favorite Team', style: TajawalTextStyles.greyRegular16),
          verticalSpacing(2),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha((0.1 * 255).toInt()),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Manchester City',
              style: TajawalTextStyles.whiteBold20,
            ),
          ),
        ],
      ),
    );
  }
}
