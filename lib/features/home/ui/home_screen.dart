import 'package:flutter/material.dart';
import '../../../core/themes/app_texts_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Screen', style: AppTextStyles.text18WhiteBold),
      ),
    );
  }
}
