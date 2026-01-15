import 'package:fitness_app_ui/theme_data/palette.dart';
import 'package:flutter/material.dart';

import '../../../theme_data/fonts.dart';

class CaloriesCardWidget extends StatelessWidget {
  const CaloriesCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
        color: Palette.secondaryColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        spacing: 2,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '550',
                      style: CustomFontStyle.semiboldText.copyWith(
                        fontSize: 40,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Calories',
                        style: CustomFontStyle.boldText.copyWith(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Text(
                  '1950 Remaining',
                  style: CustomFontStyle.regularText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Palette.greyColor,
                  ),
                ),

                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0',
                      style: CustomFontStyle.semiboldText.copyWith(
                        fontSize: 14,
                        color: Palette.greyColor,
                      ),
                    ),
                    Text(
                      '2500',
                      style: CustomFontStyle.semiboldText.copyWith(
                        fontSize: 14,
                        color: Palette.greyColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _GradientLinearProgress(value: 0.4, height: 7),
        ],
      ),
    );
  }
}

class _GradientLinearProgress extends StatelessWidget {
  final double value;
  final double height;

  const _GradientLinearProgress({required this.value, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Stack(
        children: [
          Container(height: height, color: Color(0xFF464646)),
          FractionallySizedBox(
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height / 2),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF7BBDE2),
                    Color(0xFF69C0B1),
                    Color(0xFF60C198),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
