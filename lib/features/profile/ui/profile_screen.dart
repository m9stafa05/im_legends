import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:im_legends/core/router/routes.dart';
import '../logic/cubit/profile_cubit.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_text_button.dart';
import 'widgets/profile_header.dart';
import 'widgets/states_grid_view.dart';
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
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProfileSuccess) {
                    final playerProfile = state.player.user;
                    final playerStates = state.player.stats;
                    return Column(
                      children: [
                        // Profile Header with Edit Button
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ProfileHeader(
                              rank: 1,
                              name: playerProfile.name,
                              imageUrl: playerProfile.profileImageUrl,
                            ),
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
                        UserInfoCard(
                          age: playerProfile.age,
                          email: playerProfile.email,
                          phoneNumber: playerProfile.phoneNumber,
                          isOwnProfile:
                              true, // Set to false for other users' profiles
                        ),
                        verticalSpacing(16),
                        // Stats Grid
                        StatsGridView(
                          stats: [
                            {
                              'label': 'Points',
                              'value': playerStates.points,
                              'icon': Icons.star,
                            },
                            {
                              'label': 'MATCHES',
                              'value': playerStates.matchesPlayed,
                              'icon': Icons.sports_esports,
                            },
                            {
                              'label': 'Wins',
                              'value': playerStates.wins,
                              'icon': Icons.emoji_events,
                            },
                            {
                              'label': 'Goals',
                              'value': playerStates.goals,
                              'icon': Icons.sports_soccer,
                            },
                          ],
                        ),

                        verticalSpacing(16),
                        // Recent Matches
                        // RecentMatchesCard(
                        //   matches: [
                        //     {
                        //       'opponent': 'Alex',
                        //       'score': '3-1',
                        //       'date': DateTime.now().subtract(
                        //         const Duration(days: 1),
                        //       ),
                        //     },
                        //     {
                        //       'opponent': 'Sara',
                        //       'score': '2-2',
                        //       'date': DateTime.now().subtract(
                        //         const Duration(days: 3),
                        //       ),
                        //     },
                        //     {
                        //       'opponent': 'Mike',
                        //       'score': '4-0',
                        //       'date': DateTime.now().subtract(
                        //         const Duration(days: 5),
                        //       ),
                        //     },
                        //   ],
                        // ),
                        verticalSpacing(16),
                        SizedBox(
                          width: 200.w,
                          child: CustomTextButton(
                            buttonText: 'Logout',
                            onPressed: () {
                              context.read<ProfileCubit>().logout();
                              context.go(Routes.onBoardingScreen);
                            },
                            backgroundColor: Colors.red,
                          ),
                        ),
                        verticalSpacing(32),
                      ],
                    );
                  } else if (state is ProfileFailure) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
