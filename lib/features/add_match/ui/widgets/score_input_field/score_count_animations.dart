import 'package:flutter/material.dart';

class ScoreFieldAnimations {
  final TickerProvider vsync;

  late AnimationController scaleController;
  late AnimationController glowController;
  late AnimationController scoreChangeController;

  late Animation<double> scaleAnimation;
  late Animation<double> glowAnimation;
  late Animation<double> scoreChangeAnimation;

  ScoreFieldAnimations({required this.vsync}) {
    _setupAnimations();
  }

  void _setupAnimations() {
    scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: vsync,
    );

    glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: vsync,
    );

    scoreChangeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: vsync,
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: scaleController, curve: Curves.easeInOut),
    );

    glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: glowController, curve: Curves.easeInOut));

    scoreChangeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: scoreChangeController, curve: Curves.elasticOut),
    );

    glowController.repeat(reverse: true);
  }

  // 🔹 Exposed control methods
  void bumpScore() {
    scaleController.forward(from: 0); // quick "pop" animation
  }

  void startGlow() {
    glowController.repeat(reverse: true);
  }

  void stopGlow() {
    glowController.stop();
  }
  void dispose() {
    scaleController.dispose();
    glowController.dispose();
    scoreChangeController.dispose();
  }
}
