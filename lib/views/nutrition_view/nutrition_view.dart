import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:fitness_app_ui/utils/constants.dart';
import 'package:flutter/material.dart';

import 'widgets/calories_card_widget.dart';
import 'widgets/hydration_card_widget.dart';
import 'widgets/week_calendar_widget.dart';
import 'widgets/weight_card_wdiget.dart';
import 'widgets/workout_tile_widget.dart';

class NutritionView extends StatelessWidget {
  const NutritionView({super.key});

  String getTimeIcon() {
    final hour = DateTime.now().hour;
    return (hour >= 18 || hour < 6) ? AssetIcons.moon : AssetIcons.sun;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeekCalendarWidget(),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Workouts', style: CustomFontStyle.semiboldText),
                    Row(
                      spacing: 12,
                      children: [
                        Image.asset(getTimeIcon(), width: 24),
                        Text(
                          '9°',
                          style: CustomFontStyle.semiboldText.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                WorkoutTileWidget(),
                const SizedBox(height: 32),

                const Text('My Insights', style: CustomFontStyle.semiboldText),
                const SizedBox(height: 24),

                IntrinsicHeight(
                  child: Row(
                    spacing: 12,
                    children: [
                      Expanded(child: CaloriesCardWidget()),
                      Expanded(child: WeightCardWdiget()),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                HydrationCardWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
