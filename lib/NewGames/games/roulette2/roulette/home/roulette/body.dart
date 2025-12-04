// ignore_for_file: use_build_context_synchronously

import 'dart:async';
// import 'dart:developer';
import 'dart:math';
import 'package:sattagames/NewGames/games/roulette2/roulette/home/roulette/table/blink.dart';
import 'package:sattagames/NewGames/games/roulette2/roulette/home/roulette/table/table.dart';
import 'package:sattagames/NewGames/games/roulette2/roulette/home/roulette/text.dart';
import 'package:sattagames/NewGames/games/roulette2/roulette/home/roulette/timer.dart';
import 'package:sattagames/NewGames/games/roulette2/roulette/home/roulette/wheel/wheel.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/balance.dart';
import '../../provider/audio.dart';
import '../../provider/myvariable.dart';
import '../../provider/roulette_api.dart';
import 'coin_picker.dart';


class TotalAmountAndDigits {
  final int totalAmount;
  final List<String> uniqueDigitsList;

  TotalAmountAndDigits(this.totalAmount, this.uniqueDigitsList);
}

class Roulette extends StatefulWidget {
  final bool isEuropean;
  final bool showTimer;
  final bool comingFromSession;
  final String points;
  final String loginId;
  const Roulette(
      {super.key,
      required this.loginId,
      required this.points,
      required this.comingFromSession,
      required this.showTimer,
      required this.isEuropean});

  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  update() {
    setState(() {
      comingFromSession = widget.comingFromSession;
    });
  }

  @override
  void initState() {
    update();
    // Future.delayed(Duration.zero, () {
    //   showDialog(
    //       barrierDismissible: false,
    //       context: context,
    //       builder: (context) {
    //         return PopScope(
    //           onPopInvoked: (pop) {
    //             Navigator.pushAndRemoveUntil(
    //                 context,
    //                 PageRouteBuilder(
    //                   pageBuilder: (context, animation1, animation2) => Home(
    //                     loginId: widget.loginId,
    //                     points: widget.points,
    //                   ),
    //                   transitionDuration: Duration.zero,
    //                   reverseTransitionDuration: Duration.zero,
    //                 ),
    //                 (route) => false);
    //           },
    //           canPop: false,
    //           child: AlertDialog(
    //             shape: const RoundedRectangleBorder(),
    //             content: const SizedBox(
    //                 height: 200,
    //                 child: Center(
    //                   child: CustomText(
    //                     text: "Server not connected",
    //                   ),
    //                 )),
    //             backgroundColor: const Color(0xff1b0706).withOpacity(0.9),
    //           ),
    //         );
    //       });
    // });

    _startBlinking();
    // checkBet();
    // checkBetInit();

    bg = Image.asset(
      "images/fungame3.jpg",
      fit: BoxFit.fill,
      cacheHeight: 100,
      cacheWidth: 100,
    );
    bgImage = Image.asset(
      "images/fungame3.jpg",
      fit: BoxFit.fill,
    );
    bgImage1 = Image.asset(
      "images/roulette_blink.png",
      fit: BoxFit.fill,
    );

    // Provider.of<MyVariableModel>(context, listen: false).emptyBets.clear();

    Provider.of<MyVariableModel>(context, listen: false).updateLastResults();

    super.initState();
  }

