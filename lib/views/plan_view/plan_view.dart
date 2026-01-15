import 'package:fitness_app_ui/models/workout_task_model.dart';
import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:fitness_app_ui/theme_data/palette.dart';
import 'package:fitness_app_ui/utils/constants.dart';
import 'package:fitness_app_ui/views/plan_view/widgets/week_detail_widget.dart';
import 'package:flutter/material.dart';

class PlanView extends StatefulWidget {
  const PlanView({super.key});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  final PageController _pageController = PageController();

  Map<int, Map<int, List<WorkoutTaskModel>>> weekData = {
    0: {
      0: [
        WorkoutTaskModel(
          id: '1',
          title: 'Arm Blaster',
          category: 'Arms Workout',
          duration: '25m - 30m',
          categoryColor: Palette.armsWorkoutColor,
          icon: AssetIcons.armDay,
        ),
      ],
      3: [
        WorkoutTaskModel(
          id: '2',
          title: 'Leg Day Blitz',
          category: 'Leg Workout',
          duration: '25m - 30m',
          categoryColor: Palette.legWorkoutColor,
          icon: AssetIcons.legDay,
        ),
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Training Calendar',
                    style: CustomFontStyle.regularText.copyWith(fontSize: 24),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: CustomFontStyle.boldText.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, weekIndex) {
                  return WeekDetailWidget(
                    weekIndex: weekIndex,
                    weekData: weekData,
                    onTaskMoved:
                        (sourceWeek, sourceDay, destWeek, destDay, task) {
                          setState(() {
                            weekData[sourceWeek]?[sourceDay]?.removeWhere(
                              (t) => t.id == task.id,
                            );

                            if (weekData[destWeek] == null) {
                              weekData[destWeek] = {};
                            }
                            if (weekData[destWeek]![destDay] == null) {
                              weekData[destWeek]![destDay] = [];
                            }
                            weekData[destWeek]![destDay]!.add(task);
                          });
                        },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
