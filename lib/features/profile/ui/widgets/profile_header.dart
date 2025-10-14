import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/text_styles/bebas_text_styles.dart';
import '../../../../core/utils/functions/get_rank_color.dart';

class ProfileHeader extends StatelessWidget {
  final int rank;
  final String name;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.rank,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h,
      decoration: BoxDecoration(
      
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.4 * 255).toInt()),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150.w,
            height: 150.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withAlpha((0.3 * 255).toInt()),
              ),
            ),
            child: Center(
              child: imageUrl != null
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: imageUrl!,
                        fit: BoxFit.cover,
                        width: 200.w,
                        height: 200.h,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(strokeWidth: 2),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person, color: Colors.white),
                      ),
                    )
                  : const Icon(Icons.person, color: Colors.white),
            ),
          ),
          SizedBox(height: 10.h),
          // Username
          Text(name, style: BebasTextStyles.whiteBold24),
          SizedBox(height: 12.h),
          // Rank Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: getRankColor(rank),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Colors.white.withAlpha((0.3 * 255).toInt()),
                width: 1.w,
              ),
              boxShadow: rank <= 3
                  ? [
                      BoxShadow(
                        color: getRankColor(rank),
                        blurRadius: 6.r,
                        offset: Offset(0, 2.h),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.emoji_events, size: 16.sp, color: Colors.white),
                SizedBox(width: 8.w),
                Text('#$rank', style: BebasTextStyles.whiteBold20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
