import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import '../../../../main.dart';
import '../../../backend/apis/methods.dart';
import '../fortunewheel.dart';
import '../lastresults/circle.dart';

class FortuneWheelWidget extends StatefulWidget {
  const FortuneWheelWidget({super.key});

  @override
  _FortuneWheelWidgetState createState() => _FortuneWheelWidgetState();
}

class _FortuneWheelWidgetState extends State<FortuneWheelWidget>
    with SingleTickerProviderStateMixin {
  int _timerSeconds = 20;
  Timer? _timer;
  bool isLoading = false;
  final StreamController<int> controller = StreamController<int>();

  final List<FortuneItem> items = [
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelBlueColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelYellowColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelBlueColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelYellowColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelBlueColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelRed),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelYellowColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelBlueColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelYellowColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelBlueColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelYellowColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelBlueColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelYellowColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelBlueColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelYellowColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelRed),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelBlueColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelYellowColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelBlueColor),
    ),
    FortuneItem(
      child: Container(),
      style: const FortuneItemStyle(color: kFortuneWheelYellowColor),
    ),
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void playWinSound() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('audio/target_wheel.mp3'));

    Future.delayed(const Duration(seconds: 3), () {
      audioPlayer.stop();
      audioPlayer.dispose();
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 3) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        getWheelResultAndSpin();
        setState(() {
          _timerSeconds = 20;
          fortuneWheelBets.clear();
        });
      }
    });
  }

  void getWheelResultAndSpin() async {
    try {
      setState(() {
        isLoading = true;
      });

      String result = await AppServices.getWheelResult();

      int spinIndex = getIndexForColor(result);
      playWinSound();
      controller.add(spinIndex);

      if (kDebugMode) {
        logPrint("API Result: $result, Spinning to index: $spinIndex");
      }

      // Show the result in a dialog box after the spin
      Future.delayed(const Duration(seconds: 3), () {
        showResultDialog(result);
      });
    } catch (e) {
      controller.add(0); // Default spin position in case of error
      Future.delayed(const Duration(seconds: 3), () {
        showResultDialog("Blue");
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.6)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "🎉 Congratulations! 🎉",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  "The result is:",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: getColorByName(result),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    result.toUpperCase(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int getIndexForColor(String color) {
    List<int> colorIndices = [];
    Color targetColor = getColorByName(color);

    for (int i = 0; i < items.length; i++) {
      if (items[i].style!.color == targetColor) {
        colorIndices.add(i);
      }
    }

    return colorIndices.isNotEmpty
        ? colorIndices[Random().nextInt(colorIndices.length)]
        : 0;
  }

  Color getColorByName(String colorName) {
    switch (colorName.toLowerCase()) {
      case "red":
        return kFortuneWheelRed;
      case "blue":
        return kFortuneWheelBlueColor;
      case "yellow":
        return kFortuneWheelYellowColor;
      default:
        return Colors.transparent;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: const Duration(milliseconds: 300),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/fortune-wheel/wheel.png"),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: FortuneWheel(
                        selected: controller.stream,
                        animateFirst: false,
                        indicators: [],
                        duration: const Duration(seconds: 3),
                        items: items,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.scale(
                        scale: 0.4,
                        child: Image.asset("images/fortune-wheel/timer.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Center(
                          child: Text(
                            isLoading ? "..." : _timerSeconds.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
