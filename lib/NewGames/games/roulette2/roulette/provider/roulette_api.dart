import 'dart:developer';
// import 'dart:js';
import 'dart:math' as math;

import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../main.dart';
import '../backend/money_star_apis.dart';
import '../home/roulette/dialoge.dart';
import '../lists.dart';
import '../models/get_results.dart';
import '../models/roulette_bet.dart';
import 'audio.dart';
import 'myvariable.dart';

class RouletteApi with ChangeNotifier {
  static MoneyStarMethods moneyStarMethods = MoneyStarMethods();
  String loginId = "";
  num totalBalance = 0;
  String lastWinningDigit = "0";
  bool showDoubleZeroInTable = false;
  bool enableUndo = true;

  num investedBalance = 0;
  num prevInvestedBalance = 0;
  String ballPlace = "0";

  List<RouletteBet> rouletteBets = [];
  List<RouletteBet> prevBets = [];
  List<RouletteBet> currentBets = [];
  List<String> lastBets = [];
  List<GetResults> resultsData = [];
  void cancelSpecific(String phone) async {
    num totalBalance = 0;

    for (var bet in currentBets) {
      subtractInvestedBalance(bet.amt);
    }
    for (var bet in currentBets) {
      totalBalance += bet.amt;

      addTotalBalance(bet.amt);
    }

    currentBets.clear();
    notifyListeners();
    final currentAmount = await moneyStarMethods.getProfile(phone);
    moneyStarMethods.updateWallet(
        amount: (num.parse(currentAmount[0].balance) + totalBalance).toString(),
        phone: phone);
  }

  void resetBet() {
    prevBets = List.from(rouletteBets);
    prevInvestedBalance = investedBalance;
    rouletteBets.clear();
    investedBalance = 0;
    notifyListeners();
  }

  void addInvestedBalance(num balance) {
    investedBalance = investedBalance + balance;
    notifyListeners();
  }

  void updateDoubleZeroStatus(bool status) {
    showDoubleZeroInTable = status;
    _loadData();
    notifyListeners();
  }

  void updateUndoClick(bool status) {
    enableUndo = status;
    notifyListeners();
  }

  void updateLastWinningNumber(String number) {
    lastWinningDigit = number;
    notifyListeners();
  }

  void updateLoginId(String id) {
    loginId = id;
    notifyListeners();
  }

  void updateBallPlace(String number) {
    ballPlace = number == "37"
        ? "00"
        : number == "38"
            ? "0"
            : number;
    log("updating ball $ballPlace");
    notifyListeners();
  }

  void subtractInvestedBalance(num balance) {
    investedBalance = investedBalance - balance;
    notifyListeners();
  }

  void resetInvestedBalance() {
    investedBalance = 0;
    notifyListeners();
  }

  void subtractTotalBalance(num balance) {
    log(balance.toString());
    totalBalance = totalBalance - balance;
    notifyListeners();
  }

  void addTotalBalance(num balance) {
    totalBalance = totalBalance + balance;
    notifyListeners();
  }

  num totalBetAmount(List<RouletteBet> bets) {
    num total = 0;
    for (var bet in bets) {
      total += bet.amt;
    }
    return total;
  }

  void placePreviousBet(BuildContext context, {required userId}) async {
    if (enableUndo) {
      updateUndoClick(false);
      // final totalAmt = totalBetAmount(rouletteBets);
      if (prevInvestedBalance <= totalBalance) {
        rouletteBets = prevBets;
        investedBalance = prevInvestedBalance;
        Provider.of<MyVariableModel>(context, listen: false)
            .updateBlocksData(true);
        Provider.of<MyVariableModel>(context, listen: false)
            .convertCurrentBetToPreviousBet();
        subtractTotalBalance(
            investedBalance); // This should deduct the invested balance
        notifyListeners();
      } else {
        Provider.of<MyVariableModel>(context, listen: false).updateInsuff(true);
      }
    }
  }

  Future<void> resetTotalBalance(String loginId,
      {bool subtractInvesting = false}) async {
    final points = await moneyStarMethods.getProfile(loginId);
    if (subtractInvesting) {
      totalBalance = num.parse(points[0].balance).round() - investedBalance;
    } else {
      totalBalance = num.parse(points[0].balance).round();
    }
    notifyListeners();
  }

  void cancelBet(String phone) async {
    final currentAmount = await moneyStarMethods.getProfile(phone);
    moneyStarMethods.updateWallet(
        amount:
            (num.parse(currentAmount[0].balance) + investedBalance).toString(),
        phone: phone);
    rouletteBets.clear();
    addTotalBalance(investedBalance);

    resetInvestedBalance();
    notifyListeners();
  }

  Future<void> playAudio(BuildContext context) async {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);

