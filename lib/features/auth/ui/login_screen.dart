import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/themes/app_texts_style.dart';
import 'widgets/auth_bloc_consumer.dart';
import '../../../core/router/routes.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/logo_top_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoTopBar(),
                  verticalSpacing(40.h),
                  Text(
                    'Login to IM Legends',
                    style: BebasTextStyles.whiteBold24,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpacing(32.h),
                  const AuthBlocConsumer(),
                  verticalSpacing(24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TajawalTextStyles.whiteBold16,
                      ),

                      TextButton(
                        onPressed: () => context.go(Routes.signUpScreen),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, // removes extra padding
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          overlayColor: Colors.white24, // subtle ripple effect
                        ),
                        child: Text(
                          " Create an Account",
                          style: BebasTextStyles.greyRegular16.copyWith(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5, // makes underline bolder
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
