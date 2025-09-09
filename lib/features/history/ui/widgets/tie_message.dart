import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TieMessage extends StatelessWidget {
  final Color tieColor;

  const TieMessage({super.key, required this.tieColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.balance, size: 16.sp, color: tieColor),
          SizedBox(width: 4.w),
          Text(
            'It\'s a Tie!',
            style: TextStyle(
              fontSize: 14.sp,
              color: tieColor,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
