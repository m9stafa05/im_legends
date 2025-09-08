import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/app_assets.dart';

class ChampionHeader extends StatelessWidget {
  final String name;
  final String? imageUrl;

  const ChampionHeader({super.key, required this.name, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260.h,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(AppAssets.championBanner),
          fit: BoxFit.cover,
          opacity: 0.9,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.2),
            Colors.blue.shade900.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Champion Image with Trophy Overlay
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFEDC81F).withOpacity(0.7),
                    width: 3.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEDC81F).withOpacity(0.4),
                      blurRadius: 8.r,
                      spreadRadius: 2.r,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 50.r,
                  // backgroundColor: const Color(0xFFFDD835), // Gold
                  child: CircleAvatar(
                    radius: 100.r,
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl!)
                        : const AssetImage(AppAssets.appLogoPng)
                              as ImageProvider,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: const BoxDecoration(
                  color: Color(0xFFEDC81F), // Gold
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.emoji_events,
                  size: 18.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Champion Name with Gradient
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFFDD835), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: const [
                  Shadow(
                    color: Color(0xFFFBC02D), // Lighter gold for glow
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10.h),
          // Champion Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFCCA701), Color(0xFFD99C01)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.w,
              ),
            ),
            child: const Text('Champion', style: AppTextStyles.text18WhiteBold),
          ),
        ],
      ),
    );
  }
}