  double opacityLevel = 1.0;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(bgImage.image, context);
    precacheImage(bgImage1.image, context);
    precacheImage(bg.image, context);
  }

  void _startBlinking() {
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        opacityLevel = opacityLevel == 1.0 ? 0.0 : 1.0;
      });
    });
  }

  // final audioPlayer = AssetsAudioPlayer.withId("4");

  // Future<void> playAudio() async {
  //   audioPlayer.open(
  //     Audio("assets/audio/coin_selector.mp3"),
  //   );
  // }

  bool comingFromSession = false;

  bool showInvested = true;

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
    // audioPlayer.dispose();
  }

  checkBet() async {
    Provider.of<AudioProvider>(context, listen: false).stopPlaying();

    if (!Provider.of<MyVariableModel>(context, listen: false).acceptBet) {
      cancelPlacedBet();
    } else {
      // final profileData = await MoneyStarMethods().getProfile(widget.loginId);
      Navigator.pop(context);
    }
  }

  checkBetInit() async {
    if (!Provider.of<MyVariableModel>(context, listen: false).acceptBet) {
      Provider.of<RouletteApi>(context, listen: false).resetBet();
      // await cancelBet("Roulette", widget.loginId);
      Provider.of<MyVariableModel>(context, listen: false).updateAllKeys();
      Provider.of<MyVariableModel>(context, listen: false).updateScaffoldKey();
      Provider.of<MyVariableModel>(context, listen: false).placedBets.clear();
      Provider.of<MyVariableModel>(context, listen: false).previousBets.clear();
    }
  }

  late Image bgImage;
  late Image bgImage1;
  late Image bg;

  Stream<List<Balance>> pointsStream() async* {
    while (true) {
      await Future.delayed(Duration.zero);
      // yield await getPoints(loginid: widget.loginId);
    }
  }

  bool isTapEnabled = true;
  bool isPrevEnabled = true;

  List<String> redNumbers = [
    '1',
    '3',
    '5',
    '9',
    '7',
    '12',
    '14',
    '18',
    '16',
    '21',
    '19',
    '23',
    '27',
    '25',
    '30',
    '32',
    '34',
    '36'
  ];
  playAudio() {
    Provider.of<AudioProvider>(context, listen: false)
        .playOneTimeAudioWithoutStopping("audio/coin_selector.mp3");
  }

  cancelPlacedBet() async {
    Provider.of<RouletteApi>(context, listen: false).resetBet();
    Provider.of<MyVariableModel>(context, listen: false).updateAllKeys();
    Provider.of<MyVariableModel>(context, listen: false).updateScaffoldKey();
    Provider.of<MyVariableModel>(context, listen: false).placedBets.clear();
    Provider.of<MyVariableModel>(context, listen: false).previousBets.clear();
    // final profileData = await MoneyStarMethods().getProfile(widget.loginId);
    Navigator.pop(context);
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    //   return HomePage(phoneNumber: widget.loginId, profileData: profileData[0]);
    // }), (route) => false);
  }

  bool wheelSwitch = true;
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

  TotalAmountAndDigits calculateTotalAmountAndDigits(
      List<PreviousBets> previousBets) {
    int totalAmount = 0;
    Set<String> allDigits = {};

    // Iterate through previousBets to calculate total amount and collect all unique digits
    for (var bet in previousBets) {
      totalAmount += num.parse(bet.amount).round();
      allDigits.addAll(bet.digit);
    }

    // Convert the set of digits back to a list for consistent return type
    List<String> uniqueDigitsList = allDigits.toList();

    return TotalAmountAndDigits(totalAmount, uniqueDigitsList);
  }
  // String winAmount = "0";

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('images/roullete_Inner.png'), context);
    precacheImage(const AssetImage("images/arch2.png"), context);
    precacheImage(const AssetImage("images/plate.png"), context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Ink.image(
              image: AssetImage(widget.isEuropean
                  ? "images/fungame3.jpg"
                  : "images/european_bg.png"),
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.width * 0.33,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    image: const DecorationImage(
                        image: AssetImage("images/top_banner.jpeg"),
                        fit: BoxFit.fill),
                  ),
                )),
            Consumer<MyVariableModel>(
              builder: (context, myVariableModel, child) {
                return myVariableModel.showAmusementMessage
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: IntrinsicHeight(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.02),
                              color: Colors.black,
                              child: CustomTextBottom(
                                // height: 0.78,
                                text: "FOR AMUSEMENT ONLY NO CASH VALUE",
                                color: const Color(0xff3cb635),
                                size: MediaQuery.of(context).size.height * 0.04,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    : myVariableModel.acceptBet
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: IntrinsicHeight(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  color: Colors.black,
                                  child: Center(
                                    child: CustomTextBottom(
                                      // height: 0.78,
                                      text:
                                          Provider.of<MyVariableModel>(context)
                                                  .placedBets
                                                  .isEmpty
                                              ? "Bet Time Over ."
                                              : "Your Bet has Been Accepted .",
                                      color: const Color(0xff3cb635),
                                      size: MediaQuery.of(context).size.height *
                                          0.04,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : myVariableModel.placedBets.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: IntrinsicHeight(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
                                      color: Colors.black,
                                      child: Center(
                                        child: CustomTextBottom(
                                          // height: 0.78,
                                          text: myVariableModel.showInsuff
                                              ? "Score Insufficient ."
                                              : "You can either make Bet or Press BETOK Button .",
                                          color: const Color(0xff3cb635),
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          weight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : myVariableModel.showInsuff
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: IntrinsicHeight(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01),
                                          color: Colors.black,
                                          child: Center(
                                            child: CustomTextBottom(
                                              // height: 0.78,
                                              text: myVariableModel.showInsuff
                                                  ? "Score Insufficient ."
                                                  : "",
                                              color: const Color(0xff3cb635),
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              weight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container();
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.293,
                  // top: MediaQuery.of(context).size.height * 0.295,
                  right: MediaQuery.of(context).size.width * 0.04),
              child: Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  // color: Colors.amber,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.18,
                  child: Consumer<RouletteApi>(
                      builder: (context, myVariableModel, child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: myVariableModel.lastBets.reversed
                          .take(5)
                          .map((result) {
                        return CustomText6(
                          height: 1,
                          color: result == "00" || result == "0"
                              ? Colors.green
                              : redNumbers.contains(result)
                                  ? Colors.red.shade500
                                  : Colors.white,
                          size: height * 0.036,
                          weight: FontWeight.w500,
                          text: result == "37"
                              ? "00"
                              : result == "38"
                                  ? "0"
                                  : result,
                        );
                      }).toList(),
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.2),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: height * 0.2,
                  width: width * 0.24,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.085,
                      ),
                      Consumer<MyVariableModel>(
                        builder: (context, myVariableModel, child) {
                          return GestureDetector(
                            onTap: () async {
                              Provider.of<MyVariableModel>(context,
                                      listen: false)
                                  .updateWheelZoom();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: width * 0.027,
                              ),
                              child: SizedBox(
                                width: 300,
                                // color: Colors.white,
                                child: Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    child: CustomText8(
                                      text: "   ",
                                      size: height * 0.026,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: height * 0.056,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          // SizedBox(
                          //   width: width * 0.04,
                          // ),
                          Consumer<MyVariableModel>(
                              builder: (context, myVarModel, child) {
                            return GestureDetector(
                              onTap: () {
                                checkBet();
                              },
                              // onTap: myVarModel.showAmusementMessage
                              //     ? null
                              //     : () async {
                              //         if (!isTapEnabled) {
                              //           return;
                              //         } else {
                              //           setState(() {
                              //             isTapEnabled = false;
                              //           });
                              //           // final roundId =
                              //           //     await getRound("Roulette", "Running");
                              //           final amount =
                              //               await getWiningAmountPending(
                              //                   context,
                              //                   "Roulette",
                              //                   widget.loginId);
                              //           // log("Amount = ${amount.toString()}");
                              //           if (int.parse(amount) == 0) {
                              //           } else {
                              //             Provider.of<RouletteApi>(context,
                              //                     listen: false)
                              //                 .resetBet();
                              //             Provider.of<MyVariableModel>(
                              //                     context,
                              //                     listen: false)
                              //                 .updateTableBlinkValue();
                              //             playAudio();
                              //             Provider.of<MyVariableModel>(
                              //                     context,
                              //                     listen: false)
                              //                 .updateAllKeys();
                              //             Provider.of<MyVariableModel>(
                              //                     context,
                              //                     listen: false)
                              //                 .updateScaffoldKey();
                              //             Provider.of<MyVariableModel>(
                              //                     context,
                              //                     listen: false)
                              //                 .clearPrevBet();
                              //             comingFromSession
                              //                 ? null
                              //                 : Provider.of<MyVariableModel>(
                              //                         context,
                              //                         listen: false)
                              //                     .convertPlacedBetsToPreviousBet();
                              //             Provider.of<MyVariableModel>(
                              //                     context,
                              //                     listen: false)
                              //                 .placedBets
                              //                 .clear();
                              //             Provider.of<MyVariableModel>(
                              //                     context,
                              //                     listen: false)
                              //                 .updateWheelKey();
                              //             setState(() {
                              //               comingFromSession = false;
                              //             });
                              //             // Provider.of<AudioProvider>(context,
                              //             //         listen: false)
                              //             //     .startPlaying();
                              //             if (int.parse(Provider.of<
                              //                             MyVariableModel>(
                              //                         context,
                              //                         listen: false)
                              //                     .winAmount) !=
                              //                 0) {
                              //               await updateWallet(
                              //                   loginid: widget.loginId,
                              //                   amount: amount);
                              //               Provider.of<MyVariableModel>(
                              //                       context,
                              //                       listen: false)
                              //                   .updateWinAmount(
                              //                       "0", widget.loginId);
                              //               Provider.of<RouletteApi>(context,
                              //                       listen: false)
                              //                   .resetTotalBalance(
                              //                       widget.loginId);
                              //             }
                              //           }
                              //           Future.delayed(
                              //               const Duration(seconds: 1));
                              //           setState(() {
                              //             isTapEnabled = true;
                              //           });
                              //         }
                              //       },
                              child: SizedBox(
                                // height: 20,

                                // color: Colors.white,
                                width: 85,
                                child: Center(
                                  child: CustomText8(
                                    text: "Exit",
                                    size: height * 0.023,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }),

                          const Spacer(),
                          Consumer<MyVariableModel>(
                            builder: (context, myVariableModel, child) {
                              return GestureDetector(
                                onTap: () {
                                  Provider.of<RouletteApi>(context,
                                          listen: false)
                                      .placePreviousBet(context,
                                          userId: widget.loginId);
                                },
                                child: SizedBox(
                                  // color: Colors.white,
                                  // height: 24,
                                  width: 110,
                                  child: Center(
                                    child: CustomText8(
                                      text: "Undo",
                                      size: height * 0.023,
                                      weight: FontWeight.bold,
                                      height: 0.7,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.004,
                ),
                child: InkWell(
                  onTap: () async {
                    Provider.of<RouletteApi>(context, listen: false)
                        .resetTotalBalance(widget.loginId,
                            subtractInvesting: true);
                  },
                  child: Container(
                    color: Colors.transparent,
                    // height: 12,
                    // width: MediaQuery.of(context).size.width * 0.11,
                    child: CustomText(
                      text: "REFRESH                   ",
                      size: height * 0.02,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.004,
                    left: MediaQuery.of(context).size.width * 0.06),
                child: Consumer<RouletteApi>(
                  builder: (context, rouletteApi, child) {
                    return CustomText3(
                      size: MediaQuery.of(context).size.height * 0.026,
                      weight: FontWeight.w500,
                      text: rouletteApi.investedBalance.round().toString(),
                    );
                  },
                ),
                //  showInvested
                //     ? FutureBuilder<String>(
                //         future:
                //             getBetAmount(context, "Roulette", widget.loginId),
                //         builder: (context, snapshot) {
                //           if (snapshot.connectionState ==
                //               ConnectionState.waiting) {
                //             return CustomText3(
                //               size:
                //                   MediaQuery.of(context).size.height * 0.026,
                //               weight: FontWeight.w500,
                //               text: Provider.of<MyVariableModel>(context)
                //                   .investedAmount,
                //             ); // Show a loading indicator while waiting for data
                //           } else if (snapshot.hasError) {
                //             return Text("Error: ${snapshot.error}");
                //           } else if (!snapshot.hasData) {
                //             return const Text("No Data Available");
                //           } else {
                //             return CustomText3(
                //               size:
                //                   MediaQuery.of(context).size.height * 0.026,
                //               weight: FontWeight.w500,
                //               text: Provider.of<MyVariableModel>(context)
                //                   .investedAmount,
                //             );
                //           }
                //         },
                //       )
                //     : CustomText3(
                //         size: MediaQuery.of(context).size.height * 0.026,
                //         weight: FontWeight.w500,
                //         text: "0",
                //       ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      // top: MediaQuery.of(context).size.height * 0.145,
                      top: MediaQuery.of(context).size.height * 0.155,
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Consumer<RouletteApi>(
                          builder: (context, rouletteApi, child) {
                            num balance = rouletteApi.totalBalance;

                            // Ensure the totalBalance never goes negative
                            if (balance < 0) {
                              balance = 0;
                            }

                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Center(
                                child: CustomText3(
                                  text:
                                      '${balance.round()}.00', // Display as integer value
                                  size: MediaQuery.of(context).size.height *
                                      0.035,
                                  weight: FontWeight.normal,
                                ),
                              ),
                            );
                          },
                        ),

                        // StreamBuilder<List<Balance>>(
                        //   stream: pointsStream(),
                        //   builder: (context, snapshot) {
                        //     double currentPoints =
                        //         num.parse(widget.points).toDouble();

                        //     if (snapshot.hasData &&
                        //         snapshot.data!.isNotEmpty) {
                        //       currentPoints = double.parse(
                        //           snapshot.data![0].walletPoints);
                        //     }

                        //     return PointsCounter(
                        //       initialPoints: currentPoints,
                        //       pointsStream:
                        //           pointsStream(), // Replace with your actual points stream
                        //     );
                        //   },
                        // ),
                        const Spacer(),
                        Consumer<RouletteApi>(
                          builder: (context, myVariableModel, child) {
                            return Container(
                                color: Colors.transparent,
                                // height: 12,
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: CustomText3(
                                  size: height * 0.034,
                                  weight: FontWeight.w400,
                                  text: myVariableModel.lastBets.isNotEmpty
                                      ? double.parse(myVariableModel
                                                      .lastBets.last ==
                                                  "37"
                                              ? "00"
                                              : myVariableModel.lastBets.last ==
                                                      "38"
                                                  ? "0"
                                                  : myVariableModel
                                                      .lastBets.last)
                                          .round()
                                          .toString()
                                      : "0",
                                ));
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.06,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.093,
                  // height: MediaQuery.of(context).size.height * 0.09,
                ),

                widget.showTimer
                    ? RouletteTimer(
                        loginId: widget.loginId,
                        isEuropean: widget.isEuropean,
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.03,
                                top: 4),
                            child: InkWell(
                              onTap: () {
                                final random = Random();
                                // bool randomBool = random.nextBool();
                                Provider.of<RouletteApi>(context, listen: false)
                                    .spinRoulette(
                                  context,
                                  widget.loginId,
                                  widget.isEuropean ? 36 : 35,
                                );

                                controller.add(22);
                                spinRoulette(context);
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.17,
                                child: Center(
                                  child: CustomText9(
                                      color: Colors.white,
                                      size: height * 0.033,
                                      weight: FontWeight.normal,
                                      text: "Spin Now"),
                                ),
                              ),
                            )),
                      ),

                // ),
                const Spacer(),

                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.02,
                // ),
                Consumer<MyVariableModel>(
                  builder: (context, myVariableModel, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 0, right: 3),
                      child: RouletteTable(
                          showdoubleZero: widget.isEuropean,
                          isPreviousBet: Provider.of<MyVariableModel>(context,
                                  listen: false)
                              .previousBets
                              .isNotEmpty,
                          key: myVariableModel.scaffoldKey,
                          roundid: getRoundId(),
                          loginid: widget.loginId,
                          betAmount: Provider.of<MyVariableModel>(context,
                                  listen: false)
                              .coinAmount
                              .toString()),
                    );
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                // const Spacer(),
              ],
            ),
            Consumer<MyVariableModel>(
              builder: (context, myVariableModel, child) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: IgnorePointer(
                      ignoring: myVariableModel.acceptBet,
                      child: const RoulleteCoinPicker()),
                );
              },
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.045,
                    left: MediaQuery.of(context).size.width * 0.04),
                child: SizedBox(
                  height: 25,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () async {
                            Provider.of<MyVariableModel>(context, listen: false)
                                .cancelSpecificBet();
                            Provider.of<RouletteApi>(context, listen: false)
                                .cancelSpecific(widget.loginId);
                            // await cancelSpecificBet(
                            //     context, "Roulette", widget.loginId);
                          },
                          child: Container(
                            color: Colors.transparent,
                            // height: 12,
                            width: MediaQuery.of(context).size.width * 0.17,
                            child: Center(
                              child: CustomText8(
                                text: "Cancel Specific Bet",
                                size: height * 0.026,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: Provider.of<MyVariableModel>(context,
                                      listen: false)
                                  .acceptBet
                              ? null
                              : () async {
                                  Provider.of<RouletteApi>(context,
                                          listen: false)
                                      .cancelBet(widget.loginId);
                                  // await cancelBet("Roulette", widget.loginId);
                                  Provider.of<MyVariableModel>(context,
                                          listen: false)
                                      .updateAllKeys();
                                  Provider.of<MyVariableModel>(context,
                                          listen: false)
                                      .updateScaffoldKey();
                                  Provider.of<MyVariableModel>(context,
                                          listen: false)
                                      .placedBets
                                      .clear();
                                  Provider.of<MyVariableModel>(context,
                                          listen: false)
                                      .previousBets
                                      .clear();
                                },
                          child: SizedBox(
                            height: 25,
                            width: MediaQuery.of(context).size.width * 0.17,
                            child: Center(
                              child: CustomText8(
                                text: "Cancel Bet",
                                size: height * 0.026,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Consumer<MyVariableModel>(
              builder: (context, myVariableModel, child) {
                return myVariableModel.winAmount == "0" ||
                        myVariableModel.winAmount == ""
                    ? Container()
                    : Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.04,
                                right:
                                    MediaQuery.of(context).size.width * 0.146),
                            child: const AlwaysBlinkingContainer()),
                      );
              },
            ),
            Consumer<MyVariableModel>(
              builder: (context, myVariableModel, child) {
                String buttonText = myVariableModel.currentBet.isNotEmpty &&
                        myVariableModel.placedBets.isEmpty
                    ? "Prev Bet"
                    : "Bet Ok";
                return buttonText == "Prev Bet"
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.04,
                              right: MediaQuery.of(context).size.width * 0.013),
                          child: myVariableModel.winAmount == "0" ||
                                  myVariableModel.winAmount == ""
                              ? const BlinkingContainer()
                              : Container(),
                        ),
                      )
                    : int.parse(myVariableModel.winAmount) != 0
                        ? Container()
                        : myVariableModel.acceptBet
                            ? Container()
                            : myVariableModel.placedBets.isEmpty
                                ? Container()
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.013),
                                      child: const BlinkingContainer(),
                                    ),
                                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
