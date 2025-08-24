import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_colors.dart';
import 'package:im_legends/core/themes/app_font_weight.dart';
import 'package:im_legends/core/utils/app_assets.dart';

class AppTextsStyle {
  // font 20
  static const font20WhiteBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontFederantRegular,
    color: Colors.white,
  );
  static const font16WhiteBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontFederantRegular,
    color: Colors.white,
    letterSpacing: .2,
  );

  static const font18RedBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontBorelRegular,
    color: AppColors.darkRedColor,
  );
  static const font18WhiteBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontBorelRegular,
    color: Colors.white,
  );
  static const font12WhiteBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontBebasNeueRegular,
    color: Colors.white,
  );
  static const font14WhiteBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontBebasNeueRegular,
    color: Colors.white,
  );

  static const font14GreyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightHelper.bold,
    fontFamily: AppAssets.fontBebasNeueRegular,
    color: Colors.grey,
  );
  static const font12GreyRegular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightHelper.regular,
    fontFamily: AppAssets.fontFederantRegular,
    color: Colors.grey,
  );
}
