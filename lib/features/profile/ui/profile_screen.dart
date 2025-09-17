import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_text_button.dart';
import 'widgets/profile_header.dart';
import 'widgets/states_grid_view.dart';
import 'widgets/recent_matches_card.dart';
import 'widgets/user_card_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: 'Profile'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Header with Edit Button
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const ProfileHeader(rank: 1),
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          onPressed: () {
                            // Navigate to edit profile screen
                          },
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing(16),
                  // User Info
                  const UserInfoCard(
                    age: 25,
                    email: 'mustafa@example.com',
                    phoneNumber: '+1234567890',
                    isOwnProfile:
                        true, // Set to false for other users' profiles
                  ),
                  verticalSpacing(16),
                  // Stats Grid
                  const StatsGridView(
                    stats: [
                      {'label': 'Points', 'value': '30', 'icon': Icons.star},
                      {
                        'label': 'MATCHES',
                        'value': '10',
                        'icon': Icons.sports_esports,
                      },
                      {
                        'label': 'Wins',
                        'value': '10',
                        'icon': Icons.emoji_events,
                      },
                      {
                        'label': 'Goals',
                        'value': '25',
                        'icon': Icons.sports_soccer,
                      },
                    ],
                  ),
                  verticalSpacing(16),
                  // Recent Matches
                  RecentMatchesCard(
                    matches: [
                      {
                        'opponent': 'Alex',
                        'score': '3-1',
                        'date': DateTime.now().subtract(
                          const Duration(days: 1),
                        ),
                      },
                      {
                        'opponent': 'Sara',
                        'score': '2-2',
                        'date': DateTime.now().subtract(
                          const Duration(days: 3),
                        ),
                      },
                      {
                        'opponent': 'Mike',
                        'score': '4-0',
                        'date': DateTime.now().subtract(
                          const Duration(days: 5),
                        ),
                      },
                    ],
                  ),
                  verticalSpacing(16),
                  SizedBox(
                    width: 200.w,
                    child: CustomTextButton(
                      buttonText: 'Logout',
                      onPressed: () {},
                      backgroundColor: Colors.red,
                    ),
                  ),
                  verticalSpacing(32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