    audioProvider.playOneTimeAudioWithoutStopping("audio/bet_placed.mp3");
  }

  updateWalletOnBet(amount) async {
    final profileData = await moneyStarMethods.getProfile(loginId);
    moneyStarMethods.updateWallet(
        phone: loginId,
        amount: (num.parse(profileData[0].balance) - amount).toString());
  }

  bool placeBetOnFrontEnd(
    BuildContext context, {
    required List<RouletteBet> bets,
  }) {
    log(bets[0].digit.toString());
    if (int.parse(
            Provider.of<MyVariableModel>(context, listen: false).winAmount) ==
        0) {
      if (Provider.of<MyVariableModel>(context, listen: false).acceptBet ==
              false &&
          Provider.of<MyVariableModel>(context, listen: false)
                  .showAmusementMessage ==
              false) {
        currentBets.clear();
        num totalBetsAmount =
            bets.fold<num>(0, (num sum, RouletteBet bet) => sum + bet.amt);

        if (totalBetsAmount <= totalBalance) {
          playAudio(context);
          for (var bet in bets) {
            addInvestedBalance(bet.amt);
            subtractTotalBalance(bet.amt);

            rouletteBets.add(bet);
          }
          List<String> prevBet = [];
          for (var element in bets) {
            prevBet.add(element.digit.toString());
          }
          if (prevBet.length < 7) {
            Provider.of<MyVariableModel>(context, listen: false)
                .updateSpecificBlockBet(null);
          }
          log(prevBet.toString());
          Provider.of<MyVariableModel>(context, listen: false)
              .addBet(PreviousBets(
                  totalBetsAmount.toString(),
                  prevBet.toString() == row1Bet.toString()
                      ? ['Row1']
                      : prevBet.toString() == row2Bet.toString()
                          ? ['Row2']
                          : prevBet.toString() == row3Bet.toString()
                              ? ['Row3']
                              : prevBet));
          currentBets.addAll(bets);
          // updateWalletOnBet(totalBetsAmount);

          return true;
        } else {
          Provider.of<MyVariableModel>(context, listen: false)
              .updateInsuff(true);
          return false;
        }
      } else {
        return false;
      }
    }
    return false;
  }

  num getTotalAmtForDigit(num digit) {
    num totalAmt = 0;

    for (var bet in rouletteBets) {
      if (bet.digit == digit) {
        totalAmt += bet.amt;
      }
    }

    return totalAmt;
  }

  void spinRoulette(
    BuildContext context,
    String phone,
    int multiplier,
  ) async {
    updateUndoClick(true);

    await moneyStarMethods.updateWallet(
      amount: (totalBalance.toString()),
      phone: phone,
    );

    // List<GetResults> resultsData = await moneyStarMethods.getResults();
    // Result result = resultsData[0].result;
    Result result = Result.lost;

    // Update wallet balance

    // Get a list of all digits that have been bet on
    List<String> betDigits = rouletteBets.map((bet) {
      int digit = bet.digit.toInt();
      // Convert 37 to "00" and 38 to "0"
      if (digit == 37) {
        return "00";
      } else if (digit == 38) {
        return "0";
      }
      return digit.toString();
    }).toList();

    logPrint("bro $betDigits");

    if (result == Result.won) {
      // If it's a win, logPrint a random number from the bet digits
      math.Random random = math.Random();
      int randomIndex = random.nextInt(rouletteBets.length);

      await Future.delayed(const Duration(seconds: 6));

      updateLastWinningNumber(rouletteBets[randomIndex].digit.toString());
      final num amountToAdd = () {
        // Retrieve the digit from the rouletteBets list
        int digit = rouletteBets[randomIndex].digit.toInt();

        // Determine the multiplier
        int currentMultiplier = multiplier;

        // If multiplier is 35 and digit is either 0 or 38, set the multiplier to 70
        if (currentMultiplier == 35 && (digit == 0 || digit == 38)) {
          currentMultiplier = 70;
        }

        // Calculate the amount to add
        return getTotalAmtForDigit(digit) * currentMultiplier;
      }();
      addTotalBalance(amountToAdd);
      moneyStarMethods.updateWallet(
        amount: totalBalance.toString(),
        phone: phone,
      );
      final result = rouletteBets[randomIndex].digit.toInt() == 37
          ? "00"
          : rouletteBets[randomIndex].digit.toInt() == 38
              ? "0"
              : rouletteBets[randomIndex].digit.toString();

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return ResultDialog(
                result: result.toString(),
                won: true,
                points: amountToAdd.toInt());
          });
      lastBets.add(result);
      updateBallPlace(result);

      Provider.of<MyVariableModel>(context, listen: false).updateScaffoldKey();
      logPrint("Winning number: ${rouletteBets[randomIndex].digit}");
      Provider.of<MyVariableModel>(context, listen: false).updateAllKeys();
      Provider.of<MyVariableModel>(context, listen: false).updateScaffoldKey();
      Provider.of<RouletteApi>(context, listen: false).resetBet();
      Provider.of<MyVariableModel>(context, listen: false).clearPrevBet();

      Provider.of<MyVariableModel>(context, listen: false)
          .convertPlacedBetsToPreviousBet();
      Provider.of<MyVariableModel>(context, listen: false).placedBets.clear();
    } else {
      // If it's not a win
      List<String> allPossibleDigits =
          List.generate(37, (index) => index.toString()); // Digits "0" to "36"

// Add "00" to the list of all possible digits
      if (multiplier == 36) {
        log("bro addning");
        allPossibleDigits.add("37");
      }

// Convert "37" to "00" and "38" to "0"
      allPossibleDigits = allPossibleDigits.map((digit) {
        if (digit == "37") {
          return "00";
        } else if (digit == "38") {
          return "0";
        }
        return digit;
      }).toList();

// Remove any bet digits from the list of all possible digits
      allPossibleDigits.removeWhere((digit) => betDigits.contains(digit));

      if (allPossibleDigits.isEmpty) {
        log(" bro  all is empty");
        rouletteBets.sort((a, b) => a.amt.compareTo(b.amt));
        await Future.delayed(const Duration(seconds: 6));
        final result = rouletteBets.first.digit.toInt().toString() == "37"
            ? "00"
            : rouletteBets.first.digit.toInt().toString() == "38"
                ? "0"
                : rouletteBets.first.digit.toInt().toString();

        updateLastWinningNumber(rouletteBets.first.digit.toString());
        updateBallPlace(rouletteBets.first.digit.toString());
        final num amountToAdd = (rouletteBets.first.amt * multiplier);
        addTotalBalance(amountToAdd);
        moneyStarMethods.updateWallet(
          amount: totalBalance.toString(),
          phone: phone,
        );
        lastBets.add(rouletteBets.first.digit.toString());
        updateBallPlace(rouletteBets.first.digit.toString());

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return ResultDialog(
                  result: result.toString(),
                  won: true,
                  points: amountToAdd.toInt());
            });

        Provider.of<MyVariableModel>(context, listen: false)
            .updateScaffoldKey();
        logPrint(
            "Non-winning number with lowest bet amount: ${rouletteBets.first.digit}");
        Provider.of<MyVariableModel>(context, listen: false).updateAllKeys();
        Provider.of<MyVariableModel>(context, listen: false)
            .updateScaffoldKey();
        Provider.of<RouletteApi>(context, listen: false).resetBet();
        Provider.of<MyVariableModel>(context, listen: false).clearPrevBet();

        Provider.of<MyVariableModel>(context, listen: false)
            .convertPlacedBetsToPreviousBet();
        Provider.of<MyVariableModel>(context, listen: false).placedBets.clear();
      } else {
        log(" bro  all is not emptu");

        // If there are digits not included in the bet, logPrint a random one
        math.Random random = math.Random();
        int randomIndex = random.nextInt(allPossibleDigits.length);
        await Future.delayed(const Duration(seconds: 6));
        // updateBallPlace(allPossibleDigits[randomIndex].toString());

        updateLastWinningNumber(allPossibleDigits[randomIndex].toString());
        lastBets.add(allPossibleDigits[randomIndex].toString());

        updateBallPlace(allPossibleDigits[randomIndex] == "37"
            ? "00"
            : allPossibleDigits[randomIndex] == "38"
                ? "0"
                : allPossibleDigits[randomIndex].toString());
        final points = investedBalance;

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return ResultDialog(
                  result: allPossibleDigits[randomIndex],
                  won: false,
                  points: points.toInt());
            });

        Provider.of<MyVariableModel>(context, listen: false)
            .updateScaffoldKey();
        logPrint("Non-winning random number: ${allPossibleDigits[randomIndex]}");
        Provider.of<MyVariableModel>(context, listen: false).updateAllKeys();
        Provider.of<MyVariableModel>(context, listen: false)
            .updateScaffoldKey();
        Provider.of<RouletteApi>(context, listen: false).resetBet();
        Provider.of<MyVariableModel>(context, listen: false).clearPrevBet();

        Provider.of<MyVariableModel>(context, listen: false)
            .convertPlacedBetsToPreviousBet();
        Provider.of<MyVariableModel>(context, listen: false).placedBets.clear();
      }
    }
    _saveData();
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList('lastBets', lastBets);
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lastBets = prefs.getStringList('lastBets') ?? [];

    notifyListeners();
  }
}
