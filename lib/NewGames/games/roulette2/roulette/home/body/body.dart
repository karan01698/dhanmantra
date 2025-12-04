// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../main.dart';
import '../../backend/money_star_apis.dart';
import '../../provider/myvariable.dart';
import '../../provider/roulette_api.dart';
import '../../text.dart';
import '../roulette/roulette.dart';


class Body extends StatefulWidget {
  final String loginId;
  const Body({super.key, required this.loginId});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void showLoader() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(Colors.red.shade700),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText6(
                  text: "Preparing your game",
                )
              ],
            ),
          );
        });
  }

  bool pressed = false;
  MoneyStarMethods moneyStarMethods = MoneyStarMethods();
  void handleButtonClick(points,
      {required bool showTimer, required bool isEuropean}) async {
    await precacheImage(const AssetImage('images/roullete_Inner.png'), context);
    await precacheImage(const AssetImage("images/plate.png"), context);
    await precacheImage(const AssetImage("images/ball.png"), context);
    await precacheImage(const AssetImage("images/arch2.png"), context);
    // await precacheImage(const AssetImage("images/heera.png"), context);
    await precacheImage(const AssetImage("images/fungame3.jpg"), context);
    await precacheImage(const AssetImage("images/1.png"), context);
    await precacheImage(const AssetImage("images/5.png"), context);
    await precacheImage(const AssetImage("images/10.png"), context);
    await precacheImage(const AssetImage("images/50.png"), context);
    await precacheImage(const AssetImage("images/100.png"), context);
    await precacheImage(const AssetImage("images/500.png"), context);
    await precacheImage(const AssetImage("images/1000.png"), context);
    await precacheImage(const AssetImage("images/5000.png"), context);
    await precacheImage(const AssetImage("images/roullete.jpeg"), context);
    await precacheImage(const AssetImage("images/coin_plate2.png"), context);
    await precacheImage(
        const AssetImage(
          "images/top_banner.jpeg",
        ),
        context);
    int secondsRemaining = 60 - DateTime.now().second;
    if (secondsRemaining > 52) {
      Provider.of<MyVariableModel>(context, listen: false)
          .updateBetStatus(false, gameName: "Roulette");
      // Wait for the remaining time
      Timer(Duration(seconds: secondsRemaining - 52), () {
        Provider.of<MyVariableModel>(context, listen: false)
            .updateBetStatus(false, gameName: "Roulette");
        // After waiting, navigate to the RoulleteScreen
        Navigator.pop(context);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => RoulleteScreen(
              isEuropean: isEuropean,
              showTimer: showTimer,
              comingFromSession: goingFromSession,
              points: points,
              loginId: widget.loginId,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        ).then((value) {
          setState(() {
            goingFromSession = false;
            pressed = false;
          });
        });
      });
    } else {
      Navigator.pop(context);

      // If the remaining time is less than or equal to 52, navigate immediately
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => RoulleteScreen(
            isEuropean: isEuropean,
            showTimer: showTimer,
            comingFromSession: goingFromSession,
            points: points,
            loginId: widget.loginId,
          ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      ).then((value) {
        setState(() {
          goingFromSession = false;
          pressed = false;
        });
      });
    }
  }

  Future<void> loadImage(ImageProvider provider) {
    final ImageConfiguration config = ImageConfiguration(
      bundle: rootBundle,
      devicePixelRatio: window.devicePixelRatio,
      platform: defaultTargetPlatform,
    );
    final Completer<void> completer = Completer<void>();
    final ImageStream stream = provider.resolve(config);
//streamChannelBuildTO 16;
    late final ImageStreamListener listener;

    listener = ImageStreamListener((ImageInfo image, bool sync) {
      logPrint('Image ${image.debugLabel} finished loading');
      completer.complete();
      stream.removeListener(listener);
    }, onError: (Object exception, StackTrace? stackTrace) {
      completer.complete();
      stream.removeListener(listener);
      FlutterError.reportError(FlutterErrorDetails(
        context: ErrorDescription('image failed to load'),
        library: 'image resource service',
        exception: exception,
        stack: stackTrace,
        silent: true,
      ));
    });
    stream.addListener(listener);
    return completer.future;
  }

  bool goingFromSession = false;

  void loadBlockBets(SharedPreferences preferences, BuildContext context) {
    final val1 = preferences.getBool("lastRow1") ?? false;
    final amount1 = preferences.getInt("lastRowAmount1") ?? 0;
    Provider.of<MyVariableModel>(context, listen: false)
        .updateLastRow1(val1, amount1);

    final val2 = preferences.getBool("lastRow2") ?? false;
    final amount2 = preferences.getInt("lastRowAmount2") ?? 0;
    Provider.of<MyVariableModel>(context, listen: false)
        .updateLastRow2(val2, amount2);

    final val3 = preferences.getBool("lastRow3") ?? false;
    final amount3 = preferences.getInt("lastRowAmount3") ?? 0;
    Provider.of<MyVariableModel>(context, listen: false)
        .updateLastRow3(val3, amount3);

    final val4 = preferences.getBool("lastRow4") ?? false;
    final amount4 = preferences.getInt("lastRowAmount4") ?? 0;
    Provider.of<MyVariableModel>(context, listen: false)
        .updateLastRow4(val4, amount4);

    final val5 = preferences.getBool("lastRow5") ?? false;
    final amount5 = preferences.getInt("lastRowAmount5") ?? 0;
    Provider.of<MyVariableModel>(context, listen: false)
        .updateLastRow5(val5, amount5);

    final val6 = preferences.getBool("lastRow6") ?? false;
    final amount6 = preferences.getInt("lastRowAmount6") ?? 0;
    Provider.of<MyVariableModel>(context, listen: false)
        .updateLastRow6(val6, amount6);

    final val7 = preferences.getBool("lastRow7") ?? false;
    final amount7 = preferences.getInt("lastRowAmount7") ?? 0;
    Provider.of<MyVariableModel>(context, listen: false)
        .updateLastRow7(val7, amount7);

    final val8 = preferences.getBool("lastRow8") ?? false;
    final amount8 = preferences.getInt("lastRowAmount8") ?? 0;
    Provider.of<MyVariableModel>(context, listen: false)
        .updateLastRow8(val8, amount8);

    final val9 = preferences.getBool("lastRow9") ?? false;
    final amount9 = preferences.getInt("lastRowAmount9") ?? 0;
    Provider.of<MyVariableModel>(context, listen: false)
        .updateLastRow9(val9, amount9);
  }

  Future<void> checkAndLoadLastSavedRoundData(BuildContext context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    // Check if lastSavedRoundId exists
    if (preferences.containsKey("lastSavedRoundId")) {
      // Retrieve lastSavedRoundId
      final String lastSavedRoundId =
          preferences.getString("lastSavedRoundId") ?? "";

      DateTime storedTime =
          DateTime.parse(lastSavedRoundId).subtract(const Duration(minutes: 1));

      // Calculate the difference in minutes
      int differenceInMinutes = DateTime.now().difference(storedTime).inMinutes;
      // Retrieve and parse lastSavedRoundBet
      if (differenceInMinutes >= 1) {
        if (preferences.containsKey("lastSavedRoundBet")) {
          final List<String>? serializedList =
              preferences.getStringList("lastSavedRoundBet");
          if (serializedList != null) {
            // List<PreviousBets> lastSavedRoundBet = serializedList
            //     .map((jsonString) =>
            //         PreviousBets.fromJson(json.decode(jsonString)))
            //     .toList();
            // final result = await getResult("Roulette", lastSavedRoundId);
            // final winAmount = await getWiningAmountPending(
            //     context, "Roulette", widget.loginId,
            //     roundId: lastSavedRoundId, result: result);
            {
              Provider.of<MyVariableModel>(context, listen: false)
                  .clearEveryThing();
              Provider.of<MyVariableModel>(context, listen: false)
                  .updateBlocksData(false);
            }
          }
        } else {
          Provider.of<MyVariableModel>(context, listen: false)
              .clearEveryThing();
          Provider.of<MyVariableModel>(context, listen: false)
              .updateBlocksData(false);
        }
      } else {
        final List<String>? serializedList =
            preferences.getStringList("lastSavedRoundBet");
        if (serializedList != null) {
          List<PreviousBets> lastSavedRoundBet = serializedList
              .map((jsonString) =>
                  PreviousBets.fromJson(json.decode(jsonString)))
              .toList();

          Provider.of<MyVariableModel>(context, listen: false)
              .placeBetForSavedRound(lastSavedRoundBet);
          loadBlockBets(preferences, context);
          Provider.of<MyVariableModel>(context, listen: false)
              .updateBlocksData(true);
        } else {
          Provider.of<MyVariableModel>(context, listen: false)
              .clearEveryThing();
          Provider.of<MyVariableModel>(context, listen: false)
              .updateBlocksData(false);
        }
      }
    } else {
      Provider.of<MyVariableModel>(context, listen: false).clearEveryThing();
      Provider.of<MyVariableModel>(context, listen: false)
          .updateBlocksData(false);
    }
    Provider.of<MyVariableModel>(context, listen: false).updateAllKeys();
    Provider.of<MyVariableModel>(context, listen: false).updateScaffoldKey();
    Provider.of<MyVariableModel>(context, listen: false).updateWheelKey();

    Provider.of<RouletteApi>(context, listen: false).resetBet();
    Provider.of<MyVariableModel>(context, listen: false).clearPrevBet();

    Provider.of<MyVariableModel>(context, listen: false)
        .convertPlacedBetsToPreviousBet();
    Provider.of<MyVariableModel>(context, listen: false).placedBets.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 50,
          ),
          InkWell(
            onTap: pressed
                ? null
                : () async {
                    showLoader();
                    await precacheImage(
                        const AssetImage(
                          "images/european_bg.png",
                        ),
                        context);
                    // imagenames.forEach((element) async {
                    //     await precacheImage(AssetImage(element), context);
                    //   });
                    setState(() {
                      pressed = true;
                    });
                    await Provider.of<MyVariableModel>(context, listen: false)
                        .updateLastResults();
                    await precacheImage(
                        const AssetImage('images/roullete_Inner.png'), context);

                    await precacheImage(
                        const AssetImage("images/plate.png"), context);
                    await precacheImage(
                        const AssetImage("images/ball.png"), context);
                    await precacheImage(
                        const AssetImage("images/arch2.png"), context);
                    // await precacheImage(
                    //     const AssetImage("images/heera.png"), context);
                    await precacheImage(
                        const AssetImage("images/fungame3.jpg"), context);

                    await precacheImage(
                        const AssetImage("images/1.png"), context);
                    await precacheImage(
                        const AssetImage("images/5.png"), context);
                    await precacheImage(
                        const AssetImage("images/10.png"), context);
                    await precacheImage(
                        const AssetImage("images/50.png"), context);
                    await precacheImage(
                        const AssetImage("images/100.png"), context);
                    await precacheImage(
                        const AssetImage("images/500.png"), context);
                    await precacheImage(
                        const AssetImage("images/1000.png"), context);
                    await precacheImage(
                        const AssetImage("images/5000.png"), context);
                    await precacheImage(
                        const AssetImage("images/roullete.jpeg"), context);
                    await precacheImage(
                        const AssetImage("images/coin_plate2.png"), context);
                    await Provider.of<MyVariableModel>(context, listen: false)
                        .updateLastResults();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .updateBlocksData(false);
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateVariable(2);
                    await checkAndLoadLastSavedRoundData(context);

                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .placedBets
                    //     .clear();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .previousBets
                    //     .clear();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .convertPlacedBetsToPreviousBet();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .convertCurrentBetToPreviousBet();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateAllKeys();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateScaffoldKey();
                    await precacheImage(
                        const AssetImage(
                          "images/1.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/5.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/10.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/50.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/100.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/500.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/1000.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/5000.png",
                        ),
                        context);
                    precacheImage(
                        const AssetImage(
                          "images/coins_bg.png",
                        ),
                        context);

                    // await precacheImage(
                    //     const AssetImage("images/heera.png"), context);
                    // imagenames.forEach((element) async {
                    //   await precacheImage(AssetImage(element), context);
                    // });

                    await loadImage(const AssetImage("images/arch2.png"));
                    await loadImage(
                      const AssetImage('images/roullete_Inner.png'),
                    );
                    await loadImage(
                      const AssetImage('images/roullete_Inner.png'),
                    );
                    await loadImage(
                      const AssetImage(
                        "images/plate.png",
                      ),
                    );
                    //
                    await Provider.of<RouletteApi>(context, listen: false)
                        .resetTotalBalance(widget.loginId);
                    Provider.of<MyVariableModel>(context, listen: false)
                        .initializeKeys();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateAllKeys();
                    // take true?:everyclear

                    // // Provider.of<MyVariableModel>(context, listen: false).convert
                    final pointsData =
                        await moneyStarMethods.getProfile(widget.loginId);
                    // final audioProvider =
                    //     Provider.of<AudioProvider>(context, listen: false);
                    // audioProvider.startPlaying();
                    await Provider.of<RouletteApi>(context, listen: false)
                        .resetTotalBalance(widget.loginId);
                    Provider.of<RouletteApi>(context, listen: false)
                        .updateDoubleZeroStatus(true);

                    handleButtonClick(pointsData[0].balance,
                        showTimer: false, isEuropean: true);
                    // Navigator.push(context, MaterialPageRoute(builder: (context){
                    //   return Roull
                    // }));
                  },
            child: const GameDisplayCard(
              gameName: 'American Roulette',
              bannerImage: 'images/americamn.Webp',
              description: 'Tap To Spin',
            ),
          ),
          InkWell(
            onTap: pressed
                ? null
                : () async {
                    showLoader();

                    await precacheImage(
                        const AssetImage(
                          "images/european_bg.png",
                        ),
                        context);
                    // imagenames.forEach((element) async {
                    //     await precacheImage(AssetImage(element), context);
                    //   });
                    setState(() {
                      pressed = true;
                    });
                    await Provider.of<MyVariableModel>(context, listen: false)
                        .updateLastResults();
                    await precacheImage(
                        const AssetImage('images/roullete_Inner.png'), context);

                    await precacheImage(
                        const AssetImage("images/plate.png"), context);
                    await precacheImage(
                        const AssetImage("images/ball.png"), context);
                    await precacheImage(
                        const AssetImage("images/arch2.png"), context);
                    // await precacheImage(
                    //     const AssetImage("images/heera.png"), context);
                    await precacheImage(
                        const AssetImage("images/fungame3.jpg"), context);

                    await precacheImage(
                        const AssetImage("images/1.png"), context);
                    await precacheImage(
                        const AssetImage("images/5.png"), context);
                    await precacheImage(
                        const AssetImage("images/10.png"), context);
                    await precacheImage(
                        const AssetImage("images/50.png"), context);
                    await precacheImage(
                        const AssetImage("images/100.png"), context);
                    await precacheImage(
                        const AssetImage("images/500.png"), context);
                    await precacheImage(
                        const AssetImage("images/1000.png"), context);
                    await precacheImage(
                        const AssetImage("images/5000.png"), context);
                    await precacheImage(
                        const AssetImage("images/roullete.jpeg"), context);
                    await precacheImage(
                        const AssetImage("images/coin_plate2.png"), context);
                    await Provider.of<MyVariableModel>(context, listen: false)
                        .updateLastResults();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .updateBlocksData(false);
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateVariable(2);
                    await checkAndLoadLastSavedRoundData(context);

                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .placedBets
                    //     .clear();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .previousBets
                    //     .clear();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .convertPlacedBetsToPreviousBet();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .convertCurrentBetToPreviousBet();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateAllKeys();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateScaffoldKey();
                    await precacheImage(
                        const AssetImage(
                          "images/1.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/5.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/10.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/50.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/100.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/500.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/1000.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/5000.png",
                        ),
                        context);
                    precacheImage(
                        const AssetImage(
                          "images/coins_bg.png",
                        ),
                        context);
                    // await precacheImage(
                    //     const AssetImage("images/heera.png"), context);
                    // imagenames.forEach((element) async {
                    //   await precacheImage(AssetImage(element), context);
                    // });

                    await loadImage(const AssetImage("images/arch2.png"));
                    await loadImage(
                      const AssetImage('images/roullete_Inner.png'),
                    );
                    await loadImage(
                      const AssetImage('images/roullete_Inner.png'),
                    );
                    await loadImage(
                      const AssetImage(
                        "images/plate.png",
                      ),
                    );
                    //
                    await Provider.of<RouletteApi>(context, listen: false)
                        .resetTotalBalance(widget.loginId);
                    Provider.of<MyVariableModel>(context, listen: false)
                        .initializeKeys();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateAllKeys();
                    // take true?:everyclear

                    // // Provider.of<MyVariableModel>(context, listen: false).convert
                    final pointsData =
                        await moneyStarMethods.getProfile(widget.loginId);
                    // final audioProvider =
                    //     Provider.of<AudioProvider>(context, listen: false);
                    // audioProvider.startPlaying();
                    await Provider.of<RouletteApi>(context, listen: false)
                        .resetTotalBalance(widget.loginId);
                    Provider.of<RouletteApi>(context, listen: false)
                        .updateDoubleZeroStatus(false);

                    handleButtonClick(pointsData[0].balance,
                        showTimer: false, isEuropean: false);
                    // Navigator.push(context, MaterialPageRoute(builder: (context){
                    //   return Roull
                    // }));
                  },
            child: const GameDisplayCard(
              gameName: 'European Roulette',
              bannerImage: 'images/european-roulette.jpg',
              description: 'Tap To Spin',
            ),
          ),
          InkWell(
            onTap: pressed
                ? null
                : () async {
                    showLoader();

                    await precacheImage(
                        const AssetImage(
                          "images/european_bg.png",
                        ),
                        context);
                    // imagenames.forEach((element) async {
                    //     await precacheImage(AssetImage(element), context);
                    //   });
                    setState(() {
                      pressed = true;
                    });
                    await Provider.of<MyVariableModel>(context, listen: false)
                        .updateLastResults();
                    await precacheImage(
                        const AssetImage('images/roullete_Inner.png'), context);

                    await precacheImage(
                        const AssetImage("images/plate.png"), context);
                    await precacheImage(
                        const AssetImage("images/ball.png"), context);
                    await precacheImage(
                        const AssetImage("images/arch2.png"), context);
                    // await precacheImage(
                    //     const AssetImage("images/heera.png"), context);
                    await precacheImage(
                        const AssetImage("images/fungame3.jpg"), context);

                    await precacheImage(
                        const AssetImage("images/1.png"), context);
                    await precacheImage(
                        const AssetImage("images/5.png"), context);
                    await precacheImage(
                        const AssetImage("images/10.png"), context);
                    await precacheImage(
                        const AssetImage("images/50.png"), context);
                    await precacheImage(
                        const AssetImage("images/100.png"), context);
                    await precacheImage(
                        const AssetImage("images/500.png"), context);
                    await precacheImage(
                        const AssetImage("images/1000.png"), context);
                    await precacheImage(
                        const AssetImage("images/5000.png"), context);
                    await precacheImage(
                        const AssetImage("images/roullete.jpeg"), context);
                    await precacheImage(
                        const AssetImage("images/coin_plate2.png"), context);
                    await Provider.of<MyVariableModel>(context, listen: false)
                        .updateLastResults();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .updateBlocksData(false);
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateVariable(2);
                    await checkAndLoadLastSavedRoundData(context);

                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .placedBets
                    //     .clear();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .previousBets
                    //     .clear();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .convertPlacedBetsToPreviousBet();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .convertCurrentBetToPreviousBet();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateAllKeys();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateScaffoldKey();
                    await precacheImage(
                        const AssetImage(
                          "images/1.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/5.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/10.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/50.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/100.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/500.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/1000.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/5000.png",
                        ),
                        context);
                    precacheImage(
                        const AssetImage(
                          "images/coins_bg.png",
                        ),
                        context);
                    // await precacheImage(
                    //     const AssetImage("images/heera.png"), context);
                    // imagenames.forEach((element) async {
                    //   await precacheImage(AssetImage(element), context);
                    // });

                    await loadImage(const AssetImage("images/arch2.png"));
                    await loadImage(
                      const AssetImage('images/roullete_Inner.png'),
                    );
                    await loadImage(
                      const AssetImage('images/roullete_Inner.png'),
                    );
                    await loadImage(
                      const AssetImage(
                        "images/plate.png",
                      ),
                    );

                    Provider.of<RouletteApi>(context, listen: false)
                        .updateDoubleZeroStatus(true);
                    //
                    await Provider.of<RouletteApi>(context, listen: false)
                        .resetTotalBalance(widget.loginId);
                    Provider.of<MyVariableModel>(context, listen: false)
                        .initializeKeys();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateAllKeys();
                    // take true?:everyclear

                    // // Provider.of<MyVariableModel>(context, listen: false).convert
                    final pointsData =
                        await moneyStarMethods.getProfile(widget.loginId);
                    // final audioProvider =
                    //     Provider.of<AudioProvider>(context, listen: false);
                    // audioProvider.startPlaying();
                    await Provider.of<RouletteApi>(context, listen: false)
                        .resetTotalBalance(widget.loginId);

                    handleButtonClick(pointsData[0].balance,
                        showTimer: true, isEuropean: true);
                    // Navigator.push(context, MaterialPageRoute(builder: (context){
                    //   return Roull
                    // }));
                  },
            child: const GameDisplayCard(
              gameName: 'American Roulette',
              bannerImage: 'images/americamn.webp',
              description: 'Every 30 Seconds',
            ),
          ),
          InkWell(
            onTap: pressed
                ? null
                : () async {
                    showLoader();

                    await precacheImage(
                        const AssetImage(
                          "images/european_bg.png",
                        ),
                        context);

                    setState(() {
                      pressed = true;
                    });
                    Provider.of<RouletteApi>(context, listen: false)
                        .updateDoubleZeroStatus(false);
                    await Provider.of<MyVariableModel>(context, listen: false)
                        .updateLastResults();
                    await precacheImage(
                        const AssetImage('images/roullete_Inner.png'), context);

                    await precacheImage(
                        const AssetImage("images/plate.png"), context);
                    await precacheImage(
                        const AssetImage("images/ball.png"), context);
                    await precacheImage(
                        const AssetImage("images/arch2.png"), context);
                    // await precacheImage(
                    //     const AssetImage("images/heera.png"), context);
                    await precacheImage(
                        const AssetImage("images/fungame3.jpg"), context);

                    await precacheImage(
                        const AssetImage("images/1.png"), context);
                    await precacheImage(
                        const AssetImage("images/5.png"), context);
                    await precacheImage(
                        const AssetImage("images/10.png"), context);
                    await precacheImage(
                        const AssetImage("images/50.png"), context);
                    await precacheImage(
                        const AssetImage("images/100.png"), context);
                    await precacheImage(
                        const AssetImage("images/500.png"), context);
                    await precacheImage(
                        const AssetImage("images/1000.png"), context);
                    await precacheImage(
                        const AssetImage("images/5000.png"), context);
                    await precacheImage(
                        const AssetImage("images/roullete.jpeg"), context);
                    await precacheImage(
                        const AssetImage("images/coin_plate2.png"), context);
                    await Provider.of<MyVariableModel>(context, listen: false)
                        .updateLastResults();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .updateBlocksData(false);
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateVariable(2);
                    await checkAndLoadLastSavedRoundData(context);

                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .placedBets
                    //     .clear();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .previousBets
                    //     .clear();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .convertPlacedBetsToPreviousBet();
                    // Provider.of<MyVariableModel>(context, listen: false)
                    //     .convertCurrentBetToPreviousBet();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateAllKeys();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateScaffoldKey();
                    await precacheImage(
                        const AssetImage(
                          "images/1.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/5.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/10.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/50.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/100.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/500.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/1000.png",
                        ),
                        context);
                    await precacheImage(
                        const AssetImage(
                          "images/5000.png",
                        ),
                        context);
                    precacheImage(
                        const AssetImage(
                          "images/coins_bg.png",
                        ),
                        context);
                    // await precacheImage(
                    //     const AssetImage("images/heera.png"), context);
                    // imagenames.forEach((element) async {
                    //   await precacheImage(AssetImage(element), context);
                    // });

                    await loadImage(const AssetImage("images/arch2.png"));
                    await loadImage(
                      const AssetImage('images/roullete_Inner.png'),
                    );
                    await loadImage(
                      const AssetImage('images/roullete_Inner.png'),
                    );
                    await loadImage(
                      const AssetImage(
                        "images/plate.png",
                      ),
                    );
                    //
                    await Provider.of<RouletteApi>(context, listen: false)
                        .resetTotalBalance(widget.loginId);
                    Provider.of<MyVariableModel>(context, listen: false)
                        .initializeKeys();
                    Provider.of<MyVariableModel>(context, listen: false)
                        .updateAllKeys();
                    // take true?:everyclear

                    // // Provider.of<MyVariableModel>(context, listen: false).convert
                    final pointsData =
                        await moneyStarMethods.getProfile(widget.loginId);
                    // final audioProvider =
                    //     Provider.of<AudioProvider>(context, listen: false);
                    // audioProvider.startPlaying();
                    await Provider.of<RouletteApi>(context, listen: false)
                        .resetTotalBalance(widget.loginId);

                    handleButtonClick(pointsData[0].balance,
                        showTimer: true, isEuropean: false);
                    // Navigator.push(context, MaterialPageRoute(builder: (context){
                    //   return Roull
                    // }));
                  },
            child: const GameDisplayCard(
              gameName: 'European Roulette',
              bannerImage: 'images/european-roulette.jpg',
              description: 'Every 30 Seconds',
            ),
          ),
        ],
      ),
    );
  }
}

class GameDisplayCard extends StatelessWidget {
  final String gameName;
  final String bannerImage;
  final String description;

  const GameDisplayCard({
    super.key,
    required this.gameName,
    required this.bannerImage,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 60),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(0),
        child: Container(
          height: MediaQuery.of(context).size.width * 0.17,
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                bannerImage,
              ),
              fit: BoxFit.fill,
            ),
          ),
          //padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText6(
                      text: gameName,
                      size: 20,
                      weight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    CustomText6(
                      text: description,
                      align: TextAlign.center,
                      size: 16,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
