import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/themes/app_texts_style.dart';

class PlayerTile extends StatelessWidget {
  final String player;
  final bool isSelected;
  final int index;
  final void Function(String) onSelect;

  const PlayerTile({
    super.key,
    required this.player,
    required this.isSelected,
    required this.index,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: isSelected
            ? const LinearGradient(
                colors: [Color(0xFF2A4A6B), Color(0xFF1E3A5F)],
              )
            : null,
        color: isSelected ? null : Colors.white.withAlpha((0.03 * 255).toInt()),
        border: isSelected
            ? Border.all(color: const Color(0xFF4A90E2), width: 2)
            : Border.all(
                color: Colors.white.withAlpha((0.08 * 255).toInt()),
                width: 1,
              ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () => onSelect(player),
        child: Row(
          children: [
            _buildAvatar(),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                player,
                style: BebasTextStyles.whiteBold20.copyWith(
                  fontSize: 16.sp,
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withAlpha((0.95 * 255).toInt()),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: Colors.blue, size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.primaries[index % Colors.primaries.length].withAlpha(
              (0.9 * 255).toInt(),
            ),
            Colors.primaries[(index + 1) % Colors.primaries.length].withAlpha(
              (0.7 * 255).toInt(),
            ),
          ],
        ),
      ),
      child: Center(
        child: Text(
          player.isNotEmpty ? player[0].toUpperCase() : 'P',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
