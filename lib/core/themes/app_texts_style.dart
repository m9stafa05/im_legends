import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_colors.dart';
import 'package:im_legends/core/themes/app_font_weight.dart';
import 'package:im_legends/core/utils/app_assets.dart';

class AppTextStyles {
  // ========== FONT SIZE 20 ==========
  static const text20WhiteBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontFederant,
    color: Colors.white,
  );

  static const text20GreyBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontFederant,
    color: Colors.grey,
  );

  // ========== FONT SIZE 18 ==========
  static const text18RedBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontBorel,
    color: AppColors.darkRedColor,
  );

  static const text18WhiteBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontBorel,
    color: Colors.white,
  );

  static const text18GreyRegular = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.regular,
    fontFamily: AppAssets.fontBorel,
    color: Colors.grey,
  );

  // ========== FONT SIZE 16 ==========
  static const text16WhiteBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontFederant,
    color: Colors.white,
    letterSpacing: .2,
  );

  static const text16WhiteSemiBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.semiBold,
    fontFamily: AppAssets.fontFederant,
    color: Colors.white,
  );

  static const text16GreyRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.regular,
    fontFamily: AppAssets.fontFederant,
    color: Colors.grey,
  );

  // ========== FONT SIZE 14 ==========
  static const text14WhiteBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontBebasNeue,
    color: Colors.white,
  );

  static const text14GreyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontBebasNeue,
    color: Colors.grey,
  );

  static const text14GreyRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightHelper.regular,
    fontFamily: AppAssets.fontBebasNeue,
    color: Colors.grey,
  );

  // ========== FONT SIZE 12 ==========
  static const text12WhiteBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontBebasNeue,
    color: Colors.white,
  );

  static const text12GreyRegular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightHelper.regular,
    fontFamily: AppAssets.fontFederant,
    color: Colors.grey,
  );

  static const text12ErrorRed = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontFederant,
    color: AppColors.darkRedColor,
  );
}
