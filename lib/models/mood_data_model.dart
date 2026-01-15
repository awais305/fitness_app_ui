import 'package:flutter/material.dart';

class MoodDataModel {
  final String label;
  final String emoji;
  final List<Color> gradientColors;

  MoodDataModel({
    required this.label,
    required this.emoji,
    required this.gradientColors,
  });
}
