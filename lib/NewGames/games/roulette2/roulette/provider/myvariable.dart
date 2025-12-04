import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../main.dart';
import '../backend/newmethods.dart';
import '../lists.dart';
import '../models/bet_keys.dart';
import '../models/get_results.dart';


class LastBlockBet {
  int amount;
  String key;

  LastBlockBet({required this.amount, required this.key});
}

class PreviousBets {
  List<String> digit;
  String amount;

  PreviousBets(this.amount, this.digit);

  Map<String, dynamic> toJson() {
    return {'amount': amount, 'digit': digit};
  }

  factory PreviousBets.fromJson(Map<String, dynamic> json) {
    return PreviousBets(json['amount'], List<String>.from(json['digit']));
  }
}

class MyVariableModel extends ChangeNotifier {
  List<int> targetBets = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  bool lastRow1 = false;
  bool lastRow2 = false;
  bool lastRow3 = false;
  bool lastRow4 = false;
  bool lastRow5 = false;
  bool lastRow6 = false;
  bool lastRow7 = false;
  bool lastRow8 = false;
  bool lastRow9 = false;
  bool showInsuff = false;
  String tableBlinkValue = "90";
  bool cancelSpecific = false;
  bool rotatingWheel = false;
  bool kundiColor = false;
  bool blinkBet = false;

  bool updateKundi = false;
  bool getblocksData = false;
  int lastRowAmount1 = 0;
  int lastRowAmount2 = 0;
  int lastRowAmount3 = 0;
  int lastRowAmount4 = 0;
  int lastRowAmount5 = 0;
  int lastRowAmount6 = 0;
  int lastRowAmount7 = 0;
  int lastRowAmount8 = 0;
  int lastRowAmount9 = 0;
  int selectedCoinAmount = 10;
  double targetValue = 0.0;
  bool wheelZoom = false;
  bool acceptBet = false;
  bool showInvestedAmount = false;
  String lastBetKey = "";
  bool targetPrevBetSwitch = false;
  bool hideWheel = false;
  bool hideBlink = true;
  List<PreviousBets> placedBets = [];
  List<PreviousBets> targetPrevBet = [];

  List<PreviousBets> previousBets = [];
  List<PreviousBets> currentBet = [];
  List<BetKeys> keys = [];
  List emptyBets = [];

  int? specificBet;

  LastBlockBet? specificBlockBet;

  bool showAmusementMessage = false;

  // Initialize keys with default keys

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> textKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> wheelKey = GlobalKey<ScaffoldState>();

  String winAmount = "0";
  List<Last5Results> lastResults = [];
  List<Last5Results> lastTargetResults = [];

