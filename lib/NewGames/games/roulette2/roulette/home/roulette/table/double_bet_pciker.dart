import 'dart:async';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../models/roulette_bet.dart';
import '../../../provider/myvariable.dart';
import '../../../provider/roulette_api.dart';
import '../../../text.dart';

class DoubleBetPicker extends StatefulWidget {
  final List<String> digitData;
  final Color color;
  final String betAmount;
  final String placedBedAmount;

  final String roundid;
  final String loginid;
  final bool betPlaced;

  const DoubleBetPicker(
      {super.key,
      required this.color,
      this.placedBedAmount = "0",
      this.betPlaced = false,
      required this.betAmount,
      required this.roundid,
      required this.loginid,
      required this.digitData});

  @override
  State<DoubleBetPicker> createState() => _DoubleBetPickerState();
}

class _DoubleBetPickerState extends State<DoubleBetPicker> {
  int coinAmount = 0;
  bool betPlaced = false;
  void toogleEnabled() {
    setState(() {
      isButtonEnabled = false;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      isButtonEnabled = true;
    });
  }

  bool isButtonEnabled = true;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    betPlaced = widget.betPlaced;
    // log("heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy ${widget.placedBedAmount}");
    coinAmount =
        widget.betPlaced ? num.parse(widget.placedBedAmount).round() : 0;
  }

  @override
  Widget build(BuildContext context) {
    final rouletteApi = Provider.of<RouletteApi>(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.0346,
        top: MediaQuery.of(context).size.height * 0.02,
        bottom: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Container(
        // color: Colors.white,
        child: GestureDetector(
          onLongPressEnd: (details) {
            timer.cancel();
          },
          onLongPressStart: (longPressStartDetails) {
            if (!Provider.of<MyVariableModel>(context, listen: false)
                .acceptBet) {
              timer = Timer.periodic(const Duration(milliseconds: 150),
                  (timer) async {
                List<RouletteBet> bets = [];

                for (var element in widget.digitData) {
                  bets.add(
                    RouletteBet(
                      amt: Provider.of<MyVariableModel>(context, listen: false)
                              .coinAmount /
                          widget.digitData.length,
                      digit: int.parse(element),
                    ),
                  );
                } // toogleEnabled();

                final bool doAction = rouletteApi.placeBetOnFrontEnd(
                  context,
                  bets: bets,
                );
                doAction
                    ? setState(() {
                        betPlaced = true;
                        coinAmount = (coinAmount +
                            int.parse(Provider.of<MyVariableModel>(context,
                                    listen: false)
                                .coinAmount
                                .toString()));

                        print(betPlaced);
                      })
                    : null;
              });
            }
          },
          onPanDown: isButtonEnabled
              ? (de) async {
                  List<RouletteBet> bets = [];

                  for (var element in widget.digitData) {
                    bets.add(
                      RouletteBet(
                        amt:
                            Provider.of<MyVariableModel>(context, listen: false)
                                    .coinAmount /
                                widget.digitData.length,
                        digit: int.parse(element),
                      ),
                    );
                  } // toogleEnabled();

                  final bool doAction = rouletteApi.placeBetOnFrontEnd(
                    context,
                    bets: bets,
                  );
                  // await placeBet(
                  //     context,
                  //     "Roulette",
                  //     Provider.of<MyVariableModel>(context, listen: false)
                  //         .coinAmount
                  //         .toString(),
                  //     "36",
                  //     widget.digitData,
                  //     widget.loginid,
                  //     coinAmount,
                  //     "Number");
                  doAction
                      ? setState(() {
                          betPlaced = true;
                          coinAmount = (coinAmount +
                              int.parse(Provider.of<MyVariableModel>(context,
                                      listen: false)
                                  .coinAmount
                                  .toString()));

                          print(betPlaced);
                        })
                      : null;
                }
              : null,
          child: betPlaced
              ? Transform.scale(
                  scale: 1,
                  child: Container(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.031,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              _getImagePath(coinAmount),
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: Center(
                        child: CustomText6(
                          text: coinAmount >= 1000
                              ? '${(coinAmount / 1000).toStringAsFixed(0)}k'
                              : coinAmount.toString(),
                          color: Colors.white,
                          size: 8,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              // Transform.scale(
              //     scale: 1,
              //     child: Container(
              //       height: MediaQuery.of(context).size.height * 0.04,
              //       width: MediaQuery.of(context).size.width * 0.031,
              //       decoration: const BoxDecoration(
              //         image: DecorationImage(
              //             image: AssetImage("images/coin_plate2.png")),
              //       ),
              //       child: Transform.scale(
              //         scale: 0.465,
              //         child: SizedBox(
              //           height: MediaQuery.of(context).size.height * 0.08,
              //           width: MediaQuery.of(context).size.width * 0.066,
              //           child: Center(
              //             child: CustomText6(
              //               height: 1.5,
              //               text: coinAmount <= 5000
              //                   ? coinAmount.toString()
              //                   : "5000",
              //               color: Colors.black,
              //               size: coinAmount.toString().length > 3 ? 11 : 16,
              //               weight: FontWeight.bold,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   )
              : Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.031,
                ),
        ),
      ),
    );
  }

  String _getImagePath(int coinAmount) {
    if (coinAmount <= 2) {
      return "images/10_coin_plate.png";
    } else if (coinAmount <= 5) {
      return "images/5000_coin_plate.png";
    } else if (coinAmount <= 10) {
      return "images/10_coin_plate.png";
    } else if (coinAmount <= 25) {
      return "images/25_coin_plate.png";
    } else if (coinAmount <= 50) {
      return "images/50_coin_plate.png";
    } else if (coinAmount <= 100) {
      return "images/100_coin_plate.png";
    } else if (coinAmount <= 500) {
      return "images/500_coin_plate.png";
    } else if (coinAmount <= 1000) {
      return "images/1000_coin_plate.png";
    } else {
      return "images/5000_coin_plate.png";
    }
  }
}
