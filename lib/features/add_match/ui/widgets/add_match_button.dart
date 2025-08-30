import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/spacing.dart';

class AddMatchButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isEnabled;
  final String text;
  final IconData icon;
  final double? width;

  const AddMatchButton({
    super.key,
    this.onPressed,
    this.isEnabled = true,
    this.text = 'Add Match',
    this.icon = Icons.add,
    this.width,
  });

  @override
  State<AddMatchButton> createState() => _AddMatchButtonState();
}

class _AddMatchButtonState extends State<AddMatchButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.isEnabled) {
      setState(() => _isPressed = true);
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _resetPressedState();
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    _resetPressedState();
  }

  void _resetPressedState() {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = !widget.isEnabled;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: Container(
              width: widget.width ?? 250.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: isDisabled
                    ? AppColors.darkRedColor.withAlpha((0.15 * 255).toInt())
                    : AppColors.darkRedColor,
                boxShadow: isDisabled
                    ? null
                    : [
                        BoxShadow(
                          color: AppColors.darkRedColor.withAlpha(
                            (0.15 * 255).toInt(),
                          ),
                          blurRadius: 8.r,
                          offset: Offset(0, 4.h),
                        ),
                        if (_isPressed)
                          BoxShadow(
                            color: AppColors.darkRedColor.withAlpha(
                              (0.5 * 255).toInt(),
                            ),
                            blurRadius: 4.r,
                            offset: Offset(0, 2.h),
                          ),
                      ],
                border: Border.all(
                  color: Colors.white.withAlpha((0.15 * 255).toInt()),
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.text,
                    style: AppTextStyles.text16WhiteBold.copyWith(
                      color: isDisabled ? Colors.white70 : Colors.white,
                    ),
                  ),
                  horizontalSpacing(6),
                  Icon(
                    widget.icon,
                    color: isDisabled ? Colors.white70 : Colors.white,
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
