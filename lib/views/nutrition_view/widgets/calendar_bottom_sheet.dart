import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:flutter/material.dart';

import '../../../theme_data/palette.dart';

class CalendarBottomSheet extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime date) onDateSelected;

  const CalendarBottomSheet({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
    _selectedDate = widget.initialDate;
  }

  void _goToPreviousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  List<DateTime?> _getDaysInMonth() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final daysInMonth = lastDay.day;
    // Adjust to start from Monday (1=Monday, 7=Sunday)
    final firstWeekday = firstDay.weekday == 7 ? 6 : firstDay.weekday - 1;

    List<DateTime?> days = [];

    // Add empty spaces for days before the first day of the month
    for (int i = 0; i < firstWeekday; i++) {
      days.add(null);
    }

    // Add all days of the month
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    return days;
  }

  String _getMonthYearString() {
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
    return '${months[_currentMonth.month - 1]} ${_currentMonth.year}';
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58,
            height: 4,
            decoration: BoxDecoration(
              color: Palette.lightGreyColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: _goToPreviousMonth,
                child: const Icon(Icons.chevron_left, size: 27),
              ),
              Text(
                _getMonthYearString(),

                style: CustomFontStyle.boldText.copyWith(fontSize: 16),
              ),
              InkWell(
                onTap: _goToNextMonth,
                child: const Icon(Icons.chevron_right, size: 27),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                    .map(
                      (day) => Expanded(
                        child: Center(
                          child: Text(
                            day.toUpperCase(),
                            style: CustomFontStyle.boldText.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    )
                    .expand((element) => [element, SizedBox(width: 19)])
                    .toList()
                  ..removeLast(),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              crossAxisSpacing: 19,
              mainAxisSpacing: 16,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];
              if (day == null) return const SizedBox();

              final isSelected =
                  _selectedDate != null &&
                  day.year == _selectedDate!.year &&
                  day.month == _selectedDate!.month &&
                  day.day == _selectedDate!.day;

              final isToday =
                  day.year == DateTime.now().year &&
                  day.month == DateTime.now().month &&
                  day.day == DateTime.now().day;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = day;
                    widget.onDateSelected(day);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: isSelected || isToday
                        ? Palette.armsWorkoutColor.withValues(alpha: 0.3)
                        : null,
                    border: isSelected
                        ? Border.all(color: Palette.armsWorkoutColor, width: 2)
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: CustomFontStyle.boldText.copyWith(fontSize: 14),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}
