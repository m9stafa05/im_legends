import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/themes/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final int rank;

  const ProfileHeader({super.key, required this.rank});

  Color _getRankColor() {
    switch (rank) {
      case 1:
        return Colors.amber.shade600; // Gold for Rank 1
      case 2:
        return const Color(0xFFC0C0C0); // Silver for Rank 2
      case 3:
        return Colors.orange.shade900; // Bronze for Rank 3
      default:
        return Colors.grey.shade800; // Normal color for other ranks
    }
  }

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
            color: Colors.black.withOpacity(0.3),
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
              color: _getRankColor(),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.w,
              ),
              boxShadow: rank <= 3
                  ? [
                      BoxShadow(
                        color: _getRankColor().withOpacity(0.5),
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
          SizedBox(height: 30.h),
          // Favorite Team Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Colors.grey.shade300.withOpacity(0.5),
                width: 1.w,
              ),
            ),
            child: Text(
              'Favorite Team: Liverpool',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
