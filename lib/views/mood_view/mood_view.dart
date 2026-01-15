import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:fitness_app_ui/theme_data/palette.dart';
import 'package:fitness_app_ui/utils/constants.dart';
import 'package:fitness_app_ui/utils/enums.dart';
import 'package:fitness_app_ui/views/mood_view/widgets/button_widget.dart';
import 'package:fitness_app_ui/views/mood_view/widgets/mood_selector_widget.dart';
import 'package:flutter/material.dart';

class MoodView extends StatefulWidget {
  const MoodView({super.key});

  @override
  State<MoodView> createState() => _MoodViewState();
}

class _MoodViewState extends State<MoodView> {
  MoodType selectedMood = MoodType.happy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AssetImages.bgSpot),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Mood',
                    style: CustomFontStyle.regularText.copyWith(fontSize: 32),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Start your day',
                    style: CustomFontStyle.regularText.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'How are you feeling at the\nMoment?',
                    style: CustomFontStyle.semiboldText.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 38),
                  MoodSelectorWidget(
                    currentMood: selectedMood,
                    onMoodChanged: (mood) {
                      selectedMood = mood;
                    },
                  ),
                  const Spacer(),
                  ButtonWidget(
                    text: 'Continue',
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Selected mood: ${selectedMood.name.toUpperCase()}',
                            style: CustomFontStyle.regularText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Palette.parrotColor,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