  int get coinAmount => selectedCoinAmount;
  bool showBlink = false;
  Uint8List? _imageData;
  Uint8List? get imageData => _imageData;
  Uint8List? _homeSecondImage;
  Uint8List? get homeSecondImage => _homeSecondImage;
  String investedAmount = "0";
  addBet(PreviousBets bet) {
    try {
      placedBets.add(bet);
      placedBets.length == 1 ? resetAllBlocks() : null;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void placeBetForSavedRound(List<PreviousBets> bets) {
    currentBet.clear();
    currentBet.addAll(bets);
    convertCurrentBetToPreviousBet();
    notifyListeners();
  }

  void clearEveryThing() {
    placedBets.clear();
    previousBets.clear();
    currentBet.clear();
    emptyBets.clear();
    // targetBets.clear();
    notifyListeners();
  }

  void initializeKeys() {
    List totalBets = [];
    totalBets.addAll(numbers);
    totalBets.addAll(firstSetDoubleNumberBets);
    totalBets.addAll(secondSetDoubleNumberBets);
    totalBets.addAll(fourBetData);
    totalBets.addAll(streetBet);
    totalBets.addAll(sixLineBet);
    totalBets.addAll(zeroRangeBet);

    keys = List.generate(
        totalBets.length, (index) => BetKeys(GlobalKey(), totalBets[index]));
    notifyListeners();
  }

  void updateAllKeys() {
    List<BetKeys> updatedKeys = [];

    for (int i = 0; i < keys.length; i++) {
      // Create new GlobalKey instance and keep the associated data unchanged
      GlobalKey newKey = GlobalKey();
      updatedKeys.add(BetKeys(newKey, keys[i].bet));
    }

    // Replace the keys list with the updated keys list
    keys = updatedKeys;

    // Notify listeners after updating all keys
    notifyListeners();
  }

  convertPlacedBetsToPreviousBet() {
    try {
      Map<String, PreviousBets> digitMap = {};
      for (var bet in placedBets) {
        log(bet.digit.toString());
        bet.digit.sort();
        String key = bet.digit.toString(); // Use sorted digits list as key
        if (digitMap.containsKey(key)) {
          digitMap[key]!.amount =
              (num.parse(digitMap[key]!.amount) + num.parse(bet.amount))
                  .toString();
        } else {
          digitMap[key] = PreviousBets(bet.amount, List.from(bet.digit));
        }
      }
      currentBet = digitMap.values.toList();
      placedBets.clear();
      notifyListeners();
    } catch (e, stackTrace) {
      // Handle the exception here, you can log it or take appropriate action
      log('An error occurred: $e\n$stackTrace');
      // You may also rethrow the exception if needed
      // rethrow;
    }
  }

  updateSpecific(bool newValue) {
    cancelSpecific = newValue;
    notifyListeners();
  }

  updateKundiVar(bool newValue) {
    updateKundi = newValue;
    notifyListeners();
  }

  updateInsuff(bool newValue) {
    showInsuff = newValue;
    notifyListeners();
  }

  updateTableBlinkValue({String? value}) async {
    await updateLastResults();
    tableBlinkValue = value ?? lastResults.last.result;
    notifyListeners();
  }

  updateTableBlinkValueTarget() async {
    await updateLastTargetResults();
    tableBlinkValue = lastTargetResults.last.result;
    notifyListeners();
  }

  updateKundiColor() {
    kundiColor = !kundiColor;
    notifyListeners();
  }

  convertPlacedToPreviousInTarget() {
    targetPrevBet = List.from(placedBets);
    placedBets.clear();
    notifyListeners();
  }

  targetPrevBetData() {
    placedBets = List.from(targetBets);
    targetBets.clear();
    notifyListeners();
  }

  resetTargetBets() {
    targetBets.clear();
    notifyListeners();
  }

  resetPlacedBets() {
    placedBets.clear();
    notifyListeners();
  }

  updateTargetBets(List<int> newBets) {
    targetBets = List.from(newBets);
    notifyListeners();
  }

  convertCurrentBetToPreviousBet() {
    previousBets = List.from(currentBet);
    placedBets = List.from(currentBet);

    currentBet.clear();
    updateAllKeys();
    updateScaffoldKey();
    notifyListeners();
    log("sending length");
    log(previousBets.length.toString());
  }

  void resetAllBlocks() {
    lastRow1 = false;
    lastRowAmount1 = 0;

    lastRow2 = false;
    lastRowAmount2 = 0;

    lastRow3 = false;
    lastRowAmount3 = 0;

    lastRow4 = false;
    lastRowAmount4 = 0;

    lastRow5 = false;
    lastRowAmount5 = 0;

    lastRow6 = false;
    lastRowAmount6 = 0;

    lastRow7 = false;
    lastRowAmount7 = 0;

    lastRow8 = false;
    lastRowAmount8 = 0;

    lastRow9 = false;
    lastRowAmount9 = 0;

    notifyListeners();
  }

  cancelSpecificBlockBet() {
    if (specificBlockBet != null) {
      log(specificBlockBet!.key);
      if (specificBlockBet!.key == "lastRow1") {
        lastRow1 = false;
        lastRowAmount1 = 0;
      } else if (specificBlockBet!.key == "lastRow2") {
        lastRow2 = false;
        lastRowAmount2 = 0;
      } else if (specificBlockBet!.key == "lastRow3") {
        lastRow3 = false;
        lastRowAmount3 = 0;
      } else if (specificBlockBet!.key == "lastRow4") {
        lastRow4 = false;
        lastRowAmount4 = 0;
      } else if (specificBlockBet!.key == "lastRow5") {
        lastRow5 = false;
        lastRowAmount5 = 0;
      } else if (specificBlockBet!.key == "lastRow6") {
        lastRow6 = false;
        lastRowAmount6 = 0;
      } else if (specificBlockBet!.key == "lastRow7") {
        lastRow7 = false;
        lastRowAmount7 = 0;
      } else if (specificBlockBet!.key == "lastRow8") {
        lastRow8 = false;
        lastRowAmount8 = 0;
      } else if (specificBlockBet!.key == "lastRow9") {
        lastRow9 = false;
        lastRowAmount9 = 0;
      }
    }
    notifyListeners();
  }

  void cancelSpecificBet() {
    final lastBet = placedBets.last;
    if (specificBlockBet != null) {
      log("going for block");

      cancelSpecificBlockBet();
    } else {
      log("going for number");
      log(lastBet.digit.toString());
      log(keys.length.toString());
      log(placedBets.length.toString());
      final index = keys.indexWhere(
          (element) => lastBet.digit.toString() == element.bet.toString());
      log(index.toString());

      BetKeys key = keys[index];
      log(key.bet.toString());
      key.key = Key(UniqueKey().toString());
    }
    updateScaffoldKey();
    updateBlocksData(true);

    notifyListeners();
  }

  // clearPlacedBets() {
  //   placedBets.clear();
  //   notifyListeners();
  // }

  void updateVariable(int newValue) {
    selectedCoinAmount = newValue;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateTargetPrevSwitch(bool newValue) {
    targetPrevBetSwitch = newValue;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void targetWheel(bool newVal) {
    rotatingWheel = newVal;

    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void stopUpdatingInvestedAmount(bool newValue) {
    showInvestedAmount = newValue;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateBlink(bool newValue) {
    hideBlink = newValue;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateWheelVisiblity(bool newValue) {
    hideWheel = newValue;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateBlintBet(bool newValue) {
    blinkBet = newValue;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateTargetValue(num newValue) {
    targetValue = (10 - newValue) / 10;
    log(targetValue.toString());
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateSpecificBlockBet(LastBlockBet? newValue) {
    specificBlockBet = newValue;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateBlinkValue(bool val) {
    showBlink = val;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateBlocksData(bool val) {
    getblocksData = val;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  Future<void> updateLastResults() async {
    // lastResults = await lastRoundResults("Roulette");
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  Future<void> updateLastTargetResults() async {
    // lastTargetResults = await lastRoundResults("FunTarget");
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateLastBetKey(String key) async {
    lastBetKey = key;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateWheelZoom() {
    if (showInvestedAmount) {
      wheelZoom = !wheelZoom;
      notifyListeners();
    }
  }

  void updateInvestedAmount(String amount) {
    investedAmount = amount;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateBetStatus(bool value, {required String gameName}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (value) {
      if (gameName == "FunTarget") {
        preferences.setString(
          "lastSavedRoundIdForTarget",
          getRoundId(),
        );
      } else {
        preferences.setString(
          "lastSavedRoundId",
          getRoundId(),
        );
        final List<String> serializedList = placedBets
            .map(
              (item) => json.encode(
                item.toJson(),
              ),
            )
            .toList();
        preferences.setStringList('lastSavedRoundBet', serializedList);
        preferences.setBool("lastRow1", lastRow1);
        preferences.setBool("lastRow2", lastRow2);
        preferences.setBool("lastRow3", lastRow3);
        preferences.setBool("lastRow4", lastRow4);
        preferences.setBool("lastRow5", lastRow5);
        preferences.setBool("lastRow6", lastRow6);
        preferences.setBool("lastRow7", lastRow7);
        preferences.setBool("lastRow8", lastRow8);
        preferences.setBool("lastRow9", lastRow9);
        preferences.setInt("lastRowAmount1", lastRowAmount1);
        preferences.setInt("lastRowAmount2", lastRowAmount2);
        preferences.setInt("lastRowAmount3", lastRowAmount3);
        preferences.setInt("lastRowAmount4", lastRowAmount4);
        preferences.setInt("lastRowAmount5", lastRowAmount5);
        preferences.setInt("lastRowAmount6", lastRowAmount6);
        preferences.setInt("lastRowAmount7", lastRowAmount7);
        preferences.setInt("lastRowAmount8", lastRowAmount8);
        preferences.setInt("lastRowAmount9", lastRowAmount9);
      }
    } else {
      preferences.clear();
    }
    acceptBet = value;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateAmusement(bool value) {
    showAmusementMessage = value;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateWinAmount(String newValue, loginId) {
    // updatePrevBetTake(winAmount, loginId);
    winAmount = newValue;
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateScaffoldKey() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateTextKey() {
    textKey = GlobalKey<ScaffoldState>();
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateWheelKey() {
    wheelKey = GlobalKey<ScaffoldState>();
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void clearPrevBet() {
    previousBets.clear();
    notifyListeners(); // Notifies all the listeners that a change has occurred.
  }

  void updateLastRow1(bool value, int amount) {
    lastRow1 = value;
    lastRowAmount1 = amount;
    specificBlockBet = LastBlockBet(amount: amount, key: "lastRow1");
    notifyListeners();
  }

  void updateLastRow2(bool value, int amount) {
    lastRow2 = value;
    lastRowAmount2 = amount;
    specificBlockBet = LastBlockBet(amount: amount, key: "lastRow2");

    notifyListeners();
  }

  void updateLastRow3(bool value, int amount) {
    lastRow3 = value;
    lastRowAmount3 = amount;
    specificBlockBet = LastBlockBet(amount: amount, key: "lastRow3");

    notifyListeners();
  }

  void updateLastRow4(bool value, int amount) {
    lastRow4 = value;
    lastRowAmount4 = amount;
    specificBlockBet = LastBlockBet(amount: amount, key: "lastRow4");

    notifyListeners();
  }

  void updateLastRow5(bool value, int amount) {
    lastRow5 = value;
    lastRowAmount5 = amount;
    specificBlockBet = LastBlockBet(amount: amount, key: "lastRow5");

    notifyListeners();
  }

  void updateLastRow6(bool value, int amount) {
    lastRow6 = value;
    lastRowAmount6 = amount;
    specificBlockBet = LastBlockBet(amount: amount, key: "lastRow6");

    notifyListeners();
  }

  void updateLastRow7(bool value, int amount) {
    lastRow7 = value;
    lastRowAmount7 = amount;
    specificBlockBet = LastBlockBet(amount: amount, key: "lastRow7");

    notifyListeners();
  }

  void updateLastRow8(bool value, int amount) {
    lastRow8 = value;
    lastRowAmount8 = amount;
    specificBlockBet = LastBlockBet(amount: amount, key: "lastRow8");

    notifyListeners();
  }

  void updateLastRow9(bool value, int amount) {
    lastRow9 = value;
    lastRowAmount9 = amount;
    specificBlockBet = LastBlockBet(amount: amount, key: "lastRow9");
    notifyListeners();
  }
}
