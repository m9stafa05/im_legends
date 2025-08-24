import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_legends/core/router/routes.dart';
import 'package:im_legends/core/utils/extensions.dart';
import 'package:im_legends/features/auth/logic/cubit/auth_cubit.dart';

import '../../../core/themes/app_texts_style.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../../../core/widgets/custom_text_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
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
                verticalSpacing(50),
                Text(
                  'Sign up to IM Legends'.toUpperCase(),
                  style: AppTextsStyle.font20WhiteBold,
                ),
                verticalSpacing(50),
                SignUpBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  late TextEditingController emailController;

  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          AppTextFormField(hintText: 'Name', validator: (String? p1) {}),

          verticalSpacing(20),
          AppTextFormField(
            controller: emailController,
            hintText: 'email',
            validator: (String? value) {
              if (value == null || value.isEmpty) return 'Email is required';
              if (!value.contains('@')) return 'Enter a valid email';
              return null;
            },
          ),
          verticalSpacing(20),
          AppTextFormField(
            controller: passwordController,
            hintText: 'Password',
            isObscureText: true,
            validator: (String? value) {
              if (value == null || value.length < 6)
                return 'Password must be at least 6 characters';
              return null;
            },
          ),
          verticalSpacing(20),
          // AppTextFormField(
          //   hintText: 'Confirm Password',
          //   isObscureText: true,
          //   validator: (String? p1) {},
          // ),
          verticalSpacing(20),
          Text('Forgot Password?', style: AppTextsStyle.font14GreyBold),
          verticalSpacing(50),
          SizedBox(
            width: 250.w,
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  // Close loading dialog if it's showing
                  Navigator.of(context).pop();

                  // Show success dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Sign Up Successful'),
                      content: const Text(
                        'Your account has been created successfully!',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            context.pushReplacementNamed(Routes.homeScreen);
                          },
                          child: const Text('Continue'),
                        ),
                      ],
                    ),
                  );
                } else if (state is AuthFailure) {
                  debugPrint(state.errorMessage);
                  // Close loading dialog if open
                  Navigator.of(context).pop();

                  // Show failure dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Sign Up Failed'),
                      content: Text(state.errorMessage),

                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (state is AuthLoading) {
                  // Show loading dialog
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                }
              },
              child: CustomTextButton(
                borderRadius: 20.r,
                buttonText: 'Sign Up',
                onPressed: () {
                  context.read<AuthCubit>().emitSignUp(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
              ),
            ),
          ),

          verticalSpacing(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'already have an account?',
                style: AppTextsStyle.font14WhiteBold,
              ),
              TextButton(
                child: Text('Login', style: AppTextsStyle.font14GreyBold),
                onPressed: () {
                  context.pushReplacementNamed(Routes.loginScreen);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
