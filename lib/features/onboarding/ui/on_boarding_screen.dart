import 'package:flutter/material.dart';
import '../../../core/widgets/logo_top_bar.dart';
import 'widgets/on_boarding_grid_cards.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_texts_style.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/spacing.dart';
import 'widgets/on_boarding_button.dart';
import '../../../core/router/routes.dart';

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
              LogoTopBar(),
              Text(
                'Unleash Your Inner Football Legend!',
                style: AppTextStyles.text14GreyBold,
              ),
              verticalSpacing(50),
              OnBoardingGridCards(),
              verticalSpacing(100),
              OnBoardingButton(
                title: 'Log In',
                icon: Icons.login,
                backgroundColor: AppColors.darkRedColor,
                onTap: () => context.pushNamed(Routes.loginScreen),
              ),
              verticalSpacing(20),
              OnBoardingButton(
                title: 'Create Account',
                icon: Icons.person_add,
                onTap: () => context.pushNamed(Routes.signUpScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
