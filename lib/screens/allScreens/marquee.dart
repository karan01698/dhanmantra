import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MarqueeWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final double velocity;
  final double blankSpace;

  const MarqueeWidget({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.textColor = Colors.white,
    this.velocity = 50.0,
    this.blankSpace = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 25, // Adjust height based on font size
        child: Marquee(
          text: text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          scrollAxis: Axis.horizontal,
          blankSpace: blankSpace, // Space between repeated text
          velocity: velocity, // Speed of scrolling
          pauseAfterRound: const Duration(seconds: 1), // Pause before repeating
          startPadding: 10.0,
          accelerationDuration: const Duration(seconds: 1),
          accelerationCurve: Curves.linear,
          decelerationDuration: const Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        ),
      ),
    );
  }
}
