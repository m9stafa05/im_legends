import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themes/app_texts_style.dart';
import '../themes/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.isObscureText = false,
    this.suffixIcon,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.innerBackgroundColor, this.formKey,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isObscureText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final Color? innerBackgroundColor;
  final formKey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      cursorColor: AppColors.darkRedColor,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isObscureText,
      style: inputTextStyle ?? FederantTextStyles.whiteBold18,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.darkRedColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.greyColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(12.r),
        ),
        hintText: hintText,
        hintStyle: hintStyle ?? FederantTextStyles.greyRegular16,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor:
            innerBackgroundColor ??
            AppColors.darkColor.withAlpha((0.9 * 255).toInt()),
      ),
    );
  }
}
