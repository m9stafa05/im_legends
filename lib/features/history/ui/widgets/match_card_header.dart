import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchCardHeader extends StatelessWidget {
  final DateTime matchDate;
  final Color primaryColor;

  const MatchCardHeader({
    super.key,
    required this.matchDate,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '${matchDate.day}/${matchDate.month}/${matchDate.year} | ${matchDate.hour.toString().padLeft(2, '0')}:${matchDate.minute.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Icon(Icons.sports_soccer, color: primaryColor, size: 24.sp),
      ],
    );
  }
}
