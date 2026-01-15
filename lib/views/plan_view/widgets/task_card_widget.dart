import 'package:fitness_app_ui/models/workout_task_model.dart';
import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:fitness_app_ui/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../theme_data/palette.dart';

class TaskCardWidget extends StatelessWidget {
  final WorkoutTaskModel task;
  final int weekIndex;
  final int dayIndex;

  const TaskCardWidget({
    super.key,
    required this.task,
    required this.weekIndex,
    required this.dayIndex,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return LongPressDraggable<Map<String, dynamic>>(
      delay: Duration.zero,
      data: {'task': task, 'weekIndex': weekIndex, 'dayIndex': dayIndex},
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: screenWidth - 100,
          child: AnimatedOpacity(
            duration: Durations.medium1,
            opacity: 0.8,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: task.categoryColor, width: 2),
              ),
              child: TaskContent(task: task),
            ),
          ),
        ),
      ),
      childWhenDragging: AnimatedOpacity(
        duration: Durations.medium1,
        opacity: 0.3,
        child: TaskCardContent(task: task),
      ),
      child: TaskCardContent(task: task),
    );
  }
}

class TaskCardContent extends StatelessWidget {
  final WorkoutTaskModel task;

  const TaskCardContent({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 16),
      decoration: BoxDecoration(
        color: Palette.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border(left: BorderSide(color: Palette.primaryColor, width: 6)),
      ),
      child: TaskContent(task: task),
    );
  }
}

class TaskContent extends StatelessWidget {
  final WorkoutTaskModel task;

  const TaskContent({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Image.asset(AssetIcons.handle, height: 22),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                  color: task.categoryColor.withValues(alpha: 0.15),
                ),
                child: Row(
                  spacing: 4,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(task.icon, width: 10),
                    Text(
                      task.category,
                      style: CustomFontStyle.semiboldText.copyWith(
                        fontSize: 10,
                        color: task.categoryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.title,
                    style: CustomFontStyle.regularText.copyWith(fontSize: 14),
                  ),
                  Text(
                    task.duration,
                    style: CustomFontStyle.regularText.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
