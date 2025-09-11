import 'package:flutter/material.dart';

class OnBoardingIcons extends StatelessWidget {
  const OnBoardingIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('⚽', style: TextStyle(fontSize: 20)),

        Container(height: 30, width: 1, color: const Color(0xFF2A3441)),
        const Text('🏆', style: TextStyle(fontSize: 20)),

        Container(height: 30, width: 1, color: const Color(0xFF2A3441)),
        const Text('⭐', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
