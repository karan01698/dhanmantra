import 'dart:async';
import 'dart:math';
// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import 'package:provider/provider.dart';


import '../../../provider/audio.dart';
import '../../../provider/myvariable.dart';

import 'dart:developer' as dev;

import '../../../provider/roulette_api.dart';
import '../text.dart';

List<String> rouletteNumbers = [
  '0',
  '28',
  '9',
  '26',
  '30',
  '11',
  '7',
  '20',
  '32',
  '17',
  '5',
  '22',
  '34',
  '15',
  '3',
  '24',
  '36',
  '13',
  '1',
  '00',
  '27',
  '10',
  '25',
  '29',
  '12',
  '8',
  '19',
  '31',
  '18',
  '6',
  '21',
  '33',
  '16',
  '4',
  '23',
  '35',
  '14',
  '2'
];

void spinRoulette(
  BuildContext context,
) {
  late Timer timer;
  int currentIndex = 0; // Track the current index of rouletteNumbers

  const Duration interval = Duration(milliseconds: 20);
  const Duration duration = Duration(seconds: 5);
  bool reachedFinalPosition = false;

  timer = Timer.periodic(interval, (timer) async {
    // Get the next result from rouletteNumbers
    String nextResult = rouletteNumbers[currentIndex];

    Provider.of<RouletteApi>(context, listen: false)
        .updateBallPlace(nextResult);

    // Increment index or reset to 0 if end of list is reached
    currentIndex = (currentIndex + 1) % rouletteNumbers.length;

    await Future.delayed(duration);

    timer.cancel();
    // Cancel timer after 7 seconds
  });
}

StreamController<int> controller = StreamController<int>.broadcast();

class MyWheel extends StatefulWidget {
  final String loginId;
  final bool isEuropean;
  final bool startTimer;
  final String? number;
  final bool isZoomed;
  const MyWheel({
    super.key,
    this.isZoomed = false,
    this.number,
    required this.startTimer,
    required this.loginId,
    required this.isEuropean,
  });
  @override
  State<MyWheel> createState() => _MyWheelState();
}

class _MyWheelState extends State<MyWheel> {
  String key = UniqueKey().toString();

