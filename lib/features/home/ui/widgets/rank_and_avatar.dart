import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/functions/get_rank_color.dart';

class RankAndAvatar extends StatelessWidget {
  const RankAndAvatar({
    super.key,
    this.imageUrl,
    this.rank,
    required this.isCurrentUser,
  });

  final String? imageUrl;
  final int? rank;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isCurrentUser ? 70.w : 60.w,
      child: Stack(
        children: [
          // Avatar
          Center(
            child: Container(
              width: isCurrentUser ? 70.w : 50.w,
              height: isCurrentUser ? 70.w : 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.2 * 255).toInt()),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 50.r,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: imageUrl == null || imageUrl!.isEmpty
                      ? Image.asset(AppAssets.appLogoPng, fit: BoxFit.cover)
                      : CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(
                            AppAssets.appLogoPng,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            AppAssets.appLogoPng,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
          ),

          // Rank Badge
          if (rank != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getRankColor(rank!),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    '$rank',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
