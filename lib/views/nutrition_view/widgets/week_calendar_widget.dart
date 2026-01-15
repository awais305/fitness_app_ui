import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:fitness_app_ui/theme_data/palette.dart';
import 'package:fitness_app_ui/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'calendar_bottom_sheet.dart';

class WeekCalendarWidget extends StatefulWidget {
  const WeekCalendarWidget({super.key});

  @override
  State<WeekCalendarWidget> createState() => _WeekCalendarWidgetState();
}

class _WeekCalendarWidgetState extends State<WeekCalendarWidget> {
  DateTime selectedDate = DateTime.now();

  int getWeekOfMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final firstDayOfWeek = firstDay.weekday;
    final offsetDate = date.day + firstDayOfWeek - 1;
    return (offsetDate / 7).ceil();
  }

  int getTotalWeeksInMonth(DateTime date) {
    final lastDay = DateTime(date.year, date.month + 1, 0);
    final daysInMonth = lastDay.day;
    final firstDayOfWeek = DateTime(date.year, date.month, 1).weekday;
    return ((daysInMonth + firstDayOfWeek - 1) / 7).ceil();
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool isTomorrow(DateTime date) {
    final now = DateTime.now().add(Duration(days: 1));
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  List<DateTime> getWeekDays(DateTime date) {
    final day = date.weekday;
    final monday = date.subtract(Duration(days: day - 1));
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final currentWeek = getWeekOfMonth(selectedDate);
    final totalWeeks = getTotalWeeksInMonth(selectedDate);
    final weekDays = getWeekDays(selectedDate);

    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(AssetIcons.bell, width: 24, height: 24),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  builder: (context) => CalendarBottomSheet(
                    initialDate: selectedDate,
                    onDateSelected: (date) {
                      setState(() => selectedDate = date);
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Image.asset(AssetIcons.timer, width: 20, height: 20),
                    const SizedBox(width: 4),
                    Text(
                      'Week $currentWeek/$totalWeeks',
                      style: CustomFontStyle.boldText.copyWith(fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    Transform.scale(
                      scale: 1.3,
                      child: const Icon(Icons.arrow_drop_down_sharp),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 24),
          ],
        ),

        const SizedBox(height: 24),
        // Today's date
        Text(
          isToday(selectedDate)
              ? 'Today, ${DateFormat('dd MMM yyyy').format(selectedDate)}'
              : isTomorrow(selectedDate)
              ? 'Tomorrow, ${DateFormat('dd MMM yyyy').format(selectedDate)}'
              : DateFormat('dd MMM yyyy').format(selectedDate),
          style: CustomFontStyle.boldText.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 16),

        // Week calendar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekDays.map((date) {
            bool isSelectedDate = selectedDate == date;
            final isCurrentDay = isToday(date);

            return Column(
              children: [
                Text(
                  DateFormat('E').format(date).substring(0, 2).toUpperCase(),
                  style: CustomFontStyle.boldText.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    setState(() => selectedDate = date);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelectedDate || isCurrentDay
                          ? Palette.armsWorkoutColor.withValues(alpha: 0.3)
                          : Palette.secondaryColor,
                      border: isSelectedDate
                          ? Border.all(
                              color: Palette.armsWorkoutColor,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: CustomFontStyle.boldText.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelectedDate
                        ? Palette.armsWorkoutColor
                        : Palette.scaffoldBackgroundColor,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(height: 5, width: 40, color: Color(0xFF282A39)),
        ),
      ],
    );
  }
}
