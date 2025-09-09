import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/utils/spacing.dart';

class HistoryCardPlayerInfo extends StatelessWidget {
  final String playerName;
  final String? avatarUrl;
  final bool isWinner;
  final Color winColor;
  final Color loseColor;
  final bool isLeftSide;

  const HistoryCardPlayerInfo({
    super.key,
    required this.playerName,
    this.avatarUrl,
    required this.isWinner,
    required this.winColor,
    required this.loseColor,
    this.isLeftSide = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Text color adapts to winner/loser and theme
    final nameColor = isWinner
        ? winColor
        : theme.brightness == Brightness.dark
        ? Colors.grey.shade400
        : loseColor.withOpacity(0.9);

    // Avatar background adapts to theme
    final avatarBgColor = isWinner
        ? winColor.withOpacity(0.2)
        : loseColor.withOpacity(0.15);

    // Trophy color
    final trophyColor = theme.brightness == Brightness.dark
        ? Colors.amber.shade300
        : Colors.amber.shade600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isLeftSide
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        // Avatar with glow
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isWinner
                    ? winColor.withOpacity(0.5) // brighter winner glow
                    : Colors.black.withOpacity(0.3), // subtle shadow
                blurRadius: isWinner ? 14.r : 6.r,
                spreadRadius: isWinner ? 3.r : 1.r,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 26.r,
            backgroundColor: avatarBgColor,
            backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                ? NetworkImage(avatarUrl!)
                : null,
            child: (avatarUrl == null || avatarUrl!.isEmpty)
                ? Icon(
                    Icons.person,
                    size: 22.sp,
                    color: isWinner
                        ? winColor
                        : theme.colorScheme.onSurface.withOpacity(0.6),
                  )
                : null,
          ),
        ),

        SizedBox(height: 6.h),

        // Player name
        Row(
          children: [
            Text(
              playerName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: nameColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: isLeftSide ? TextAlign.left : TextAlign.right,
            ),
            horizontalSpacing(5),
            if (isWinner)
              Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: Icon(
                  Icons.emoji_events,
                  size: 14.sp,
                  color: trophyColor,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
