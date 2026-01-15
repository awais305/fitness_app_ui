import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:fitness_app_ui/views/mood_view/mood_view.dart';
import 'package:fitness_app_ui/views/nutrition_view/nutrition_view.dart';
import 'package:fitness_app_ui/views/plan_view/plan_view.dart';
import 'package:flutter/material.dart';

import 'theme_data/palette.dart';
import 'utils/constants.dart';

class BottomNavbarView extends StatefulWidget {
  const BottomNavbarView({super.key});

  @override
  State<BottomNavbarView> createState() => _BottomNavbarViewState();
}

class _BottomNavbarViewState extends State<BottomNavbarView> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (pageIndex) {
        0 => const NutritionView(),
        1 => const PlanView(),
        2 => const MoodView(),
        3 => Center(
          child: Text(
            'Profile View',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        _ => Center(
          child: Text(
            'Page not found',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      },
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Palette.disabledColorColor, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,

          selectedItemColor: Palette.primaryColor,
          iconSize: 10,
          unselectedItemColor: Palette.disabledColorColor,
          backgroundColor: Palette.scaffoldBackgroundColor,
          currentIndex: pageIndex,
          selectedLabelStyle: CustomFontStyle.regularText.copyWith(
            fontSize: 14,
          ),
          unselectedLabelStyle: CustomFontStyle.regularText.copyWith(
            fontSize: 14,
          ),
          onTap: (int index) => setState(() => pageIndex = index),
          items: [
            buildNavBarItem(
              AssetIcons.nutrition,
              'Nutrition',
              pageIndex == 0,
              24,
            ),
            buildNavBarItem(AssetIcons.plan, 'Plan', pageIndex == 1),
            buildNavBarItem(AssetIcons.mood, 'Mood', pageIndex == 2),
            buildNavBarItem(AssetIcons.profile, 'Profile', pageIndex == 3),
          ],
        ),
      ),
    );
  }
}

BottomNavigationBarItem buildNavBarItem(
  String iconPath,
  String label,
  bool isActive, [
  double width = 22,
]) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 13),
      child: Image.asset(
        iconPath,
        width: width,
        color: isActive ? Palette.primaryColor : Palette.disabledColorColor,
      ),
    ),
    label: label,
  );
}
