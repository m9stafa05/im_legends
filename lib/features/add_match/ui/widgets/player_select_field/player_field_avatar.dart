import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerFieldAvatar extends StatelessWidget {
  final bool isSelected;
  final String? imageUrl;

  const PlayerFieldAvatar({super.key, required this.isSelected, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: !isSelected || imageUrl == null
            ? LinearGradient(
                colors: [
                  Colors.grey.withAlpha((0.4 * 255).toInt()),
                  Colors.grey.withAlpha((0.2 * 255).toInt()),
                ],
              )
            : null,
      ),
      child: ClipOval(
        child: isSelected && imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.person, color: Colors.white, size: 20.sp),
              )
            : Icon(
                isSelected ? Icons.person : Icons.person_outline,
                color: Colors.white,
                size: 20.sp,
              ),
      ),
    );
  }
}
