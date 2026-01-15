import 'dart:math' as math;

import 'package:fitness_app_ui/models/mood_data_model.dart';
import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:fitness_app_ui/utils/enums.dart';
import 'package:flutter/material.dart';

class MoodSelectorWidget extends StatefulWidget {
  final MoodType currentMood;
  final Function(MoodType) onMoodChanged;

  const MoodSelectorWidget({
    super.key,
    required this.currentMood,
    required this.onMoodChanged,
  });

  @override
  State<MoodSelectorWidget> createState() => _MoodSelectorWidgetState();
}

class _MoodSelectorWidgetState extends State<MoodSelectorWidget> {
  final GlobalKey _circleKey = GlobalKey();

  double _angle = math.pi / 180 * -45;
  MoodType? _currentMood;

  final Map<MoodType, MoodDataModel> _moodData = {
    MoodType.calm: MoodDataModel(
      label: 'Calm',
      emoji: 'assets/icons/calm.png',
      gradientColors: [const Color(0xFF80CBC4), const Color(0xFF4DD0E1)],
    ),
    MoodType.content: MoodDataModel(
      label: 'Content',
      emoji: 'assets/icons/content.png',
      gradientColors: [const Color(0xFF9FA8DA), const Color(0xFF7986CB)],
    ),
    MoodType.peaceful: MoodDataModel(
      label: 'Peaceful',
      emoji: 'assets/icons/peaceful.png',
      gradientColors: [const Color(0xFFF48FB1), const Color(0xFFCE93D8)],
    ),
    MoodType.happy: MoodDataModel(
      label: 'Happy',
      emoji: 'assets/icons/happy.png',
      gradientColors: [const Color(0xFFFFD54F), const Color(0xFFFFB74D)],
    ),
  };

  @override
  void initState() {
    // _currentMood = widget.currentMood;
    _updateMoodFromAngle();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onPanUpdate: _handlePanUpdate,
          child: SizedBox(
            key: _circleKey,
            width: 280,
            height: 280,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(280, 280),
                  painter: _MoodCirclePainter(),
                ),

                Image.asset(_moodData[_currentMood]!.emoji, width: 110),

                Transform.rotate(
                  angle: _angle,
                  child: Transform.translate(
                    offset: const Offset(115, 0),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            _moodData[_currentMood]!.label,
            textAlign: TextAlign.center,
            style: CustomFontStyle.regularText.copyWith(fontSize: 28),
          ),
        ),
      ],
    );
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    RenderBox? box =
        _circleKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    // Get the local position within the circle widget
    Offset localPosition = box.globalToLocal(details.globalPosition);

    // Get the center of the circle
    Offset center = Offset(box.size.width / 2, box.size.height / 2);

    // Calculate angle from center to touch point
    double dx = localPosition.dx - center.dx;
    double dy = localPosition.dy - center.dy;

    // Calculate angle using atan2
    double angle = math.atan2(dy, dx);

    setState(() {
      _angle = angle;
      _updateMoodFromAngle();
    });
  }

  void _updateMoodFromAngle() {
    // Normalize angle to 0-2π
    double normalizedAngle = _angle;
    if (normalizedAngle < 0) normalizedAngle += 2 * math.pi;

    // Convert angle to 0-360 degrees
    double degrees = normalizedAngle * 180 / math.pi;

    // Rotate 45 degrees anti-clockwise
    degrees = (degrees + 45) % 360;

    // Map angles to moods (rotated 45° anti-clockwise from original)
    if (degrees >= 315 || degrees < 45) {
      _currentMood = MoodType.calm; // Top-right diagonal - 315°/45°
      widget.onMoodChanged(_currentMood!);
    } else if (degrees >= 45 && degrees < 135) {
      _currentMood = MoodType.content; // Bottom-right diagonal - 90°
      widget.onMoodChanged(_currentMood!);
    } else if (degrees >= 135 && degrees < 225) {
      _currentMood = MoodType.peaceful; // Bottom-left diagonal - 180°
      widget.onMoodChanged(_currentMood!);
    } else {
      _currentMood = MoodType.happy; // Top-left diagonal - 270°
      widget.onMoodChanged(_currentMood!);
    }
  }
}

class _MoodCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.5;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final gradient = SweepGradient(
      colors: [
        const Color(0xFFC9BBEF),
        const Color(0xFFC9BBEF),
        const Color(0xFFF28DB3),
        const Color(0xFFF28DB3),
        const Color(0xFFF99955),
        const Color(0xFFF99955),
        const Color(0xFF6EB9AD),
        const Color(0xFF6EB9AD),
        const Color(0xFFC9BBEF),
      ],
      stops: const [0.02, 0.23, 0.26, 0.5, 0.52, 0.74, 0.77, 0.96, 1.0],
      startAngle: 0,
      endAngle: 2 * math.pi,
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;

    canvas.drawCircle(center, radius - 25.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
