import 'package:fitness_app_ui/bottom_navbar_view.dart';
import 'package:fitness_app_ui/theme_data/palette.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: BottomNavbarView(),
    );
  }
}
