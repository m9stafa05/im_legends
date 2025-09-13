import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const GradientBackground({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // full width
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0D1421), // base dark
            Color(0xFF1E293B), // slate
            Color(0xFF0F172A), // very dark navy
          ],
          stops: [0.0, 0.7, 1.0],
        ),

      ),
      child: SafeArea(
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
