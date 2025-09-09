import 'package:flutter/material.dart';

class PlayerFieldAnimations {
  final TickerProvider vsync;

  late AnimationController scaleController;
  late AnimationController rotationController;
  late AnimationController glowController;

  late Animation<double> scaleAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> glowAnimation;

  PlayerFieldAnimations({required this.vsync}) {
    _setupAnimations();
  }

  void _setupAnimations() {
    scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: vsync,
    );

    rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: vsync,
    );

    glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: vsync,
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: scaleController, curve: Curves.easeInOut),
    );

    rotationAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: rotationController, curve: Curves.elasticOut),
    );

    glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: glowController, curve: Curves.easeInOut));
  }

  // 🔹 Control methods
  void startScaleDown() => scaleController.forward();
  void resetScale() => scaleController.reverse();

  void startRotation() => rotationController.forward(from: 0);

  void startGlow() => glowController.repeat(reverse: true);
  void stopGlow() => glowController.stop();

  void dispose() {
    scaleController.dispose();
    rotationController.dispose();
    glowController.dispose();
  }
}
