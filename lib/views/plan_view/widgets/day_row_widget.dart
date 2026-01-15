import 'package:fitness_app_ui/models/workout_task_model.dart';
import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:fitness_app_ui/theme_data/palette.dart';
import 'package:flutter/material.dart';

import 'task_card_widget.dart';

class DayRowWidget extends StatelessWidget {
  final int weekIndex;
  final int dayIndex;
  final DateTime weekStart;
  final List<WorkoutTaskModel> tasks;
  final Function(
    int sourceWeek,
    int sourceDay,
    int destWeek,
    int destDay,
    WorkoutTaskModel task,
  )
  onTaskMoved;

  const DayRowWidget({
    super.key,
    required this.weekIndex,
    required this.dayIndex,
    required this.weekStart,
    required this.tasks,
    required this.onTaskMoved,
  });

  @override
  Widget build(BuildContext context) {
    final dayDate = weekStart.add(Duration(days: dayIndex));
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return DragTarget<Map<String, dynamic>>(
      onAcceptWithDetails: (details) {
        final sourceWeek = details.data['weekIndex'] as int;
        final sourceDay = details.data['dayIndex'] as int;
        final task = details.data['task'] as WorkoutTaskModel;
        onTaskMoved(sourceWeek, sourceDay, weekIndex, dayIndex, task);
      },
      builder: (context, candidateData, rejectedData) {
        return SizedBox(
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dayNames[dayIndex],
                      style: CustomFontStyle.boldText.copyWith(
                        color: tasks.isEmpty
                            ? Palette.lightSecondaryColor
                            : null,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${dayDate.day}',
                      style: CustomFontStyle.regularText.copyWith(
                        color: tasks.isEmpty
                            ? Palette.lightSecondaryColor
                            : null,

                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: tasks.isEmpty
                    ? Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: candidateData.isNotEmpty
                                ? Palette.primaryColor
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: .center,
                        children: tasks.map((task) {
                          return TaskCardWidget(
                            task: task,
                            weekIndex: weekIndex,
                            dayIndex: dayIndex,
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
