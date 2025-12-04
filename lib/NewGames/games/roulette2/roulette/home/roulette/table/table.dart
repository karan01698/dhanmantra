import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import '../../../lists.dart';
import '../../../models/roulette_bet.dart';
import '../../../provider/myvariable.dart';
import '../../../provider/roulette_api.dart';
import '../../../text.dart';
import 'blink.dart';
import 'cell.dart';
import 'double_bet_pciker.dart';
import 'multiple_selector.dart';

class RouletteTable extends StatefulWidget {
  final bool showdoubleZero;
  final bool isPreviousBet;
  final String betAmount;
  final String roundid;
  final String loginid;

  const RouletteTable(
      {super.key,
      required this.roundid,
      required this.loginid,
      required this.betAmount,
      required this.isPreviousBet,
      required this.showdoubleZero});

  @override
  State<RouletteTable> createState() => _RouletteTableState();
}

class _RouletteTableState extends State<RouletteTable> {
  String getAmountFromDigit(List<PreviousBets> bets, String digitToFind) {
    Map<String, String> resultMap = {};
    for (var bet in bets) {
      if (bet.digit.contains(digitToFind)) {
        if (resultMap.containsKey(digitToFind)) {
          // Add the amount if the digit is already present in the result map
          int currentAmount = int.parse(resultMap[digitToFind]!);
          int newAmount = int.parse(bet.amount);
          resultMap[digitToFind] = (currentAmount + newAmount).toString();
        } else {
          // Set the amount for the digit if it's not present in the result map
          resultMap[digitToFind] = bet.amount;
        }
      }
    }
    log(resultMap.toString());
    return resultMap.toString();
  }

  bool isButtonEnabled = true;
  void toogleEnabled() {
    setState(() {
      isButtonEnabled = false;
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      isButtonEnabled = true;
    });
  }

  @override
  void initState() {
    if (Provider.of<MyVariableModel>(context, listen: false).getblocksData) {
      lastRow1 = Provider.of<MyVariableModel>(context, listen: false).lastRow1;
      lastRowAmount1 =
          Provider.of<MyVariableModel>(context, listen: false).lastRowAmount1;

      lastRow2 = Provider.of<MyVariableModel>(context, listen: false).lastRow2;
      lastRowAmount2 =
          Provider.of<MyVariableModel>(context, listen: false).lastRowAmount2;

      lastRow3 = Provider.of<MyVariableModel>(context, listen: false).lastRow3;
      lastRowAmount3 =
          Provider.of<MyVariableModel>(context, listen: false).lastRowAmount3;

      lastRow4 = Provider.of<MyVariableModel>(context, listen: false).lastRow4;
      lastRowAmount4 =
          Provider.of<MyVariableModel>(context, listen: false).lastRowAmount4;

      lastRow5 = Provider.of<MyVariableModel>(context, listen: false).lastRow5;
      lastRowAmount5 =
          Provider.of<MyVariableModel>(context, listen: false).lastRowAmount5;

      lastRow6 = Provider.of<MyVariableModel>(context, listen: false).lastRow6;
      lastRowAmount6 =
          Provider.of<MyVariableModel>(context, listen: false).lastRowAmount6;

      lastRow7 = Provider.of<MyVariableModel>(context, listen: false).lastRow7;
      lastRowAmount7 =
          Provider.of<MyVariableModel>(context, listen: false).lastRowAmount7;

      lastRow8 = Provider.of<MyVariableModel>(context, listen: false).lastRow8;
      lastRowAmount8 =
          Provider.of<MyVariableModel>(context, listen: false).lastRowAmount8;

      lastRow9 = Provider.of<MyVariableModel>(context, listen: false).lastRow9;
      lastRowAmount9 =
          Provider.of<MyVariableModel>(context, listen: false).lastRowAmount9;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MyVariableModel>(context, listen: false)
          .updateBlocksData(false);
    });

