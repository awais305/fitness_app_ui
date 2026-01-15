import 'package:flutter/material.dart';

class WorkoutTaskModel {
  final String id;
  final String title;
  final String category;
  final String duration;
  final Color categoryColor;
  final String icon;

  WorkoutTaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.duration,
    required this.categoryColor,
    required this.icon,
  });

  WorkoutTaskModel copyWith({
    String? id,
    String? title,
    String? category,
    String? duration,
    Color? categoryColor,
    String? icon,
  }) {
    return WorkoutTaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      categoryColor: categoryColor ?? this.categoryColor,
      icon: icon ?? this.icon,
    );
  }
}
