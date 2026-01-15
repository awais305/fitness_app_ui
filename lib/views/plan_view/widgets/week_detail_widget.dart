import 'package:fitness_app_ui/models/workout_task_model.dart';
import 'package:fitness_app_ui/theme_data/palette.dart';
import 'package:flutter/material.dart';

import '../../../theme_data/fonts.dart';
import 'day_row_widget.dart';

class WeekDetailWidget extends StatelessWidget {
  final int weekIndex;
  final Map<int, Map<int, List<WorkoutTaskModel>>> weekData;
  final Function(
    int sourceWeek,
    int sourceDay,
    int destWeek,
    int destDay,
    WorkoutTaskModel task,
  )
  onTaskMoved;

  const WeekDetailWidget({
    super.key,
    required this.weekIndex,
    required this.weekData,
    required this.onTaskMoved,
  });

  DateTime getWeekStartDate(int weekIndex) {
    final baseDate = DateTime(2024, 12, 8);
    return baseDate.add(Duration(days: weekIndex * 7));
  }

  String formatDateRange(DateTime start) {
    final end = start.add(const Duration(days: 6));
    return '${_monthName(start.month)} ${start.day}-${end.day}';
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  int getTotalMinutes(int weekIndex) {
    int total = 0;
    final week = weekData[weekIndex] ?? {};
    for (var tasks in week.values) {
      for (var task in tasks) {
        final minutes = int.tryParse(task.duration.split('m').first) ?? 0;
        total += minutes;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final startDate = getWeekStartDate(weekIndex);
    final dateRange = formatDateRange(startDate);
    final totalMinutes = getTotalMinutes(weekIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _WeekHeader(
          weekIndex: weekIndex,
          dateRange: dateRange,
          totalMinutes: totalMinutes,
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const Divider(
            color: Palette.lightSecondaryColor,
            height: 1,
            thickness: 1,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 7,
          itemBuilder: (context, dayIndex) {
            return DayRowWidget(
              weekIndex: weekIndex,
              dayIndex: dayIndex,
              weekStart: startDate,
              tasks: weekData[weekIndex]?[dayIndex] ?? [],
              onTaskMoved: onTaskMoved,
            );
          },
        ),
      ],
    );
  }
}

class _WeekHeader extends StatelessWidget {
  final int weekIndex;
  final String dateRange;
  final int totalMinutes;

  const _WeekHeader({
    required this.weekIndex,
    required this.dateRange,
    required this.totalMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 8),
      decoration: BoxDecoration(
        color: Palette.secondaryColor,
        border: Border(
          top: BorderSide(width: 3, color: Palette.legWorkoutColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Week ${weekIndex + 2}/8',
            style: CustomFontStyle.boldText.copyWith(fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateRange,
                style: CustomFontStyle.regularText.copyWith(
                  fontSize: 16,
                  color: const Color(0xFF7A7C90),
                ),
              ),
              Text(
                'Total: ${totalMinutes}min',
                style: CustomFontStyle.regularText.copyWith(
                  fontSize: 16,
                  color: const Color(0xFF7A7C90),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
