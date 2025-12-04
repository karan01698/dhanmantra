import 'dart:async';

import 'package:sattagames/NewGames/games/roulette2/roulette/home/roulette/wheel/wheel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import '../../../../../../screens/home/home_screen.dart';
import '../../provider/myvariable.dart';
import 'body.dart';


class RoulleteScreen extends StatefulWidget {
  final bool isEuropean;
  final bool showTimer;
  final bool comingFromSession;
  final String points;
  final String loginId;
  const RoulleteScreen(
      {super.key,
      required this.loginId,
      required this.points,
      required this.comingFromSession,
      required this.showTimer,
      required this.isEuropean});

  @override
  State<RoulleteScreen> createState() => _RoulleteScreenState();
}

class _RoulleteScreenState extends State<RoulleteScreen> {
  // updateTake() async {
  //   final amountData = await displayPrevRound(widget.loginId);
  //   final amount = amountData.isNotEmpty ? amountData[0].amount : "0";
  //   Provider.of<MyVariableModel>(context, listen: false)
  //       .updateWinAmount(amount, widget.loginId);
  // }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // Timer.periodic(const Duration(seconds: 10), (timer) {
    //   Provider.of<RouletteApi>(context, listen: false)
    //       .resetTotalBalance(widget.loginId);
    // });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  // @override
  // void initState() {
  //   final audioProvider = Provider.of<AudioProvider>(context, listen: false);

  //   audioProvider.startPlaying();
  //   // TODO: implement initState
  //   super.initState();
  // }

  bool spin = false;
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('images/roullete_Inner.png'), context);
    precacheImage(const AssetImage("images/arch2.png"), context);
    precacheImage(const AssetImage("images/plate.png"), context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (s, d) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen(
            email: widget.loginId,
          );
        }), (s) {
          return false;
        });
      },
      child: Stack(
        children: [
          Roulette(
            isEuropean: widget.isEuropean,
            showTimer: widget.showTimer,
            comingFromSession: widget.comingFromSession,
            points: widget.points,
            loginId: widget.loginId,
          ),
          Consumer<MyVariableModel>(
            builder: (context, myVariableModel, child) {
              return myVariableModel.hideWheel
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Transform.scale(
                        scale: 1.4,
                        child: IgnorePointer(
                          child: Hero(
                              tag: "Wheel",
                              child: MyWheel(
                                isEuropean: widget.isEuropean,
                                loginId: widget.loginId,
                                startTimer: widget.showTimer,
                                key: myVariableModel.wheelKey,
                                // isZoomed: true,
                              )),
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