    super.initState();
  }

  bool lastRow1 = false;
  bool lastRow2 = false;
  bool lastRow3 = false;
  bool lastRow4 = false;
  bool lastRow5 = false;
  bool lastRow6 = false;
  bool lastRow7 = false;
  bool lastRow8 = false;
  bool lastRow9 = false;

  int lastRowAmount1 = 0;
  int lastRowAmount2 = 0;
  int lastRowAmount3 = 0;
  int lastRowAmount4 = 0;
  int lastRowAmount5 = 0;
  int lastRowAmount6 = 0;
  int lastRowAmount7 = 0;
  int lastRowAmount8 = 0;
  int lastRowAmount9 = 0;
  bool isNumberListInPreviousBets(
      List<String> numberList, List<PreviousBets> previousBets) {
    for (var number in numberList) {
      for (var bet in previousBets) {
        if (bet.digit == numberList) {
          return true;
        }
      }
    }
    return false;
  }

  Timer? longPressTimer;

  bool checkIfDigitsExist(
      List<String> digitsToCheck, List<PreviousBets> previousBets) {
    digitsToCheck.sort();

    String sortedDigits = digitsToCheck.toString();

    for (var bet in previousBets) {
      // Sort the digits in the current bet for comparison
      List<String> sortedBetDigits = List.from(bet.digit)..sort();

      // Convert the sorted bet digits list to a string for comparison
      String sortedBetDigitsString = sortedBetDigits.toString();

      // If the sorted digits match, return true
      if (sortedBetDigitsString == sortedDigits) {
        return true;
      }
    }

    // Return false if no match is found
    return false;
  }

  String getAmountForDigits(
      List<String> digitsToRetrieve, List<PreviousBets> previousBets) {
    // Sort the digits to ensure consistency for comparison
    digitsToRetrieve.sort();

    // Convert the sorted list to a string for comparison
    String sortedDigits = digitsToRetrieve.toString();

    // Iterate through previousBets and find the amount for the provided digits
    for (var bet in previousBets) {
      // Sort the digits in the current bet for comparison
      List<String> sortedBetDigits = List.from(bet.digit)..sort();

      // Convert the sorted bet digits list to a string for comparison
      String sortedBetDigitsString = sortedBetDigits.toString();

      // If the sorted digits match, return the amount associated with them
      if (sortedBetDigitsString == sortedDigits) {
        return bet.amount;
      }
    }

    // Return null if no matching digits are found
    return "no data";
  }

  String getPrevBetAmount(
      List<String> numberList, List<PreviousBets> previousBets) {
    for (var number in numberList) {
      for (var bet in previousBets) {
        if (bet.digit == numberList) {
          return bet.amount;
        }
      }
    }
    return "false";
  }

  @override
  Widget build(BuildContext context) {
    final rouletteApi = Provider.of<RouletteApi>(context, listen: false);

    //  Provider.of<MyVariableModel>(context, listen: false)
    //     .coinAmount
    //     .toString() = Provider.of<MyVariableModel>(context, listen: false)
    //     .coinAmount
    //     .toString();
    return Container(
      child: Center(
        child: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.037),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 4,
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Cell(
                          //   const ['00'],
                          //   betAmount: Provider.of<MyVariableModel>(context,
                          //           listen: false)
                          //       .coinAmount
                          //       .toString(),
                          //   betPlaced: checkIfDigitsExist(
                          //       ['00'],
                          //       Provider.of<MyVariableModel>(context,
                          //               listen: false)
                          //           .previousBets),
                          //   placedBedAmount: checkIfDigitsExist(
                          //           ['00'],
                          //           Provider.of<MyVariableModel>(context,
                          //                   listen: false)
                          //               .previousBets)
                          //       ? getAmountForDigits(
                          //           ['00'],
                          //           Provider.of<MyVariableModel>(context,
                          //                   listen: false)
                          //               .previousBets)
                          //       : "0",
                          //   key: Provider.of<MyVariableModel>(context,
                          //           listen: false)
                          //       .keys
                          //       .last
                          //       .key,
                          //   loginid: widget.loginid,
                          //   roundid: widget.roundid,
                          // ),
                          // // Cell(const ["100"],
                          // //     betAmount: Provider.of<MyVariableModel>(context,
                          // //             listen: false)
                          // //         .coinAmount
                          // //         .toString(),
                          // //     loginid: widget.loginid,
                          // //     roundid: widget.roundid),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          // Cell(const ["90"],
                          //     betAmount: Provider.of<MyVariableModel>(context,
                          //             listen: false)
                          //         .coinAmount
                          //         .toString(),
                          //     loginid: widget.loginid,
                          //     roundid: widget.roundid),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              for (int i = 0; i < 3; i++)
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.002,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      for (int j = i;
                                          j < numbers.length;
                                          j += 3)
                                        if (numbers[j].contains(Provider.of<
                                                        MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .tableBlinkValue
                                                .isNotEmpty
                                            ? Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .tableBlinkValue
                                            : "0")) // Check if the number is '15'
                                          Provider.of<MyVariableModel>(context,
                                                      listen: false)
                                                  .hideBlink
                                              ? Cell(
                                                  numbers[j],
                                                  betAmount: Provider.of<
                                                              MyVariableModel>(
                                                          context,
                                                          listen: false)
                                                      .coinAmount
                                                      .toString(),
                                                  betPlaced: checkIfDigitsExist(
                                                      numbers[j],
                                                      Provider.of<MyVariableModel>(
                                                              context,
                                                              listen: false)
                                                          .previousBets),
                                                  placedBedAmount: checkIfDigitsExist(
                                                          numbers[j],
                                                          Provider.of<MyVariableModel>(
                                                                  context,
                                                                  listen: false)
                                                              .previousBets)
                                                      ? getAmountForDigits(
                                                          numbers[j],
                                                          Provider.of<MyVariableModel>(
                                                                  context,
                                                                  listen: false)
                                                              .previousBets)
                                                      : "0",
                                                  key: Provider.of<
                                                              MyVariableModel>(
                                                          context,
                                                          listen: false)
                                                      .keys[j]
                                                      .key,
                                                  loginid: widget.loginid,
                                                  roundid: widget.roundid,
                                                )
                                              : Stack(
                                                  children: [
                                                    Cell(
                                                      numbers[j],
                                                      betAmount: Provider.of<
                                                                  MyVariableModel>(
                                                              context,
                                                              listen: false)
                                                          .coinAmount
                                                          .toString(),
                                                      betPlaced: checkIfDigitsExist(
                                                          numbers[j],
                                                          Provider.of<MyVariableModel>(
                                                                  context,
                                                                  listen: false)
                                                              .previousBets),
                                                      placedBedAmount: checkIfDigitsExist(
                                                              numbers[j],
                                                              Provider.of<MyVariableModel>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .previousBets)
                                                          ? getAmountForDigits(
                                                              numbers[j],
                                                              Provider.of<MyVariableModel>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .previousBets)
                                                          : "0",
                                                      key: Provider.of<
                                                                  MyVariableModel>(
                                                              context,
                                                              listen: false)
                                                          .keys[j]
                                                          .key,
                                                      loginid: widget.loginid,
                                                      roundid: widget.roundid,
                                                    ),
                                                    Provider.of<MyVariableModel>(
                                                                context,
                                                                listen: false)
                                                            .tableBlinkValue
                                                            .isNotEmpty
                                                        ? Provider.of<MyVariableModel>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .tableBlinkValue ==
                                                                "00"
                                                            ? Container()
                                                            : Provider.of<MyVariableModel>(context,
                                                                            listen:
                                                                                false)
                                                                        .tableBlinkValue ==
                                                                    "0"
                                                                ? Container()
                                                                : BlinkingCell(
                                                                    isZeroOrDoubleZero: Provider.of<MyVariableModel>(context, listen: false).tableBlinkValue ==
                                                                            "0" ||
                                                                        Provider.of<MyVariableModel>(context, listen: false).tableBlinkValue ==
                                                                            "00")
                                                        : Container(),
                                                  ],
                                                )
                                        else
                                          Cell(
                                            numbers[j],
                                            betAmount:
                                                Provider.of<MyVariableModel>(
                                                        context,
                                                        listen: false)
                                                    .coinAmount
                                                    .toString(),
                                            betPlaced: checkIfDigitsExist(
                                                numbers[j],
                                                Provider.of<MyVariableModel>(
                                                        context,
                                                        listen: false)
                                                    .previousBets),
                                            placedBedAmount: checkIfDigitsExist(
                                                    numbers[j],
                                                    Provider.of<MyVariableModel>(
                                                            context,
                                                            listen: false)
                                                        .previousBets)
                                                ? getAmountForDigits(
                                                    numbers[j],
                                                    Provider.of<MyVariableModel>(
                                                            context,
                                                            listen: false)
                                                        .previousBets)
                                                : "0",
                                            key: Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .keys[j]
                                                .key,
                                            loginid: widget.loginid,
                                            roundid: widget.roundid,
                                          ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              // top: MediaQuery.of(context).size.height * 0.024,
                              left: MediaQuery.of(context).size.width * 0.038,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                for (int i = 0; i < 3; i++)
                                  Row(
                                    children: <Widget>[
                                      for (int j = i;
                                          j < secondSetDoubleNumberBets.length;
                                          j += 3)
                                        DoubleBetPicker(
                                            betPlaced: checkIfDigitsExist(
                                                secondSetDoubleNumberBets[j],
                                                Provider.of<MyVariableModel>(context, listen: false)
                                                    .previousBets),
                                            placedBedAmount: checkIfDigitsExist(
                                                    secondSetDoubleNumberBets[
                                                        j],
                                                    Provider.of<MyVariableModel>(context,
                                                            listen: false)
                                                        .previousBets)
                                                ? getAmountForDigits(
                                                    secondSetDoubleNumberBets[
                                                        j],
                                                    Provider.of<MyVariableModel>(
                                                            context,
                                                            listen: false)
                                                        .previousBets,
                                                  )
                                                : "0",
                                            key: Provider.of<MyVariableModel>(context,
                                                    listen: false)
                                                .keys[numbers.length +
                                                    firstSetDoubleNumberBets
                                                        .length +
                                                    j]
                                                .key,
                                            digitData:
                                                secondSetDoubleNumberBets[j],
                                            // numbers[j],
                                            color: Colors.transparent,
                                            betAmount: Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .coinAmount
                                                .toString(),
                                            loginid: widget.loginid,
                                            roundid: widget.roundid),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.075),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onLongPressEnd: (details) {
                            // Cancel the timer when the long press is released
                            longPressTimer?.cancel();
                          },
                          onLongPress: () async {
                            longPressTimer?.cancel();
                            longPressTimer = Timer.periodic(
                                const Duration(milliseconds: 150), (timer) {
                              List<RouletteBet> bets = [];

                              for (var element in firstTwelveBet) {
                                bets.add(
                                  RouletteBet(
                                    amt: Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .coinAmount /
                                        firstTwelveBet.length,
                                    digit: int.parse(element),
                                  ),
                                );
                              } // toogleEnabled();
                              final bool doAction =
                                  rouletteApi.placeBetOnFrontEnd(
                                context,
                                bets: bets,
                              );
                              doAction
                                  ? setState(() {
                                      lastRow1 = true;

                                      lastRowAmount1 = (lastRowAmount1 +
                                          int.parse(
                                              Provider.of<MyVariableModel>(
                                                      context,
                                                      listen: false)
                                                  .coinAmount
                                                  .toString()));
                                      Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .updateLastRow1(true, lastRowAmount1);
                                    })
                                  : null;
                            });
                          },
                          onPanDown: isButtonEnabled
                              ? (de) async {
                                  toogleEnabled();
                                  // log("white");
                                  // final bool doAction = await placeBet(
                                  //     context,
                                  //     "Roulette",
                                  //     Provider.of<MyVariableModel>(context,
                                  //             listen: false)
                                  //         .coinAmount
                                  //         .toString(),
                                  //     "3",
                                  //     ["1st 12"],
                                  //     widget.loginid,
                                  //     lastRowAmount1,
                                  //     "Block");
                                  List<RouletteBet> bets = [];

                                  for (var element in firstTwelveBet) {
                                    bets.add(
                                      RouletteBet(
                                        amt: Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .coinAmount /
                                            firstTwelveBet.length,
                                        digit: int.parse(element),
                                      ),
                                    );
                                  } // toogleEnabled();

                                  final bool doAction =
                                      rouletteApi.placeBetOnFrontEnd(
                                    context,
                                    bets: bets,
                                  );

                                  doAction
                                      ? setState(() {
                                          lastRow1 = true;

                                          lastRowAmount1 = (lastRowAmount1 +
                                              int.parse(
                                                  Provider.of<MyVariableModel>(
                                                          context,
                                                          listen: false)
                                                      .coinAmount
                                                      .toString()));
                                          Provider.of<MyVariableModel>(context,
                                                  listen: false)
                                              .updateLastRow1(
                                                  true, lastRowAmount1);
                                        })
                                      : null;
                                }
                              : null,
                          child: Container(
                            height: MediaQuery.of(context).size.height *
                                (0.114 / 1.8),
                            width: MediaQuery.of(context).size.width *
                                (0.0654 * 4),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: lastRow1
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  _getImagePath(lastRowAmount1),
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Center(
                                            child: CustomText6(
                                              text: lastRowAmount1 >= 1000
                                                  ? '${(lastRowAmount1 / 1000).toStringAsFixed(0)}k'
                                                  : lastRowAmount1.toString(),
                                              color: Colors.white,
                                              size: 11,
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
                        GestureDetector(
                          onLongPressEnd: (details) {
                            // Cancel the timer when the long press is released
                            longPressTimer?.cancel();
                          },
                          onLongPress: () async {
                            longPressTimer?.cancel();
                            longPressTimer = Timer.periodic(
                                const Duration(milliseconds: 150), (timer) {
                              List<RouletteBet> bets = [];

                              for (var element in secondTwelveBet) {
                                bets.add(
                                  RouletteBet(
                                    amt: Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .coinAmount /
                                        secondTwelveBet.length,
                                    digit: int.parse(element),
                                  ),
                                );
                              } // toogleEnabled();
                              final bool doAction =
                                  rouletteApi.placeBetOnFrontEnd(
                                context,
                                bets: bets,
                              );
                              doAction
                                  ? setState(() {
                                      lastRow2 = true;

                                      lastRowAmount2 = (lastRowAmount2 +
                                          int.parse(
                                              Provider.of<MyVariableModel>(
                                                      context,
                                                      listen: false)
                                                  .coinAmount
                                                  .toString()));
                                      Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .updateLastRow2(true, lastRowAmount2);
                                    })
                                  : null;
                            });
                          },
                          onPanDown: isButtonEnabled
                              ? (sdd) async {
                                  toogleEnabled();
                                  // final bool doAction = await placeBet(
                                  //     context,
                                  //     "Roulette",
                                  //     Provider.of<MyVariableModel>(context,
                                  //             listen: false)
                                  //         .coinAmount
                                  //         .toString(),
                                  //     "3",
                                  //     ["2nd 12"],
                                  //     widget.loginid,
                                  //     lastRowAmount2,
                                  //     "Block");

                                  List<RouletteBet> bets = [];

                                  for (var element in secondTwelveBet) {
                                    bets.add(
                                      RouletteBet(
                                        amt: Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .coinAmount /
                                            secondTwelveBet.length,
                                        digit: int.parse(element),
                                      ),
                                    );
                                  } // toogleEnabled();

                                  final bool doAction =
                                      rouletteApi.placeBetOnFrontEnd(
                                    context,
                                    bets: bets,
                                  );
                                  doAction
                                      ? setState(() {
                                          lastRow2 = true;

                                          lastRowAmount2 = (lastRowAmount2 +
                                              int.parse(
                                                  Provider.of<MyVariableModel>(
                                                          context,
                                                          listen: false)
                                                      .coinAmount
                                                      .toString()));
                                          Provider.of<MyVariableModel>(context,
                                                  listen: false)
                                              .updateLastRow2(
                                                  true, lastRowAmount2);
                                        })
                                      : null;
                                }
                              : null,
                          child: Container(
                            height: MediaQuery.of(context).size.height *
                                (0.114 / 1.8),
                            width: MediaQuery.of(context).size.width *
                                (0.0654 * 4),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: lastRow2
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.0013),
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  _getImagePath(lastRowAmount2),
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Center(
                                            child: CustomText6(
                                              text: lastRowAmount2 >= 1000
                                                  ? '${(lastRowAmount2 / 1000).toStringAsFixed(0)}k'
                                                  : lastRowAmount2.toString(),
                                              color: Colors.white,
                                              size: 11,
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
                        GestureDetector(
                          onLongPressEnd: (details) {
                            // Cancel the timer when the long press is released
                            longPressTimer?.cancel();
                          },
                          onLongPress: () async {
                            longPressTimer?.cancel();
                            longPressTimer = Timer.periodic(
                                const Duration(milliseconds: 150), (timer) {
                              List<RouletteBet> bets = [];

                              for (var element in thirdTwelveBet) {
                                bets.add(
                                  RouletteBet(
                                    amt: Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .coinAmount /
                                        thirdTwelveBet.length,
                                    digit: int.parse(element),
                                  ),
                                );
                              } // toogleEnabled();
                              final bool doAction =
                                  rouletteApi.placeBetOnFrontEnd(
                                context,
                                bets: bets,
                              );
                              doAction
                                  ? setState(() {
                                      lastRow3 = true;

                                      lastRowAmount3 = (lastRowAmount3 +
                                          int.parse(
                                              Provider.of<MyVariableModel>(
                                                      context,
                                                      listen: false)
                                                  .coinAmount
                                                  .toString()));
                                      Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .updateLastRow3(true, lastRowAmount3);
                                    })
                                  : null;
                            });
                          },
                          onPanDown: isButtonEnabled
                              ? (ds) async {
                                  toogleEnabled();
                                  log("white");
                                  // final bool doAction = await placeBet(
                                  //     context,
                                  //     "Roulette",
                                  //     Provider.of<MyVariableModel>(context,
                                  //             listen: false)
                                  //         .coinAmount
                                  //         .toString(),
                                  //     "3",
                                  //     ["3rd 12"],
                                  //     widget.loginid,
                                  //     lastRowAmount3,
                                  //     "Block");

                                  List<RouletteBet> bets = [];

                                  for (var element in thirdTwelveBet) {
                                    bets.add(
                                      RouletteBet(
                                        amt: Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .coinAmount /
                                            thirdTwelveBet.length,
                                        digit: int.parse(element),
                                      ),
                                    );
                                  } // toogleEnabled();

                                  final bool doAction =
                                      rouletteApi.placeBetOnFrontEnd(
                                    context,
                                    bets: bets,
                                  );

                                  doAction
                                      ? setState(() {
                                          lastRow3 = true;

                                          lastRowAmount3 = (lastRowAmount3 +
                                              int.parse(
                                                  Provider.of<MyVariableModel>(
                                                          context,
                                                          listen: false)
                                                      .coinAmount
                                                      .toString()));
                                          Provider.of<MyVariableModel>(context,
                                                  listen: false)
                                              .updateLastRow3(
                                                  true, lastRowAmount3);
                                        })
                                      : null;
                                }
                              : null,
                          child: Container(
                            height: MediaQuery.of(context).size.height *
                                (0.114 / 1.8),
                            width: MediaQuery.of(context).size.width *
                                (0.0654 * 4),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: lastRow3
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.0035),
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  _getImagePath(lastRowAmount3),
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Center(
                                            child: CustomText6(
                                              text: lastRowAmount3 >= 1000
                                                  ? '${(lastRowAmount3 / 1000).toStringAsFixed(0)}k'
                                                  : lastRowAmount3.toString(),
                                              color: Colors.white,
                                              size: 11,
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.105),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onLongPressEnd: (details) {
                            // Cancel the timer when the long press is released
                            longPressTimer?.cancel();
                          },
                          onLongPress: () async {
                            longPressTimer?.cancel();

                            longPressTimer = Timer.periodic(
                                const Duration(milliseconds: 150), (timer) {
                              List<RouletteBet> bets = [];

                              for (var element in oneToEighteenBet) {
                                bets.add(
                                  RouletteBet(
                                    amt: Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .coinAmount /
                                        oneToEighteenBet.length,
                                    digit: int.parse(element),
                                  ),
                                );
                              } // toogleEnabled();
                              final bool doAction =
                                  rouletteApi.placeBetOnFrontEnd(
                                context,
                                bets: bets,
                              );
                              doAction
                                  ? setState(() {
                                      lastRow4 = true;

                                      lastRowAmount4 = (lastRowAmount4 +
                                          int.parse(
                                              Provider.of<MyVariableModel>(
                                                      context,
                                                      listen: false)
                                                  .coinAmount
                                                  .toString()));
                                      Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .updateLastRow4(true, lastRowAmount4);
                                    })
                                  : null;
                            });
                          },
                          onPanDown: isButtonEnabled
                              ? (ds) async {
                                  toogleEnabled();
                                  log("white");
                                  // final bool doAction = await placeBet(
                                  //     context,
                                  //     "Roulette",
                                  //     Provider.of<MyVariableModel>(context,
                                  //             listen: false)
                                  //         .coinAmount
                                  //         .toString(),
                                  //     "2",
                                  //     ["1 to 18"],
                                  //     widget.loginid,
                                  //     lastRowAmount4,
                                  //     "Block");

                                  List<RouletteBet> bets = [];

                                  for (var element in oneToEighteenBet) {
                                    bets.add(
                                      RouletteBet(
                                        amt: Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .coinAmount /
                                            oneToEighteenBet.length,
                                        digit: int.parse(element),
                                      ),
                                    );
                                  } // toogleEnabled();

                                  final bool doAction =
                                      rouletteApi.placeBetOnFrontEnd(
                                    context,
                                    bets: bets,
                                  );
                                  doAction
                                      ? setState(() {
                                          lastRow4 = true;

                                          lastRowAmount4 = (lastRowAmount4 +
                                              int.parse(
                                                  Provider.of<MyVariableModel>(
                                                          context,
                                                          listen: false)
                                                      .coinAmount
                                                      .toString()));
                                          Provider.of<MyVariableModel>(context,
                                                  listen: false)
                                              .updateLastRow4(
                                                  true, lastRowAmount4);
                                        })
                                      : null;
                                }
                              : null,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height *
                                (0.117 / 1.7),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: lastRow4
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  _getImagePath(lastRowAmount4),
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Center(
                                            child: CustomText6(
                                              text: lastRowAmount4 >= 1000
                                                  ? '${(lastRowAmount4 / 1000).toStringAsFixed(0)}k'
                                                  : lastRowAmount4.toString(),
                                              color: Colors.white,
                                              size: 11,
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
                        GestureDetector(
                          onLongPressEnd: (details) {
                            // Cancel the timer when the long press is released
                            longPressTimer?.cancel();
                          },
                          onLongPress: () async {
                            longPressTimer?.cancel();
                            longPressTimer = Timer.periodic(
                                const Duration(milliseconds: 150), (timer) {
                              List<RouletteBet> bets = [];

                              for (var element in evenBet) {
                                bets.add(
                                  RouletteBet(
                                    amt: Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .coinAmount /
                                        evenBet.length,
                                    digit: int.parse(element),
                                  ),
                                );
                              } // toogleEnabled();
                              final bool doAction =
                                  rouletteApi.placeBetOnFrontEnd(
                                context,
                                bets: bets,
                              );
                              doAction
                                  ? setState(() {
                                      lastRow5 = true;

                                      lastRowAmount5 = (lastRowAmount5 +
                                          int.parse(
                                              Provider.of<MyVariableModel>(
                                                      context,
                                                      listen: false)
                                                  .coinAmount
                                                  .toString()));
                                      Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .updateLastRow5(true, lastRowAmount5);
                                    })
                                  : null;
                            });
                          },
                          onPanDown: isButtonEnabled
                              ? (de) async {
                                  toogleEnabled();
                                  // final bool doAction = await placeBet(
                                  //     context,
                                  //     "Roulette",
                                  //     Provider.of<MyVariableModel>(context,
                                  //             listen: false)
                                  //         .coinAmount
                                  //         .toString(),
                                  //     "2",
                                  //     ["Even"],
                                  //     widget.loginid,
                                  //     lastRowAmount5,
                                  //     "Block");

                                  List<RouletteBet> bets = [];

                                  for (var element in evenBet) {
                                    bets.add(
                                      RouletteBet(
                                        amt: Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .coinAmount /
                                            evenBet.length,
                                        digit: int.parse(element),
                                      ),
                                    );
                                  } // toogleEnabled();

                                  final bool doAction =
                                      rouletteApi.placeBetOnFrontEnd(
                                    context,
                                    bets: bets,
                                  );
                                  doAction
                                      ? setState(() {
                                          lastRow5 = true;

                                          lastRowAmount5 = (lastRowAmount5 +
                                              int.parse(
                                                  Provider.of<MyVariableModel>(
                                                          context,
                                                          listen: false)
                                                      .coinAmount
                                                      .toString()));
                                          Provider.of<MyVariableModel>(context,
                                                  listen: false)
                                              .updateLastRow5(
                                                  true, lastRowAmount5);
                                        })
                                      : null;
                                }
                              : null,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height *
                                (0.117 / 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: lastRow5
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  _getImagePath(lastRowAmount5),
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Center(
                                            child: CustomText6(
                                              text: lastRowAmount5 >= 1000
                                                  ? '${(lastRowAmount5 / 1000).toStringAsFixed(0)}k'
                                                  : lastRowAmount5.toString(),
                                              color: Colors.white,
                                              size: 11,
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
                        GestureDetector(
                          onLongPressEnd: (details) {
                            // Cancel the timer when the long press is released
                            longPressTimer?.cancel();
                          },
                          onLongPress: () async {
                            longPressTimer?.cancel();
                            longPressTimer = Timer.periodic(
                                const Duration(milliseconds: 150), (timer) {
                              List<RouletteBet> bets = [];

                              for (var element in redBet) {
                                bets.add(
                                  RouletteBet(
                                    amt: Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .coinAmount /
                                        redBet.length,
                                    digit: int.parse(element),
                                  ),
                                );
                              } // toogleEnabled();
                              final bool doAction =
                                  rouletteApi.placeBetOnFrontEnd(
                                context,
                                bets: bets,
                              );
                              doAction
                                  ? setState(() {
                                      lastRow6 = true;

                                      lastRowAmount6 = (lastRowAmount6 +
                                          int.parse(
                                              Provider.of<MyVariableModel>(
                                                      context,
                                                      listen: false)
                                                  .coinAmount
                                                  .toString()));
                                      Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .updateLastRow5(true, lastRowAmount6);
                                    })
                                  : null;
                            });
                          },
                          onPanDown: isButtonEnabled
                              ? (sed) async {
                                  toogleEnabled();
                                  log("white");
                                  // final bool doAction = await placeBet(
                                  //     context,
                                  //     "Roulette",
                                  //     Provider.of<MyVariableModel>(context,
                                  //             listen: false)
                                  //         .coinAmount
                                  //         .toString(),
                                  //     "2",
                                  //     ["Red"],
                                  //     widget.loginid,
                                  //     lastRowAmount6,
                                  //     "Block");

                                  List<RouletteBet> bets = [];

                                  for (var element in redBet) {
                                    bets.add(
                                      RouletteBet(
                                        amt: Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .coinAmount /
                                            redBet.length,
                                        digit: int.parse(element),
                                      ),
                                    );
                                  } // toogleEnabled();

                                  final bool doAction =
                                      rouletteApi.placeBetOnFrontEnd(
                                    context,
                                    bets: bets,
                                  );
                                  doAction
                                      ? setState(() {
                                          lastRow6 = true;

                                          lastRowAmount6 = (lastRowAmount6 +
                                              int.parse(
                                                  Provider.of<MyVariableModel>(
                                                          context,
                                                          listen: false)
                                                      .coinAmount
                                                      .toString()));
                                          Provider.of<MyVariableModel>(context,
                                                  listen: false)
                                              .updateLastRow6(
                                                  true, lastRowAmount6);
                                        })
                                      : null;
                                }
                              : null,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height *
                                (0.117 / 2),
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: lastRow6
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      left: 0,
                                      // MediaQuery.of(context).size.width *
                                      //     0.015
                                    ),
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  _getImagePath(lastRowAmount6),
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Center(
                                            child: CustomText6(
                                              text: lastRowAmount6 >= 1000
                                                  ? '${(lastRowAmount6 / 1000).toStringAsFixed(0)}k'
                                                  : lastRowAmount6.toString(),
                                              color: Colors.white,
                                              size: 11,
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
                        GestureDetector(
                          onLongPressEnd: (details) {
                            // Cancel the timer when the long press is released
                            longPressTimer?.cancel();
                          },
                          onLongPress: () async {
                            longPressTimer?.cancel();
                            longPressTimer = Timer.periodic(
                                const Duration(milliseconds: 150), (timer) {
                              List<RouletteBet> bets = [];

                              for (var element in blackBet) {
                                bets.add(
                                  RouletteBet(
                                    amt: Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .coinAmount /
                                        blackBet.length,
                                    digit: int.parse(element),
                                  ),
                                );
                              } // toogleEnabled();
                              final bool doAction =
                                  rouletteApi.placeBetOnFrontEnd(
                                context,
                                bets: bets,
                              );
                              doAction
                                  ? setState(() {
                                      lastRow7 = true;

                                      lastRowAmount7 = (lastRowAmount7 +
                                          int.parse(
                                              Provider.of<MyVariableModel>(
                                                      context,
                                                      listen: false)
                                                  .coinAmount
                                                  .toString()));
                                      Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .updateLastRow7(true, lastRowAmount7);
                                    })
                                  : null;
                            });
                          },
                          onPanDown: isButtonEnabled
                              ? (rsgs) async {
                                  toogleEnabled();
                                  log("white");
                                  // final bool doAction = await placeBet(
                                  //     context,
                                  //     "Roulette",
                                  //     Provider.of<MyVariableModel>(context,
                                  //             listen: false)
                                  //         .coinAmount
                                  //         .toString(),
                                  //     "2",
                                  //     ["Black"],
                                  //     widget.loginid,
                                  //     lastRowAmount7,
                                  //     "Block");

                                  List<RouletteBet> bets = [];

                                  for (var element in blackBet) {
                                    bets.add(
                                      RouletteBet(
                                        amt: Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .coinAmount /
                                            blackBet.length,
                                        digit: int.parse(element),
                                      ),
                                    );
                                  } // toogleEnabled();

                                  final bool doAction =
                                      rouletteApi.placeBetOnFrontEnd(
                                    context,
                                    bets: bets,
                                  );
                                  doAction
                                      ? setState(() {
                                          lastRow7 = true;

                                          lastRowAmount7 = (lastRowAmount7 +
                                              int.parse(
                                                  Provider.of<MyVariableModel>(
                                                          context,
                                                          listen: false)
                                                      .coinAmount
                                                      .toString()));
                                          Provider.of<MyVariableModel>(context,
                                                  listen: false)
                                              .updateLastRow7(
                                                  true, lastRowAmount7);
                                        })
                                      : null;
                                }
                              : null,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height *
                                (0.117 / 2),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              // border: Border.all(color: Colors.transparentAccent),
                            ),
                            child: lastRow7
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.0075),
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  _getImagePath(lastRowAmount7),
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Center(
                                            child: CustomText6(
                                              text: lastRowAmount7 >= 1000
                                                  ? '${(lastRowAmount7 / 1000).toStringAsFixed(0)}k'
                                                  : lastRowAmount7.toString(),
                                              color: Colors.white,
                                              size: 11,
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
                        GestureDetector(
                          onLongPressEnd: (details) {
                            // Cancel the timer when the long press is released
                            longPressTimer?.cancel();
                          },
                          onLongPress: () async {
                            longPressTimer?.cancel();
                            longPressTimer = Timer.periodic(
                                const Duration(milliseconds: 150), (timer) {
                              List<RouletteBet> bets = [];

                              for (var element in oddBet) {
                                bets.add(
                                  RouletteBet(
                                    amt: Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .coinAmount /
                                        oddBet.length,
                                    digit: int.parse(element),
                                  ),
                                );
                              } // toogleEnabled();
                              final bool doAction =
                                  rouletteApi.placeBetOnFrontEnd(
                                context,
                                bets: bets,
                              );
                              doAction
                                  ? setState(() {
                                      lastRow8 = true;

                                      lastRowAmount8 = (lastRowAmount8 +
                                          int.parse(
                                              Provider.of<MyVariableModel>(
                                                      context,
                                                      listen: false)
                                                  .coinAmount
                                                  .toString()));
                                      Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .updateLastRow8(true, lastRowAmount8);
                                    })
                                  : null;
                            });
                          },
                          onPanDown: isButtonEnabled
                              ? (rsgrs) async {
                                  toogleEnabled();
                                  log("white");
                                  // final bool doAction = await placeBet(
                                  //     context,
                                  //     "Roulette",
                                  //     Provider.of<MyVariableModel>(context,
                                  //             listen: false)
                                  //         .coinAmount
                                  //         .toString(),
                                  //     "2",
                                  //     ["Odd"],
                                  //     widget.loginid,
                                  //     lastRowAmount8,
                                  //     "Block");
                                  List<RouletteBet> bets = [];

                                  for (var element in oddBet) {
                                    bets.add(
                                      RouletteBet(
                                        amt: Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .coinAmount /
                                            oddBet.length,
                                        digit: int.parse(element),
                                      ),
                                    );
                                  } // toogleEnabled();

                                  final bool doAction =
                                      rouletteApi.placeBetOnFrontEnd(
                                    context,
                                    bets: bets,
                                  );
                                  doAction
                                      ? setState(() {
                                          lastRow8 = true;

                                          lastRowAmount8 = (lastRowAmount8 +
                                              int.parse(
                                                  Provider.of<MyVariableModel>(
                                                          context,
                                                          listen: false)
                                                      .coinAmount
                                                      .toString()));
                                          Provider.of<MyVariableModel>(context,
                                                  listen: false)
                                              .updateLastRow8(
                                                  true, lastRowAmount8);
                                        })
                                      : null;
                                }
                              : null,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height *
                                (0.117 / 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: lastRow8
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  _getImagePath(lastRowAmount8),
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Center(
                                            child: CustomText6(
                                              text: lastRowAmount8 >= 1000
                                                  ? '${(lastRowAmount8 / 1000).toStringAsFixed(0)}k'
                                                  : lastRowAmount8.toString(),
                                              color: Colors.white,
                                              size: 11,
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
                        GestureDetector(
                          onLongPressEnd: (details) {
                            // Cancel the timer when the long press is released
                            longPressTimer?.cancel();
                          },
                          onLongPress: () async {
                            longPressTimer?.cancel();
                            longPressTimer = Timer.periodic(
                                const Duration(milliseconds: 150), (timer) {
                              List<RouletteBet> bets = [];

                              for (var element in nineteenToThirtySixBet) {
                                bets.add(
                                  RouletteBet(
                                    amt: Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .coinAmount /
                                        nineteenToThirtySixBet.length,
                                    digit: int.parse(element),
                                  ),
                                );
                              } // toogleEnabled();
                              final bool doAction =
                                  rouletteApi.placeBetOnFrontEnd(
                                context,
                                bets: bets,
                              );
                              doAction
                                  ? setState(() {
                                      lastRow9 = true;

                                      lastRowAmount9 = (lastRowAmount9 +
                                          int.parse(
                                              Provider.of<MyVariableModel>(
                                                      context,
                                                      listen: false)
                                                  .coinAmount
                                                  .toString()));
                                      Provider.of<MyVariableModel>(context,
                                              listen: false)
                                          .updateLastRow9(true, lastRowAmount9);
                                    })
                                  : null;
                            });
                          },
                          onPanDown: isButtonEnabled
                              ? (sdf) async {
                                  toogleEnabled();
                                  log("white");
                                  // final bool doAction = await placeBet(
                                  //     context,
                                  //     "Roulette",
                                  //     Provider.of<MyVariableModel>(context,
                                  //             listen: false)
                                  //         .coinAmount
                                  //         .toString(),
                                  //     "2",
                                  //     ["19 to 36"],
                                  //     widget.loginid,
                                  //     lastRowAmount9,
                                  //     "Block");
                                  List<RouletteBet> bets = [];

                                  for (var element in nineteenToThirtySixBet) {
                                    bets.add(
                                      RouletteBet(
                                        amt: Provider.of<MyVariableModel>(
                                                    context,
                                                    listen: false)
                                                .coinAmount /
                                            nineteenToThirtySixBet.length,
                                        digit: int.parse(element),
                                      ),
                                    );
                                  } // toogleEnabled();

                                  final bool doAction =
                                      rouletteApi.placeBetOnFrontEnd(
                                    context,
                                    bets: bets,
                                  );
                                  doAction
                                      ? setState(() {
                                          lastRow9 = true;

                                          lastRowAmount9 = (lastRowAmount9 +
                                              int.parse(
                                                  Provider.of<MyVariableModel>(
                                                          context,
                                                          listen: false)
                                                      .coinAmount
                                                      .toString()));
                                          Provider.of<MyVariableModel>(context,
                                                  listen: false)
                                              .updateLastRow9(
                                                  true, lastRowAmount9);
                                        })
                                      : null;
                                }
                              : null,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height *
                                (0.117 / 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: lastRow9
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.0075),
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  _getImagePath(lastRowAmount9),
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Center(
                                            child: CustomText6(
                                              text: lastRowAmount9 >= 1000
                                                  ? '${(lastRowAmount9 / 1000).toStringAsFixed(0)}k'
                                                  : lastRowAmount9.toString(),
                                              color: Colors.white,
                                              size: 11,
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
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.135,
                  left: MediaQuery.of(context).size.width * 0.121,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (int i = 0; i < 2; i++)
                      Row(
                        children: <Widget>[
                          for (int j = i; j < fourBetData.length; j += 2)
                            MultipleSelector(
                                betPlaced: checkIfDigitsExist(
                                    fourBetData[j],
                                    Provider.of<MyVariableModel>(context,
                                            listen: false)
                                        .previousBets),
                                placedBedAmount: checkIfDigitsExist(
                                        fourBetData[j],
                                        Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .previousBets)
                                    ? getAmountForDigits(
                                        fourBetData[j],
                                        Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .previousBets,
                                      )
                                    : "0",
                                key: Provider.of<MyVariableModel>(context,
                                        listen: false)
                                    .keys[numbers.length +
                                        firstSetDoubleNumberBets.length +
                                        secondSetDoubleNumberBets.length +
                                        j]
                                    .key,
                                dataList: fourBetData[j],
                                color: Colors.transparent,
                                betAmount: Provider.of<MyVariableModel>(context,
                                        listen: false)
                                    .coinAmount
                                    .toString(),
                                loginid: widget.loginid,
                                roundid: widget.roundid),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.135,
                    left: MediaQuery.of(context).size.width * 0.0868),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (int i = 0; i < 2; i++)
                      Row(
                        children: <Widget>[
                          for (int j = i;
                              j < firstSetDoubleNumberBets.length;
                              j += 2)
                            DoubleBetPicker(
                                betPlaced: checkIfDigitsExist(
                                    firstSetDoubleNumberBets[j],
                                    Provider.of<MyVariableModel>(context,
                                            listen: false)
                                        .previousBets),
                                placedBedAmount: checkIfDigitsExist(
                                        firstSetDoubleNumberBets[j],
                                        Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .previousBets)
                                    ? getAmountForDigits(
                                        firstSetDoubleNumberBets[j],
                                        Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .previousBets,
                                      )
                                    : "0",
                                key: Provider.of<MyVariableModel>(context,
                                        listen: false)
                                    .keys[numbers.length + j]
                                    .key,
                                digitData: firstSetDoubleNumberBets[j],
                                // numbers[j],
                                color: Colors.transparent,
                                betAmount: Provider.of<MyVariableModel>(context,
                                        listen: false)
                                    .coinAmount
                                    .toString(),
                                loginid: widget.loginid,
                                roundid: widget.roundid),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.21,
                    left: MediaQuery.of(context).size.width * 0.06),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: DoubleBetPicker(
                      betPlaced: checkIfDigitsExist(
                          zeroRangeBet[1],
                          Provider.of<MyVariableModel>(context, listen: false)
                              .previousBets),
                      placedBedAmount: checkIfDigitsExist(
                              zeroRangeBet[1],
                              Provider.of<MyVariableModel>(context,
                                      listen: false)
                                  .previousBets)
                          ? getAmountForDigits(
                              zeroRangeBet[1],
                              Provider.of<MyVariableModel>(context,
                                      listen: false)
                                  .previousBets,
                            )
                          : "0",
                      key: Provider.of<MyVariableModel>(context, listen: false)
                          .keys[numbers.length +
                              firstSetDoubleNumberBets.length +
                              secondSetDoubleNumberBets.length +
                              fourBetData.length +
                              streetBet.length +
                              sixLineBet.length +
                              1]
                          .key,
                      digitData: zeroRangeBet[1],

                      // numbers[j],
                      color: Colors.transparent,
                      betAmount:
                          Provider.of<MyVariableModel>(context, listen: false)
                              .coinAmount
                              .toString(),
                      loginid: widget.loginid,
                      roundid: widget.roundid),
                ),
              ),
              //TODO
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.13,
                    left: MediaQuery.of(context).size.width * 0.06),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: DoubleBetPicker(
                      betPlaced: checkIfDigitsExist(
                          zeroRangeBet[2],
                          Provider.of<MyVariableModel>(context, listen: false)
                              .previousBets),
                      placedBedAmount: checkIfDigitsExist(
                              zeroRangeBet[2],
                              Provider.of<MyVariableModel>(context,
                                      listen: false)
                                  .previousBets)
                          ? getAmountForDigits(
                              zeroRangeBet[2],
                              Provider.of<MyVariableModel>(context,
                                      listen: false)
                                  .previousBets,
                            )
                          : "0",
                      key: Provider.of<MyVariableModel>(context, listen: false)
                          .keys[numbers.length +
                              firstSetDoubleNumberBets.length +
                              secondSetDoubleNumberBets.length +
                              fourBetData.length +
                              streetBet.length +
                              sixLineBet.length +
                              2]
                          .key,
                      digitData: zeroRangeBet[2],

                      // numbers[j],
                      color: Colors.transparent,
                      betAmount:
                          Provider.of<MyVariableModel>(context, listen: false)
                              .coinAmount
                              .toString(),
                      loginid: widget.loginid,
                      roundid: widget.roundid),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                    left: MediaQuery.of(context).size.width * 0.06),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: DoubleBetPicker(
                      betPlaced: checkIfDigitsExist(
                          zeroRangeBet[0],
                          Provider.of<MyVariableModel>(context, listen: false)
                              .previousBets),
                      placedBedAmount: checkIfDigitsExist(
                              zeroRangeBet[0],
                              Provider.of<MyVariableModel>(context,
                                      listen: false)
                                  .previousBets)
                          ? getAmountForDigits(
                              zeroRangeBet[0],
                              Provider.of<MyVariableModel>(context,
                                      listen: false)
                                  .previousBets,
                            )
                          : "0",
                      key: Provider.of<MyVariableModel>(context, listen: false)
                          .keys[numbers.length +
                              firstSetDoubleNumberBets.length +
                              secondSetDoubleNumberBets.length +
                              fourBetData.length +
                              streetBet.length +
                              sixLineBet.length]
                          .key,
                      digitData: zeroRangeBet[0],

                      // numbers[j],
                      color: Colors.transparent,
                      betAmount:
                          Provider.of<MyVariableModel>(context, listen: false)
                              .coinAmount
                              .toString(),
                      loginid: widget.loginid,
                      roundid: widget.roundid),
                ),
              ),
              //zerodublezeromidishere
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.13,
                    left: MediaQuery.of(context).size.width * 0.024),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: DoubleBetPicker(
                      betPlaced: checkIfDigitsExist(
                          zeroRangeBet[3],
                          Provider.of<MyVariableModel>(context, listen: false)
                              .previousBets),
                      placedBedAmount: checkIfDigitsExist(
                              zeroRangeBet[3],
                              Provider.of<MyVariableModel>(context,
                                      listen: false)
                                  .previousBets)
                          ? getAmountForDigits(
                              zeroRangeBet[3],
                              Provider.of<MyVariableModel>(context,
                                      listen: false)
                                  .previousBets,
                            )
                          : "0",
                      key: Provider.of<MyVariableModel>(context, listen: false)
                          .keys[numbers.length +
                              firstSetDoubleNumberBets.length +
                              secondSetDoubleNumberBets.length +
                              fourBetData.length +
                              streetBet.length +
                              sixLineBet.length +
                              3]
                          .key,
                      digitData: zeroRangeBet[3],

                      // numbers[j],
                      color: Colors.transparent,
                      betAmount:
                          Provider.of<MyVariableModel>(context, listen: false)
                              .coinAmount
                              .toString(),
                      loginid: widget.loginid,
                      roundid: widget.roundid),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width * 0.088,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (int i = 0; i < 1; i++)
                      Row(
                        children: <Widget>[
                          for (int j = i; j < streetBet.length; j += 1)
                            DoubleBetPicker(
                                betPlaced: checkIfDigitsExist(
                                    streetBet[j],
                                    Provider.of<MyVariableModel>(context,
                                            listen: false)
                                        .previousBets),
                                placedBedAmount: checkIfDigitsExist(
                                        streetBet[j],
                                        Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .previousBets)
                                    ? getAmountForDigits(
                                        streetBet[j],
                                        Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .previousBets,
                                      )
                                    : "0",
                                key: Provider.of<MyVariableModel>(context,
                                        listen: false)
                                    .keys[numbers.length +
                                        firstSetDoubleNumberBets.length +
                                        secondSetDoubleNumberBets.length +
                                        fourBetData.length +
                                        j]
                                    .key,
                                digitData: streetBet[j],
                                // numbers[j],
                                color: Colors.transparent,
                                betAmount: Provider.of<MyVariableModel>(context,
                                        listen: false)
                                    .coinAmount
                                    .toString(),
                                loginid: widget.loginid,
                                roundid: widget.roundid),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width * 0.1195,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (int i = 0; i < 1; i++)
                      Row(
                        children: <Widget>[
                          for (int j = i; j < sixLineBet.length; j += 1)
                            DoubleBetPicker(
                                betPlaced: checkIfDigitsExist(
                                    sixLineBet[j],
                                    Provider.of<MyVariableModel>(context,
                                            listen: false)
                                        .previousBets),
                                placedBedAmount: checkIfDigitsExist(
                                        sixLineBet[j],
                                        Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .previousBets)
                                    ? getAmountForDigits(
                                        sixLineBet[j],
                                        Provider.of<MyVariableModel>(context,
                                                listen: false)
                                            .previousBets,
                                      )
                                    : "0",
                                key: Provider.of<MyVariableModel>(context,
                                        listen: false)
                                    .keys[numbers.length +
                                        firstSetDoubleNumberBets.length +
                                        secondSetDoubleNumberBets.length +
                                        fourBetData.length +
                                        streetBet.length +
                                        j]
                                    .key,
                                digitData: sixLineBet[j],
                                // numbers[j],
                                color: Colors.transparent,
                                betAmount: Provider.of<MyVariableModel>(context,
                                        listen: false)
                                    .coinAmount
                                    .toString(),
                                loginid: widget.loginid,
                                roundid: widget.roundid),
                        ],
                      ),
                  ],
                ),
              ),
              Provider.of<MyVariableModel>(context, listen: false).hideBlink
                  ? Container()
                  : Provider.of<MyVariableModel>(context, listen: false)
                          .tableBlinkValue
                          .isNotEmpty
                      ? Provider.of<MyVariableModel>(context, listen: false)
                                  .tableBlinkValue ==
                              "00"
                          ? Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height *
                                      0.246,
                                  right:
                                      MediaQuery.of(context).size.width * 0.89),
                              child: const BlinkingCell(
                                isZeroOrDoubleZero: true,
                              ),
                            )
                          : Container()
                      : Container(),
              Provider.of<MyVariableModel>(context, listen: false).hideBlink
                  ? Container()
                  : Provider.of<MyVariableModel>(context, listen: false)
                          .tableBlinkValue
                          .isNotEmpty
                      ? Provider.of<MyVariableModel>(context, listen: false)
                                  .tableBlinkValue ==
                              "0"
                          ? Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.02,
                                  right:
                                      MediaQuery.of(context).size.width * 0.89),
                              child: const BlinkingCell(
                                isZeroOrDoubleZero: true,
                              ),
                            )
                          : Container()
                      : Container()
            ],
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
