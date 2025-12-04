import 'package:flutter/material.dart';
import '../NewGames/games/fortunewheel/lastresults.dart';
import '../NewGames/games/roulette2/roulette/home/roulette/text.dart';


Widget primaryButton({
  required BuildContext context,
  required String text,
  required VoidCallback? onTap,
  Color textColor = Colors.black,
  Color bgColor = kBlueColor,
  double textSize = 20, required TextStyle textStyle,
}) {
  return Container(
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(10),
        foregroundColor: WidgetStateProperty.all(Colors.transparent),

        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        // elevation: MaterialStateProperty.all(25),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CustomText(size: textSize, text: text, color: textColor),
            ),
          ),
        ],
      ),
    ),
  );
}