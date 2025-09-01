import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../themes/app_texts_style.dart';
import '../utils/app_assets.dart';

class LogoTopBar extends StatelessWidget {
  const LogoTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppAssets.appLogo, height: 100.h, width: 100.w),
        const Text('IM Legends', style: AppTextStyles.text18RedBold),
      ],
    );
  }
}
