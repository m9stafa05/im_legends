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
  final bool isLoading;
  final Widget? child;

  const AddMatchButton({
    super.key,
    this.onPressed,
    this.isEnabled = true,
    this.text = 'Add Match',
    this.icon = Icons.add,
    this.width,
    this.isLoading = false,
    this.child,
  });

  @override
  State<AddMatchButton> createState() => _AddMatchButtonState();
}

class _AddMatchButtonState extends State<AddMatchButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.isEnabled && !widget.isLoading) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.isEnabled && !widget.isLoading) {
      setState(() => _isPressed = false);
      widget.onPressed?.call();
    }
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = !widget.isEnabled || widget.isLoading;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
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
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    height: 22.sp,
                    width: 22.sp,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : widget.child ??
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.text,
                            style: BebasTextStyles.whiteBold20.copyWith(
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
      ),
    );
  }
}
