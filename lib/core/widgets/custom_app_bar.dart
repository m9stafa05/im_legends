// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_legends/features/notification/logic/cubit/notifications_cubit.dart';
import '../utils/spacing.dart';
import 'notification_icon.dart';
import '../themes/app_texts_style.dart';
import '../utils/app_assets.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF191919),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF323743),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(title, style: BebasTextStyles.whiteBold20),
            ),
          ),
          // Notifications from cubit
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsSuccess) {
                final unreadCount = state.notifications
                    .where((notification) => !notification.isRead)
                    .length;
                return NotificationIcon(unreadCount: unreadCount);
              } else {
                return const NotificationIcon(unreadCount: 0);
              }
            },
          ),
          horizontalSpacing(8),
          // Avatar / Logo
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
