import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const ButtonWidget({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: CustomFontStyle.boldText.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
