import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RankAndAvatar extends StatelessWidget {
  const RankAndAvatar({
    super.key,
    this.avatarAsset,
    this.rank,
    required this.isCurrentUser,
  });
  final String? avatarAsset;
  final int? rank;
  final bool isCurrentUser;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: Stack(
        children: [
          // Avatar
          Center(
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCurrentUser
                      ? const Color(0xFF4A90E2)
                      : Colors.grey.withAlpha((0.2 * 255).toInt()),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.2 * 255).toInt()),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 24.r,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    avatarAsset ?? 'assets/images/AppLogo.png',
                    fit: BoxFit.cover,
                    width: 44.w,
                    height: 44.w,
                  ),
                ),
              ),
            ),
          ),

          // Rank Badge
          if (rank != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getRankColor(),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    '$rank',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getRankColor() {
    if (rank == null) return const Color(0xFF6366F1);

    switch (rank!) {
      case 1:
        return const Color(0xFFF59E0B); // Rich Gold
      case 2:
        return const Color(0xFF9CA3AF); // Modern Silver
      case 3:
        return const Color(0xFFEA580C); // Vibrant Bronze/Copper
      default:
        return const Color(0xFF6366F1); // Modern Purple
    }
  }
}
