import 'dart:math';
import 'package:flutter/material.dart';

const Color kFortuneWheelYellowColor = Color(0xffFECD4C);
const Color kFortuneWheelBlueColor = Color(0xff05ADD1);
const Color kFortuneWheelRed = Color(0xffFF633B);

class ColorCircle extends StatelessWidget {
  const ColorCircle({super.key});

  // Function to generate a random color between red, blue, and yellow
  Color getRandomColor() {
    List<Color> colors = [
      kFortuneWheelRed,
      kFortuneWheelBlueColor,
      kFortuneWheelYellowColor,
    ];
    return colors[Random().nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0), // Space between circles
      child: Container(
        width: 12, // Adjusted size for the circle
        height: 12, // Adjusted size for the circle
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.white, // Light source effect at the center
              getRandomColor(), // Main color for the circle
            ],
            center: const Alignment(-0.3, -0.3),
            // Offset the light source towards the top left
            radius: 0.4, // Radius of the gradient
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              // Slight shadow to enhance 3D effect
              blurRadius: 2,
              // How much the shadow should be blurred
              offset: const Offset(1, 1), // Shadow position
            ),
          ],
        ),
      ),
    );
  }
}
