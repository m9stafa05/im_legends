import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isEnabled;
  final Color accentColor;

  const ScoreControlButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isEnabled,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          gradient: isEnabled
              ? LinearGradient(
                  colors: [
                    accentColor.withAlpha((0.3 * 255).toInt()),
                    accentColor.withAlpha((0.2 * 255).toInt()),
                  ],
                )
              : LinearGradient(
                  colors: [
                    Colors.grey.withAlpha((0.2 * 255).toInt()),
                    Colors.grey.withAlpha((0.1 * 255).toInt()),
                  ],
                ),
          border: Border.all(
            color: isEnabled
                ? accentColor.withAlpha((0.4 * 255).toInt())
                : Colors.grey.withAlpha((0.3 * 255).toInt()),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: isEnabled
              ? Colors.white
              : Colors.white.withAlpha((0.4 * 255).toInt()),
          size: 16.sp,
        ),
      ),
    );
  }
}
