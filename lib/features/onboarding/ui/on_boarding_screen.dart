import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_legends/core/themes/app_colors.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/spacing.dart';
import 'package:im_legends/features/onboarding/ui/widgets/on_boarding_button.dart';
import 'package:im_legends/features/onboarding/ui/widgets/on_boarding_custom_card.dart';
import '../../../core/utils/app_assets.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.appLogo,
                    height: 100.h,
                    width: 100.w,
                  ),
                  Text('IM Legends', style: AppTextsStyle.font18RedBold),
                ],
              ),
              Text(
                'Unleash Your Inner Football Legend!',
                style: AppTextsStyle.font14GreyBold,
              ),
              verticalSpacing(50),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 40.w,
                mainAxisSpacing: 20.h,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  OnBoardingCustomCard(
                    title: 'Track Your Rankings',
                    subTitle:
                        'See how you stack up against friends in real-time leaderboards.',
                  ),
                  OnBoardingCustomCard(
                    title: 'Log New Matches',
                    subTitle:
                        'Record scores & stats with ease after every thrilling game.',
                  ),
                  OnBoardingCustomCard(
                    title: 'Earn Badges & Rewards',
                    subTitle:
                        'Unlock milestones and show off your football achievements.',
                  ),
                  OnBoardingCustomCard(
                    title: 'Play Anywhere, Anytime',
                    subTitle:
                        'No internet? No problem. Enjoy offline mode features.',
                  ),
                ],
              ),
              // OnBoardingCustomCard(
              //   title: 'Track Your Rankings',
              //   subTitle:
              //       'See how you stack up against friends in real-time leaderboards.',
              // ),
              verticalSpacing(50),
              OnBoardingButton(
                title: 'Sign In',
                backgroundColor: AppColors.darkRedColor,
              ),
              verticalSpacing(20),
              OnBoardingButton(title: 'Create Account'),
            ],
          ),
        ),
      ),
    );
  }
}
