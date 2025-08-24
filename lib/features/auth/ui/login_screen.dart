import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_legends/core/utils/extensions.dart';
import 'package:im_legends/core/widgets/app_text_form_field.dart';

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      AppTextFormField(
                        hintText: 'email',
                        validator: (String? p1) {},
                      ),
                      verticalSpacing(20),
                      AppTextFormField(
                        hintText: 'Password',
                        validator: (String? p1) {},
                      ),
                      verticalSpacing(20),
                      Text(
                        'Forgot Password?',
                        style: AppTextsStyle.font14GreyBold,
                      ),
                      verticalSpacing(50),
                      SizedBox(
                        width: 250.w,
                        child: CustomTextButton(
                          borderRadius: 20.r,
                          buttonText: 'Login',
                          onPressed: () {},
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
                            child: Text(
                              'Sign up',
                              style: AppTextsStyle.font14GreyBold,
                            ),
                            onPressed: () {
                              context.pushReplacementNamed(Routes.signUpScreen);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
