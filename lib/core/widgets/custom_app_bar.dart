import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../themes/app_texts_style.dart';
import '../utils/app_assets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF191919),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16), // Rounded bottom
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF323743), // subtle shadow
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(title, style: AppTextStyles.text20WhiteBold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_rounded, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: SvgPicture.asset(
                AppAssets.appLogo,
                height: 36,
                width: 36,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
