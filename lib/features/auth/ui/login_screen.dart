import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_legends/core/utils/extensions.dart';
import 'package:im_legends/core/widgets/app_text_form_field.dart';
import 'package:im_legends/features/auth/logic/cubit/auth_cubit.dart';

import '../../../core/router/routes.dart';
import '../../../core/themes/app_texts_style.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/custom_text_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  'Login to IM Legends'.toUpperCase(),
                  style: AppTextsStyle.font20WhiteBold,
                ),
                verticalSpacing(50),
                LoginBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
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
          AppTextFormField(
            controller: emailController,
            hintText: 'email',
            validator: (String? p1) {},
          ),
          verticalSpacing(20),
          AppTextFormField(
            controller: passwordController,
            hintText: 'Password',
            validator: (String? p1) {},
          ),
          verticalSpacing(20),
          Text('Forgot Password?', style: AppTextsStyle.font14GreyBold),
          verticalSpacing(50),
          SizedBox(
            width: 250.w,
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.of(context).pop(); // close loading dialog if open
                  context.pushReplacementNamed(Routes.homeScreen);
                } else if (state is AuthFailure) {
                  Navigator.of(context).pop(); // close loading dialog if open
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Failed'),
                      content: const Text(
                        'Please check your email or password and try again.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (state is AuthLoading) {
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
                buttonText: 'Login',
                onPressed: () {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter email and password'),
                      ),
                    );
                    return;
                  }
                  context.read<AuthCubit>().emitLogin(
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
                'Don\'t have an account?',
                style: AppTextsStyle.font14WhiteBold,
              ),
              TextButton(
                child: Text('Sign up', style: AppTextsStyle.font14GreyBold),
                onPressed: () {
                  context.pushReplacementNamed(Routes.signUpScreen);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// test10@gmail.com
// 12345678