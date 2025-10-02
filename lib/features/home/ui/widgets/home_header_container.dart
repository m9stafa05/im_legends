import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/app_assets.dart';
import '../../logic/cubit/leader_board_cubit.dart';

class HomeHeaderContainer extends StatelessWidget {
  final String? greeting;
  final VoidCallback? onCreateMatch;

  const HomeHeaderContainer({super.key, this.greeting, this.onCreateMatch});

  String _getGreeting() {
    if (greeting != null) return greeting!;
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E2128), Color(0xFF2A2D36)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ✅ Logo
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha((0.1 * 255).toInt()),
                border: Border.all(
                  color: Colors.white.withAlpha((0.2 * 255).toInt()),
                  width: 1,
                ),
              ),
              child: SvgPicture.asset(
                AppAssets.appLogo,
                height: 150.h,
                width: 150.w,
              ),
            ),

            verticalSpacing(20),

            // ✅ User Info from LeaderBoardCubit
            BlocBuilder<LeaderBoardCubit, LeaderBoardState>(
              builder: (context, state) {
                String displayName = "Player";

                if (state is LeaderBoardSuccess) {
                  final currentUserId =
                      Supabase.instance.client.auth.currentUser?.id;
                  final currentPlayer = state.leaderboard.firstWhere(
                    (p) => p.playerId == currentUserId,
                    orElse: () => state.leaderboard.first,
                  );
                  displayName = currentPlayer.playerName;
                } else if (state is LeaderBoardFailure) {
                  displayName = "Error loading user";
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_getGreeting(), style: BorelTextStyles.greyRegular20),
                    verticalSpacing(4),
                    Text(displayName, style: BebasTextStyles.whiteBold20),
                    verticalSpacing(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sports_soccer_rounded,
                          color: const Color(0xFF4A90E2),
                          size: 16.sp,
                        ),
                        horizontalSpacing(4),
                        Text(
                          'Ready to play?',
                          style: FederantTextStyles.greyBold20.copyWith(
                            color: const Color(0xFF4A90E2),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(10),

                    // ✅ Add Match Button
                    SizedBox(
                      width: 200.w,
                      child: CustomTextButton(
                        buttonText: 'Add Match',
                        onPressed: onCreateMatch,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
