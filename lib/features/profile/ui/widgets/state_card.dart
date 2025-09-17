import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/themes/app_colors.dart';

class StateCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StateCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey.shade900, AppColors.lightDarkColor],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.blue.shade700.withAlpha((0.2* 255).toInt()),
          width: 1.5.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.2* 255).toInt()),
            blurRadius: 6.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Icon(icon, size: 24.sp, color: Colors.blue.shade300),
          SizedBox(height: 8.h),
          // Value
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          // Label
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade300,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
