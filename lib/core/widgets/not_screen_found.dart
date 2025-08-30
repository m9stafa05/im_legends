import 'package:flutter/material.dart';
import 'package:im_legends/core/router/routes.dart';
import 'package:im_legends/core/themes/app_colors.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1E2C), Color(0xFF3A3A4F)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 100,
                  color: AppColors.darkRedColor,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Oops! Page not found.',
                  style: AppTextStyles.text20WhiteBold, // make text bigger
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'The page you are looking for does not exist.\nTry going back to home.',
                  style: AppTextStyles.text16WhiteBold, // normal text style
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkRedColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.homeScreen);
                  },
                  child: const Text(
                    'Go to Home',
                    style: AppTextStyles.text16WhiteBold,
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
