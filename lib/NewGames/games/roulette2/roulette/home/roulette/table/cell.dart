import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import '../../../lists.dart';
import '../../../models/roulette_bet.dart';
import '../../../provider/myvariable.dart';
import '../../../provider/roulette_api.dart';
import '../../../text.dart';

class Cell extends StatefulWidget {
  final Color color;
  final String betAmount;
  final String roundid;
  final String loginid;
  final bool betPlaced;
  final String placedBedAmount;
  final List<String> text;

  const Cell(
    this.text, {
    super.key,
    this.betPlaced = false,
    this.placedBedAmount = "0",
    this.color = Colors.transparent,
    required this.betAmount,
    required this.roundid,
    required this.loginid,
  });

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> with SingleTickerProviderStateMixin {
  late Timer timer;
  int coinAmount = 0;
  bool isButtonEnabled = true;
  void toogleEnabled() {
    setState(() {
      isButtonEnabled = false;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      isButtonEnabled = true;
    });
  }

  @override
  void initState() {
    super.initState();

    betPlaced = widget.betPlaced;
    coinAmount =
        widget.betPlaced ? num.parse(widget.placedBedAmount).round() : 0;
  }

  late bool betPlaced;
  @override
  Widget build(BuildContext context) {
    final rouletteApi = Provider.of<RouletteApi>(context, listen: false);
    return rouletteApi.showDoubleZeroInTable == false &&
            (widget.text.contains("37") || widget.text.contains("38"))
        ? IgnorePointer(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.0656,
            ),
          )
        : widget.text.contains("100")
            ? IgnorePointer(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.0656,
                ),
              )
            : Container(
                color: Colors.transparent,
                child: GestureDetector(
                  onLongPressEnd: (details) {
                    timer.cancel();
                  },
                  onLongPressStart: (longPressStartDetails) {
                    // toogleEnabled();

                    if (!Provider.of<MyVariableModel>(context, listen: false)
                        .acceptBet) {
                      timer = Timer.periodic(const Duration(milliseconds: 150),
                          (timer) async {
                        bool doAction = false;
                        if (widget.text[0] == "Row1") {
                          List<RouletteBet> bets = [];

                          for (var element in row1Bet) {
                            bets.add(
                              RouletteBet(
                                amt: Provider.of<MyVariableModel>(context,
                                            listen: false)
                                        .coinAmount /
                                    row1Bet.length,
                                digit: int.parse(element),
                              ),
                            );
                          } // toogleEnabled();
                          doAction = rouletteApi.placeBetOnFrontEnd(
                            context,
                            bets: bets,
                          );
                        } else if (widget.text[0] == "Row2") {
                          List<RouletteBet> bets = [];

                          for (var element in row2Bet) {
                            bets.add(
                              RouletteBet(
                                amt: Provider.of<MyVariableModel>(context,
                                            listen: false)
                                        .coinAmount /
                                    row2Bet.length,
                                digit: int.parse(element),
                              ),
                            );
                          } // toogleEnabled();
                          doAction = rouletteApi.placeBetOnFrontEnd(
                            context,
                            bets: bets,
                          );
                        } else if (widget.text[0] == "Row3") {
                          List<RouletteBet> bets = [];

                          for (var element in row3Bet) {
                            bets.add(
                              RouletteBet(
                                amt: Provider.of<MyVariableModel>(context,
                                            listen: false)
                                        .coinAmount /
                                    row3Bet.length,
                                digit: int.parse(element),
                              ),
                            );
                          } // toogleEnabled();
                          doAction = rouletteApi.placeBetOnFrontEnd(
                            context,
                            bets: bets,
                          );
                        } else {
                          doAction = rouletteApi.placeBetOnFrontEnd(
                            context,
                            bets: [
                              RouletteBet(
                                amt: Provider.of<MyVariableModel>(context,
                                        listen: false)
                                    .coinAmount,
                                digit: int.parse(
                                  widget.text[0],
                                ),
                              ),
                            ],
                          );
                        }

                        doAction
                            ? setState(() {
                                betPlaced = true;
                                coinAmount = (coinAmount +
                                    int.parse(Provider.of<MyVariableModel>(
                                            context,
                                            listen: false)
                                        .coinAmount
                                        .toString()));

                                print(betPlaced);
                              })
                            : null;
                      });
                    } else {
                      timer.cancel();
                    }
                  },
                  onPanDown: isButtonEnabled
                      ? (de) async {
                          toogleEnabled();

                          Provider.of<MyVariableModel>(context, listen: false)
                              .updateBlink(true);
                          Provider.of<MyVariableModel>(context, listen: false)
                              .updateLastBetKey(widget.text[0]);

                          bool doAction = false;
                          if (widget.text[0] == "Row1") {
                            List<RouletteBet> bets = [];

                            for (var element in row1Bet) {
                              bets.add(
                                RouletteBet(
                                  amt: Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .coinAmount /
                                      row1Bet.length,
                                  digit: int.parse(element),
                                ),
                              );
                            } // toogleEnabled();
                            doAction = rouletteApi.placeBetOnFrontEnd(
                              context,
                              bets: bets,
                            );
                          } else if (widget.text[0] == "Row2") {
                            List<RouletteBet> bets = [];

                            for (var element in row2Bet) {
                              bets.add(
                                RouletteBet(
                                  amt: Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .coinAmount /
                                      row2Bet.length,
                                  digit: int.parse(element),
                                ),
                              );
                            } // toogleEnabled();
                            doAction = rouletteApi.placeBetOnFrontEnd(
                              context,
                              bets: bets,
                            );
                          } else if (widget.text[0] == "Row3") {
                            List<RouletteBet> bets = [];

                            for (var element in row3Bet) {
                              bets.add(
                                RouletteBet(
                                  amt: Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .coinAmount /
                                      row3Bet.length,
                                  digit: int.parse(element),
                                ),
                              );
                            } // toogleEnabled();
                            doAction = rouletteApi.placeBetOnFrontEnd(
                              context,
                              bets: bets,
                            );
                          } else {
                            doAction = rouletteApi.placeBetOnFrontEnd(
                              context,
                              bets: [
                                RouletteBet(
                                  amt: Provider.of<MyVariableModel>(context,
                                          listen: false)
                                      .coinAmount,
                                  digit: int.parse(
                                    widget.text[0],
                                  ),
                                ),
                              ],
                            );
                          }
                          if (doAction) {
                            setState(
                              () {
                                betPlaced = true;
                                coinAmount += int.parse(
                                  Provider.of<MyVariableModel>(context,
                                          listen: false)
                                      .coinAmount
                                      .toString(),
                                );
                              },
                            );
                          } else {
                            print('Action not performed');
                          }
                        }
                      : null,
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.0656,
                    child: betPlaced
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: widget.text.contains("37") ? 12 : 0,
                              bottom: widget.text.contains("38") ? 12 : 0,
                              left: widget.text.contains("37") ||
                                      widget.text.contains("38")
                                  ? 12
                                  : 0,
                              right: widget.text.contains("37") ||
                                      widget.text.contains("38")
                                  ? 12
                                  : 0,
                            ),
                            child: Transform.scale(
                              scale: widget.text.contains("37") ||
                                      widget.text.contains("38")
                                  ? 0.9
                                  : 0.465,
                              child: Container(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width:
                                      MediaQuery.of(context).size.width * 0.066,
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
                                      size: widget.text.contains("37") ||
                                              widget.text.contains("38")
                                          ? 9
                                          : 18,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
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
