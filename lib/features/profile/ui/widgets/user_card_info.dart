import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UserInfoCard extends StatelessWidget {
  final int age;
  final String email;
  final String? phoneNumber;
  final bool isOwnProfile;

  const UserInfoCard({
    super.key,
    required this.age,
    required this.email,
    this.phoneNumber,
    this.isOwnProfile = false,
  });

  String _obscureEmail(String email) {
    final parts = email.split('@');
    if (parts[0].length <= 2) return email;
    final obscured = '${parts[0][0]}***@${parts[1]}';
    return obscured;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey.shade900, Colors.blue.shade900.withOpacity(0.6)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(icon: Icons.cake, label: 'Age', value: '$age years'),
          SizedBox(height: 8.h),
          _buildInfoRow(
            icon: Icons.email,
            label: 'Email',
            value: isOwnProfile ? email : _obscureEmail(email),
          ),
          if (phoneNumber != null && isOwnProfile) ...[
            SizedBox(height: 8.h),
            _buildInfoRow(
              icon: Icons.phone,
              label: 'Phone',
              value: phoneNumber!,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: Colors.blue.shade300),
        SizedBox(width: 12.w),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade400),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
