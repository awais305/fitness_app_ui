import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:fitness_app_ui/theme_data/palette.dart';
import 'package:flutter/material.dart';

class WorkoutTileWidget extends StatelessWidget {
  const WorkoutTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Palette.secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(9)),
        border: const Border(
          left: BorderSide(color: Palette.bodyColorTag, width: 7),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'December 22 - 25m - 30m',
                style: CustomFontStyle.boldText.copyWith(fontSize: 12),
              ),
              SizedBox(height: 8),
              Text(
                'Upper Body',
                style: CustomFontStyle.boldText.copyWith(fontSize: 24),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward, color: Colors.white, size: 24),
        ],
      ),
    );
  }
}