  bool spin = false;
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('images/roullete_Inner.png'), context);
    precacheImage(const AssetImage("images/arch2.png"), context);
    precacheImage(const AssetImage("images/plate.png"), context);
    // precacheImage(const AssetImage("images/heera.png"), context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.22,
            left: screenWidth * 0.013,
            bottom: widget.isZoomed ? screenHeight * 0.24 : screenHeight * 0.42,
          ),
          child: Material(
            color: Colors.transparent,
            child: Transform.scale(
              scale: widget.isZoomed ? 0.62 : 0.74,
              child: Ink.image(
                image: const AssetImage("images/arch2.png"),
                height: screenHeight * 0.67,
                width: screenWidth * 0.7,
                // height:
                //     widget.isZoomed ? screenHeight * 0.5 : screenHeight * 0.53,
                // width: screenWidth * 0.56,
              ),
            ),
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.005,
                bottom: widget.isZoomed ? 0 : screenHeight * 0.015),
            child: Material(
              color: Colors.transparent,
              child: FortuneWheelScreen(
                isEuropean: widget.isEuropean,
                loginId: widget.loginId,
                startTimer: widget.startTimer,
                isZoomed: widget.isZoomed,
                key: Key(key),
                number: widget.number,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom:
                widget.isZoomed ? screenHeight * 0.116 : screenHeight * 0.27,
            left: screenWidth * 0.004,
          ),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Ink.image(
                image: const AssetImage("images/center.png"),
                height: screenHeight * 0.04,
                // width: screenWidth * 0.027,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class FortuneWheelScreen extends StatefulWidget {
  final String loginId;
  final bool isEuropean;
  final bool startTimer;
  final String? number;
  final bool isZoomed;
  const FortuneWheelScreen({
    super.key,
    required this.isZoomed,
    this.number,
    required this.startTimer,
    required this.loginId,
    required this.isEuropean,
  });

  @override
  State<FortuneWheelScreen> createState() => _FortuneWheelScreenState();
}

class _FortuneWheelScreenState extends State<FortuneWheelScreen>
    with SingleTickerProviderStateMixin {
  // late Timer ballTimer;

  int _secondsRemaining = 30;
  String lastResult = "1";

  bool spinning = false;

  placeBallAtFirstView() async {
    lastResult = Provider.of<MyVariableModel>(context, listen: false)
                .tableBlinkValue ==
            "90"
        ? Provider.of<MyVariableModel>(context, listen: false)
            .lastResults
            .last
            .result
        : Provider.of<MyVariableModel>(context, listen: false).tableBlinkValue;
    setState(() {});
  }

  @override
  void initState() {
    lastResult =
        Provider.of<RouletteApi>(context, listen: false).lastWinningDigit;
    audioProvider = Provider.of<AudioProvider>(context, listen: false);
    super.initState();
    placeBallAtFirstView();
    _controller = AnimationController(
      lowerBound: 0.2,
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(milliseconds: 6500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Rotation animation completed
          setState(() {
            _isRotating = false;
          });
        }
      });
    widget.number == null ? startTimer() : rotateWheelNow();
  }

  rotateWheelNow() {
    if (Provider.of<MyVariableModel>(context, listen: false).winAmount == "0" ||
        Provider.of<MyVariableModel>(context, listen: false).winAmount == "") {
      Random random = Random();

      controller.add(random.nextInt(37));
      _startRotation();

      spinRoulette(
        context,
      );
    }
  }

  startTimer() {
    if (widget.startTimer) {
      _updateTimer();
    }

    // if (int.parse(
    //         Provider.of<MyVariableModel>(context, listen: false).winAmount) ==
    //     0) {
    //   Provider.of<MyVariableModel>(context, listen: false).wheelZoom
    //       ? Navigator.pop(context)
    //       : null;
    // }
  }

  getRoundId() {
    DateTime now = DateTime.now();
    DateTime nextMinute = now.add(const Duration(minutes: 1));
    nextMinute = nextMinute.subtract(Duration(seconds: nextMinute.second));

    // Removing seconds component from the DateTime
    DateTime nextMinuteWithoutSeconds = DateTime(
      nextMinute.year,
      nextMinute.month,
      nextMinute.day,
      nextMinute.hour,
      nextMinute.minute,
    );
    return nextMinuteWithoutSeconds.toString();
  }

  late AnimationController _controller;
  bool _isRotating = false;
  // final audioPlayer = AssetsAudioPlayer.withId("6");

  @override
  void dispose() {
    // audioProvider.stopPlaying();
    // widget.number == null ? _timer.cancel() : null;

    _controller.dispose();
    // timer?.cancel();
    // ballTimer.cancel();
    // _timer.cancel();
    // audioPlayer.dispose();
    timer.cancel();
    super.dispose();
  }

  late AudioProvider audioProvider;
  Future<void> playWheelAudio() async {
    audioProvider.playOneTimeAudio(context, "audio/wheel.mp3");
  }

  void _startRotation() {
    dev.log("method enters");
    playWheelAudio();
    setState(() {
      _isRotating = true;
    });
    _controller.forward(from: 0.0);
  }

  late Timer timer;

  bool reachedZero = false;
  void _updateTimer() {
    if (widget.startTimer) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (_secondsRemaining > 0) {
          setState(() {
            _secondsRemaining--;
          });
        }

        if (_secondsRemaining <= 0) {
          if (!reachedZero) {
            Provider.of<RouletteApi>(context, listen: false).spinRoulette(
                context, widget.loginId, widget.isEuropean ? 36 : 35);
            Random random = Random();

            controller.add(random.nextInt(37));
            _startRotation();

            spinRoulette(context);
            setState(() {
              reachedZero = true;
            });
            // controller.add(22);
            await Future.delayed(const Duration(seconds: 6));
            setState(() {
              _secondsRemaining = 30;
              reachedZero = false;
            });
          }
        }
        // if (_secondsRemaining <= 1) {
        //   Future.delayed(
        //     const Duration(seconds: 1),
        //     () async {
        //       if (Provider.of<MyVariableModel>(context, listen: false)
        //                   .winAmount ==
        //               "0" ||
        //           Provider.of<MyVariableModel>(context, listen: false)
        //                   .winAmount ==
        //               "") {
        //         Random random = Random();

        //         controller.add(random.nextInt(37));
        //         _startRotation();

        //         spinRoulette(random.nextInt(37).toString());
        //       }
        //     },
        //   );
        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('images/roullete_Inner.png'), context);
    precacheImage(const AssetImage("images/arch2.png"), context);
    precacheImage(const AssetImage("images/plate.png"), context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        bottom: widget.isZoomed ? screenHeight * 0.27 : screenHeight * 0.37,
        left: screenWidth * 0.1,
        right: screenWidth * 0.1,
        top: widget.isZoomed ? screenHeight * 0.16 : screenHeight * 0.07,
      ),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // Perspective
          ..rotateX(-0.67 * pi / 2), // Bending rotation
        alignment: Alignment.center,
        child: Ink.image(
          padding: EdgeInsets.all(screenWidth * 0.024),
          image: const AssetImage(
            "images/plate.png",
          ),
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FortuneWheel(
              animateFirst: false,
              rotationCount: rouletteNumbers.length * 24,
              curve: FortuneCurve.spin,
              duration: const Duration(seconds: 7),
              indicators: <FortuneIndicator>[
                FortuneIndicator(
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 5.0).animate(
                        _controller), // Change end value for more rotations
                    child: Container(
                      height: screenWidth * 0.11,
                      width: screenWidth * 0.11,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 231, 215, 215),
                          width: screenWidth * 0.003,
                        ),
                        image: const DecorationImage(
                          image: AssetImage('images/roullete_Inner.png'),
                        ),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
              hapticImpact: HapticImpact.none,
              selected: controller.stream,
              items: List.generate(
                rouletteNumbers.length,
                (index) => FortuneItem(
                  style: FortuneItemStyle(
                    color: rouletteNumbers[index] == "0" ||
                            rouletteNumbers[index] == "00"
                        ? const Color(0xff09ab0e)
                        : (index % 2 == 0
                            ? const Color(0xfffa0605)
                            : const Color(0xff0a030b)),
                    textAlign: TextAlign.end,
                    borderColor: const Color.fromARGB(255, 243, 229, 229),
                    borderWidth: screenWidth * 0.0015,
                  ),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: SizedBox(
                      height: screenHeight * 0.2,
                      child: Column(
                        // alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              CustomText5(
                                height: 0.5,
                                text: rouletteNumbers[index],
                                size: screenWidth * 0.01,
                                color: Colors.white,
                                weight: FontWeight.bold,
                              ),
                              Divider(
                                height: 7.5,
                                thickness: screenWidth * 0.002,
                                color: const Color.fromARGB(255, 231, 215, 215),
                              ),
                              Consumer<RouletteApi>(
                                  builder: (context, myVariableModel, child) {
                                return rouletteNumbers[index] ==
                                        myVariableModel.ballPlace
                                    ? Image.asset(
                                        "images/ball.png",
                                        height: 10,
                                        width: 10,
                                        fit: BoxFit.fill,
                                      )
                                    : Container();
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
