import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerWidget extends StatefulWidget {
  final int durationInSeconds; // Duration in seconds (e.g., 60, 180, 300)
  final VoidCallback? onTimerComplete; // Callback when the timer reaches 0

  const TimerWidget({
    super.key,
    required this.durationInSeconds,
    this.onTimerComplete,
  });

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late int remainingTime; // Remaining time for the current lap

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      remainingTime = calculateRemainingTime();
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = calculateRemainingTime();

        if (remainingTime == 1) {
          if (widget.onTimerComplete != null) {
            widget.onTimerComplete!(); // Call the callback if provided
          }
        }
      });
    });
  }

  // Calculate the remaining time based on the current time and lap duration
  int calculateRemainingTime() {
    final now = DateTime.now();

    // Get the total number of seconds passed since the start of the hour
    final totalSecondsPassed = now.minute * 60 + now.second;

    // Calculate how many seconds have passed in the current lap
    final secondsPassedInCurrentLap =
        totalSecondsPassed % widget.durationInSeconds;

    // Calculate the remaining time by subtracting from the total duration
    return widget.durationInSeconds - secondsPassedInCurrentLap;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatTime(remainingTime),
      style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[200]),
    );
  }

  // Format remaining time as "mm:ss"
  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}
