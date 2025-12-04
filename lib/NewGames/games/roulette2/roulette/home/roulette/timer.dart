import 'dart:async';
import 'package:sattagames/NewGames/games/roulette2/roulette/home/roulette/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/audio.dart';
import '../../provider/myvariable.dart';
import '../../provider/roulette_api.dart';


class RouletteTimer extends StatefulWidget {
  final bool isEuropean;
  final bool isTarget;
  final String loginId;
  const RouletteTimer(
      {super.key,
      required this.loginId,
      this.isTarget = false,
      required this.isEuropean});

  @override
  State<RouletteTimer> createState() => RouletteTimerState();
}

class RouletteTimerState extends State<RouletteTimer>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Timer _timer;
  // late Timer secondsTimer;
  late AudioProvider audioProvider;
  int _secondsRemaining = 30;

  // final audioPlayer = AudioManager.getInstance();

  @override
  void initState() {
    super.initState();
    audioProvider = Provider.of<AudioProvider>(context, listen: false);
    audioProvider.startPlaying();
    WidgetsBinding.instance.addObserver(this);

    // audioProvider.startPlaying();
    _updateTimer();
  }

  // Future<void> playTimerAudio() async {
  //   try {
  //     secondsTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
  //       await audioPlayer.stop();
  //       await audioPlayer.open(Audio("assets/audio/second.mp3"));
  //     });
  //   } catch (e) {
  //     logPrint("Error playing audio: $e");
  //   }
  // }

  Future<void> playWinSound() async {
    // await audioPlayer.open(
    //   Audio("assets/audio/win.mp3"),
    // );
  }

  Future<void> playLooseSound() async {
    // await audioPlayer.open(
    //   Audio("assets/audio/loose.mp3"),
    // );
  }

  bool reachedZero = false;

  void stopAudio() {
    // audioPlayer.stop();
  }

  void _updateTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      }

      if (_secondsRemaining <= 0) {
        if (!reachedZero) {
          // Provider.of<RouletteApi>(context, listen: false).spinRoulette(
          //     context, widget.loginId, widget.isEuropean ? 36 : 35);
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
      if (int.parse(
              Provider.of<MyVariableModel>(context, listen: false).winAmount) !=
          0) {
        Provider.of<MyVariableModel>(context, listen: false).updateBlink(false);
      }
      if (_secondsRemaining == 60) {
        setState(() {
          reachedZero = int.parse(
                      Provider.of<MyVariableModel>(context, listen: false)
                          .winAmount) !=
                  0
              ? true
              : false;
        });
      }

      if (_secondsRemaining >= 10 && _secondsRemaining <= 51) {
        if (int.parse(Provider.of<MyVariableModel>(context, listen: false)
                .winAmount) ==
            0) {
          Provider.of<MyVariableModel>(context, listen: false)
              .stopUpdatingInvestedAmount(true);
        }
      } else {
        Provider.of<MyVariableModel>(context, listen: false)
            .stopUpdatingInvestedAmount(false);
      }

      if (_secondsRemaining == 54) {
        // // String winAmount =
        // //     await getWiningAmountPending(context, "Roulette", widget.loginId);
        // Provider.of<MyVariableModel>(context, listen: false)
        //     .updateWinAmount(winAmount, widget.loginId);
        // int.parse(winAmount) == 0 ? playLooseSound() : playWinSound();
      }
      if (_secondsRemaining == 10) {
        Provider.of<MyVariableModel>(context, listen: false)
            .updateInsuff(false);
        Provider.of<MyVariableModel>(context, listen: false).updateBlink(true);
        Provider.of<MyVariableModel>(context, listen: false).placedBets.isEmpty
            ? Provider.of<MyVariableModel>(context, listen: false)
                .emptyBets
                .add(true)
            : Provider.of<MyVariableModel>(context, listen: false)
                .emptyBets
                .clear();
      }
      if (_secondsRemaining >= 10 && _secondsRemaining <= 15) {
        Provider.of<MyVariableModel>(context, listen: false)
            .updateBlinkValue(true);
      } else {
        Provider.of<MyVariableModel>(context, listen: false)
            .updateBlinkValue(false);
      }
      if (_secondsRemaining == 52) {
        Provider.of<MyVariableModel>(context, listen: false)
            .updateAmusement(false);

        if (int.parse(Provider.of<MyVariableModel>(context, listen: false)
                .winAmount) ==
            0) {
          Provider.of<MyVariableModel>(context, listen: false).updateAllKeys();
          Provider.of<MyVariableModel>(context, listen: false)
              .updateScaffoldKey();
          Provider.of<RouletteApi>(context, listen: false).resetBet();
          Provider.of<MyVariableModel>(context, listen: false).clearPrevBet();

          Provider.of<MyVariableModel>(context, listen: false)
              .convertPlacedBetsToPreviousBet();
          Provider.of<MyVariableModel>(context, listen: false)
              .placedBets
              .clear();
        }

        Provider.of<MyVariableModel>(context, listen: false).updateTextKey();

        await Provider.of<MyVariableModel>(context, listen: false)
            .updateLastResults();
        Provider.of<MyVariableModel>(context, listen: false).updateBlink(false);

        Provider.of<MyVariableModel>(context, listen: false)
            .updateWheelVisiblity(false);
      }
      if (_secondsRemaining == 6) {
        if (!Provider.of<MyVariableModel>(context, listen: false).acceptBet) {
          Provider.of<MyVariableModel>(context, listen: false)
              .updateBetStatus(true, gameName: "Roulette");
          await Future.delayed(
            const Duration(seconds: 2),
          );
          // newBetsApi(context, userId: widget.loginId);
        }
      }
      if (_secondsRemaining <= 6) {
        Provider.of<MyVariableModel>(context, listen: false)
            .updateBetStatus(true, gameName: "Roulette");
      } else {
        Provider.of<MyVariableModel>(context, listen: false).updateBetStatus(
            Provider.of<MyVariableModel>(context, listen: false).acceptBet,
            gameName: "Roulette");
      }
      if (_secondsRemaining > 6 && _secondsRemaining < 52) {
        Provider.of<MyVariableModel>(context, listen: false)
            .updateAmusement(false);
        if (Provider.of<MyVariableModel>(context, listen: false)
            .placedBets
            .isEmpty) {
          Provider.of<MyVariableModel>(context, listen: false)
              .updateBetStatus(false, gameName: "Roulette");
        }
      }
    });
  }

  @override
  void dispose() async {
    // log("calling dispose");
    audioProvider.stopPlaying();
    WidgetsBinding.instance.removeObserver(this);

    _timer.cancel();
    // secondsTimer.cancel();
    // await Future.delayed(
    //     const Duration(milliseconds: 500)); // Adjust the delay accordingly
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // log("changing state");
    // log(state.toString());
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.inactive) {
      // log("yes it is paused");
      audioProvider.stopPlaying();
      // App is in the background, cancel the timer
    } else if (state == AppLifecycleState.resumed) {
      audioProvider.startPlaying();

      // App is in the foreground, restart the timer
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Align(
      key: _scaffoldKey,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.03, top: 4),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.17,
          child: Center(
            child: CustomText9(
              color: widget.isTarget ? Colors.brown.shade800 : Colors.white,
              size: height * 0.037,
              weight: widget.isTarget ? FontWeight.w900 : FontWeight.normal,
              text: reachedZero
                  ? int.parse(Provider.of<MyVariableModel>(context,
                                  listen: false)
                              .winAmount) !=
                          0
                      ? "0  :  0"
                      : _secondsRemaining == 60
                          ? "00   :   00"
                          : "0  :  ${_secondsRemaining.toString().padLeft(2, "0")}"
                  : _secondsRemaining == 60
                      ? "00   :   00"
                      : "0  :  ${_secondsRemaining.toString().padLeft(2, "0")}",
            ),
          ),
        ),
      ),
    );
  }
}
