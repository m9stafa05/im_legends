import 'package:flutter/material.dart';

class TextStyleFactory {
  static TextStyle create({
    required String font,
    required double size,
    required FontWeight weight,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: font,
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }
}
