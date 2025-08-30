import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerFieldDropdownArrow extends StatelessWidget {
  final Animation<double> rotationAnimation;
  final bool isSelected;

  const PlayerFieldDropdownArrow({
    super.key,
    required this.rotationAnimation,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rotationAnimation,
      builder: (context, child) => Transform.rotate(
        angle: rotationAnimation.value * 3.14159,
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: isSelected
              ? const Color(0xFF4A90E2)
              : Colors.white.withAlpha((0.7 * 255).toInt()),
          size: 28.sp,
        ),
      ),
    );
  }
}
