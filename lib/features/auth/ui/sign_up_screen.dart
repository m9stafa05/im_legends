import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/themes/app_texts_style.dart';
import '../data/models/user_data.dart';
import 'widgets/sign_up_form.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/logo_top_bar.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/custom_text_button.dart';
import '../logic/cubit/auth_cubit.dart';
import '../../../core/router/routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const LogoTopBar(),
                  verticalSpacing(40.h),
                  const Text(
                    'Sign Up to IM Legends',
                    style: AppTextStyles.textFederant20GreyBold,
                    semanticsLabel: 'Sign Up to IM Legends',
                  ),
                  verticalSpacing(32.h),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoading) {
                        _showLoadingDialog(context);
                      } else if (Navigator.canPop(context)) {
                        Navigator.pop(context); // Close loading dialog
                      }

                      if (state is AuthSuccess) {
                        final user = state.authResponse.user;
                        final token = state.authResponse.session?.accessToken;

                        // Optionally store token/user for later use
                        debugPrint('Logged in user: ${user?.id}');
                        debugPrint('Access Token: $token');

                        context.go(Routes.homeScreen);
                      } else if (state is AuthFailure) {
                        _showErrorDialog(context, state.errorMessage);
                      }
                    },
                    builder: (context, state) {
                      return SignUpForm(
                        onSignUp:
                            (
                              UserData userData,
                              String password,
                              File? profileImage,
                            ) async {
                              context.read<AuthCubit>().emitSignUp(
                                userData: userData,
                                password: password,
                                profileImage: profileImage,
                              );
                            },
                      );
                    },
                  ),
                  verticalSpacing(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: AppTextStyles.textTajawal16WhiteBold,
                      ),

                      TextButton(
                        onPressed: () => context.go(Routes.loginScreen),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, // removes extra padding
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          overlayColor: Colors.white24, // subtle ripple effect
                        ),
                        child: Text(
                          "Log In",
                          style: AppTextStyles.textBebas16GreyRegular.copyWith(
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

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sign Up Failed'),
        content: Text(
          message.isEmpty ? 'An error occurred. Please try again.' : message,
        ),
        actions: [
          CustomTextButton(
            buttonText: 'OK',
            borderRadius: 8.r,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }
}
