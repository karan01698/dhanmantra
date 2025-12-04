// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';
// import 'dart:developer';
// // import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
// import 'package:money_star/backend/methods.dart';
// import 'package:money_star/models/get_results.dart';
// import 'package:money_star/models/get_round.dart';
// import 'package:money_star/models/prev_bet.dart';
// import 'package:money_star/models/roulette_bet.dart';
// import 'package:money_star/models/target_bets.dart';
// import 'package:money_star/provider/audio.dart';
// import 'package:money_star/provider/myvariable.dart';
// import 'package:money_star/provider/roulette_api.dart';
// import 'package:provider/provider.dart';

// Future<void> cancelBet(String gamename, String loginId) async {
//   final time = getRoundId();
//   final url = Uri.parse(
//       '$baseUrl/CancelBet?token=$token&gamename=$gamename&time=$time&id=$loginId');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     logPrint('Bet canceled successfully');
//   } else {
//     logPrint('Failed to cancel bet. Response: ${response.body}');
//   }
// }

// Future<void> updatePrevBetTake(String amount, String loginId) async {
//   final url = Uri.parse(
//       '$baseUrl/UpdatePrevBet?token=$token&amount=$amount&gameid=$loginId');
//   final response = await http.get(url);
//   log(url.toString());
//   if (response.statusCode == 200) {
//     logPrint('Bet taken successfully');
//   } else {
//     logPrint('Failed to cancel bet. Response: ${response.body}');
//   }
// }

// getLastRoundId() {
//   DateTime nextMinute = DateTime.now();
//   // DateTime nextMinute = now.add(const Duration(minutes: 1));
//   nextMinute = nextMinute.subtract(Duration(seconds: nextMinute.second));

//   // Removing seconds component from the DateTime
//   DateTime nextMinuteWithoutSeconds = DateTime(
//     nextMinute.year,
//     nextMinute.month,
//     nextMinute.day,
//     nextMinute.hour,
//     nextMinute.minute,
//   );
//   return nextMinuteWithoutSeconds.toString();
// }

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

// Future<void> cancelSpecificBet(
//     BuildContext context, String gamename, String loginId) async {
//   final invested =
//       Provider.of<MyVariableModel>(context, listen: false).investedAmount;
//   final time = getRoundId();

//   final url = Uri.parse(
//       '$baseUrl/CancelSpecificBet?token=$token&gamename=$gamename&time=$time&id=$loginId&invested=$invested');
//   final response = await http.get(url);
//   log(url.toString());
//   log(response.body);

//   if (response.statusCode == 200) {
//     logPrint('Specific bet canceled successfully');
//   } else {
//     logPrint('Failed to cancel specific bet. Response: ${response.body}');
//   }
// }

// Future<void> createRound() async {
//   final url = Uri.parse('$baseUrl/CreateRound?token=$token');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     logPrint('Round created successfully');
//   } else {
//     logPrint('Failed to create round. Response: ${response.body}');
//   }
// }

// Future<List<GetRound>> getCompletedRound(String gameName, String gameId) async {
//   http.Response response = await http.get(
//     Uri.parse(
//         '$baseUrl/GETRoundCompleted?token=$token&gamename=$gameName&roundid=$gameId'),
//   );

//   log(gameId);
//   if (response.statusCode == 200) {
//     return getRoundFromMap(response.body);
//   } else {
//     log("error while getting rounds from api");
//     throw '';
//   }
// }

// Future<List<PrevBetModel>> displayPrevRound(String gameId) async {
//   http.Response response = await http.get(
//     Uri.parse('$baseUrl/DisplayPrevBet?token=$token&gameid=$gameId'),
//   );

//   log(gameId);
//   if (response.statusCode == 200) {
//     return prevBetModelFromMap(response.body);
//   } else {
//     log("error while getting rounds from api");
//     throw '';
//   }
// }

// Future<String> getWiningAmountPending(
//     BuildContext context, String gamename, String loginid,
//     {String? roundId, String? result}) async {
//   if (int.parse(
//           Provider.of<MyVariableModel>(context, listen: false).winAmount) ==
//       0) {
//     final time = roundId ?? getLastRoundId();
//     final digit = result ?? await getResult(gamename, time);
//     if (gamename == "FunTarget") {
//       final url = Uri.parse(
//           '$baseUrl/GETWiningAmountPending?token=$token&gamename=$gamename&loginid=$loginid&time=$time&digit=${digit == "0" ? "10" : digit}');
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body)["message"];
//         return data.toString() == "null" ? "0" : data.toString();
//       } else {
//         throw ('Failed to get winning amount. Response: ${response.body}');
//       }
//     } else {
//       final finalDigit = digit == "0"
//           ? "38"
//           : digit == "00"
//               ? "37"
//               : digit;
//       final url = Uri.parse(
//           '$baseUrl/GETWiningAmountPending?token=$token&gamename=$gamename&loginid=$loginid&time=$time&digit=$finalDigit');
//       final response = await http.get(url);
//       logPrint(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body)["message"];
//         return data.toString() == "null" ? "0" : data.toString();
//       } else {
//         throw ('Failed to get winning amount. Response: ${response.body}');
//       }
//     }
//   }
//   log("getwin");
//   return Provider.of<MyVariableModel>(context, listen: false).winAmount;
// }

// Future<String> getResult(String gamename, String time) async {
//   final url = Uri.parse(
//       '$baseUrl/GetResultNew?token=$token&time=$time&Gamename=$gamename&type=app');
//   final response = await http.get(url);
//   log(url.toString());
//   if (response.statusCode == 200) {
//     final msg = jsonDecode(response.body)["message"];
//     // log("sending msg");
//     // log(msg);
//     if (msg == 38) {
//       return "0";
//     } else if (msg == 37 || msg == 00) {
//       return "00";
//     } else {
//       return msg.toString();
//     }
//   } else {
//     throw ('Failed to get winning amount. Response: ${response.body}');
//   }
// }

// Future<String> getTargetResult() async {
//   final time = getRoundId();
//   final url = Uri.parse(
//       '$baseUrl/GetResultNew?token=$token&time=$time&Gamename=FunTarget&type=app');
//   final response = await http.get(url);
//   // logPrint(url);
//   if (response.statusCode == 200) {
//     final msg = jsonDecode(response.body)["message"];
//     if (msg == 10) {
//       return "0";
//     } else {
//       return msg.toString();
//     }
//   } else {
//     throw ('Failed to get winning amount. Response: ${response.body}');
//   }
// }

// Future<bool> checkUpdatedOrNot(String loginid) async {
//   final url =
//       Uri.parse('$baseUrl2/CheckRoundResultStatus?token=$token&id=$loginid');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body)["message"];

//     // log("data = $data, id = $loginid");
//     return data.toString() == "Updated" ? true : false;
// // log("sending update = ")
//   } else {
//     throw ('Failed to get winning amount. Response: ${response.body}');
//   }
//   // return false;
// }

// Future<String> getBetAmountforSavedBet(
//     BuildContext context, String gamename, String loginid, String time) async {
//   // await Future.delayed(const Duration(seconds: 3));

//   final roundId = time;
//   final url = Uri.parse(
//       '$baseUrl/GETBETAMOUNTS?token=$token&gamename=$gamename&roundid=$roundId&loginid=$loginid');
//   final response = await http.get(url);
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body)["message"];
//     log(data.toString());
//     if (gamename == "FunTarget") {
//       Provider.of<MyVariableModel>(context, listen: false)
//           .updateInvestedAmount((data.toString()));
//     } else {
//       Provider.of<RouletteApi>(context, listen: false)
//           .addInvestedBalance(num.parse(data.toString()));
//     }

//     return data.toString();
//   } else {
//     throw ('Failed to get winning amount. Response: ${response.body}');
//   }
// }

// Future<String> getBetAmount(
//     BuildContext context, String gamename, String loginid,
//     {String? time}) async {
//   // await Future.delayed(const Duration(seconds: 3));
//   if (!Provider.of<MyVariableModel>(context, listen: false)
//       .showInvestedAmount) {
//     return "0";
//   } else {
//     final roundId = time ?? getRoundId();
//     final url = Uri.parse(
//         '$baseUrl/GETBETAMOUNTS?token=$token&gamename=$gamename&roundid=$roundId&loginid=$loginid');
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body)["message"];
//       // log(data);
//       Provider.of<MyVariableModel>(context, listen: false)
//           .updateInvestedAmount(data.toString());
//       return data.toString();
//     } else {
//       throw ('Failed to get winning amount. Response: ${response.body}');
//     }
//   }
// }

// Future<String?> getPrevBetAmount(
//   BuildContext context,
//   String betOn,
//   String loginid,
// ) async {
//   final roundId = getLastRoundId();
//   final url = Uri.parse(
//       '$baseUrl/GetRoundResultAmountFunTarget?token=$token&beton=$betOn&userid=$loginid&time=$roundId');
//   final response = await http.get(url);
//   log(url.toString());
//   log(response.body);
//   if (response.statusCode == 200) {
//     final jsonData = jsonDecode(response.body);

//     if (jsonData.isNotEmpty) {
//       final data = jsonData[0]["TotalAmount"].toString();
//       return data;
//     } else {
//       // Handle the case where the response is an empty list
//       return null; // or any other default value or handle accordingly
//     }
//   } else {
//     throw ('Failed to get winning amount. Response: ${response.body}');
//   }
// }

// Future<String?> getCurrentBetAmount(
//   BuildContext context,
//   String betOn,
//   String loginid,
// ) async {
//   final roundId = getRoundId();
//   final url = Uri.parse(
//       '$baseUrl/GetRoundResultAmountFunTarget?token=$token&beton=$betOn&userid=$loginid&time=$roundId');
//   final response = await http.get(url);
//   log(url.toString());
//   log(response.body);
//   if (response.statusCode == 200) {
//     final jsonData = jsonDecode(response.body);

//     if (jsonData.isNotEmpty) {
//       final data = jsonData[0]["TotalAmount"].toString();
//       return data;
//     } else {
//       // Handle the case where the response is an empty list
//       return null; // or any other default value or handle accordingly
//     }
//   } else {
//     throw ('Failed to get winning amount. Response: ${response.body}');
//   }
// }

// Future getBetAmountTarget(
//   BuildContext context,
//   String gamename,
//   String loginid,
// ) async {
//   final myVariableModel = Provider.of<MyVariableModel>(context, listen: false);
//   if (myVariableModel.showInvestedAmount) {
//     if (int.parse(myVariableModel.winAmount) == 0) {
//       final roundId = getRoundId();
//       final url = Uri.parse(
//           '$baseUrl/GETBETAMOUNTS?token=$token&gamename=$gamename&roundid=$roundId&loginid=$loginid');
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body)["message"];
//         Provider.of<MyVariableModel>(context, listen: false)
//             .updateInvestedAmount(
//           data.toString(),
//         );
//         return data.toString();
//       } else {
//         throw ('Failed to get winning amount. Response: ${response.body}');
//       }
//     }
//   }
// }

// Future<List<Last5Results>> lastRoundResults(String gamename) async {
//   final url =
//       Uri.parse('$baseUrl/LastRoundResults?token=$token&gamename=$gamename');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     return last5ResultsFromMap(response.body);
//   } else {
//     throw ('Failed to get last round results. Response: ${response.body}');
//   }
// }

// Future<List<TargetBet>> getTargetBets(String id) async {
//   final url = Uri.parse(
//       '$baseUrl/GetTotalBetsAmountFunTarget?token=$token&Time=${getRoundId()}&userid=$id');
//   final response = await http.get(url);
//   log(response.body);
//   log(url.toString());

//   if (response.statusCode == 200) {
//     return targetBetFromMap(response.body);
//   } else {
//     throw ('Failed to get last round results. Response: ${response.body}');
//   }
// }

// Future<List<TargetBet>> getTargetBetsForSpeceficRound(
//     String id, String time) async {
//   final url = Uri.parse(
//       '$baseUrl/GetTotalBetsAmountFunTarget?token=$token&Time=$time&userid=$id');
//   final response = await http.get(url);
//   log(response.body);
//   log(url.toString());

//   if (response.statusCode == 200) {
//     return targetBetFromMap(response.body);
//   } else {
//     throw ('Failed to get last round results. Response: ${response.body}');
//   }
// }

// Future newBetsApi(
//   BuildContext context, {
//   required String userId,
// }) async {
//   final url = Uri.parse('$baseUrl/NewBetsAPI');

//   final json = rouletteBetToMap(
//       Provider.of<RouletteApi>(context, listen: false).rouletteBets);

//   final totalAmt = Provider.of<RouletteApi>(context, listen: false)
//       .rouletteBets
//       .fold(0, (num sum, bet) => sum + bet.amt);
//   final requestBody = {
//     "token": token,
//     "userid": userId,
//     "date": getRoundId(),
//     "json": json,
//     "totalamt": totalAmt.toString(),
//     "gamename": "roulette",
//   };
//   final response = await http.post(
//     url,
//     body: requestBody,
//   );
//   if (response.statusCode == 200) {
//     log("yess bet is done");
//   }
// }

// Future<bool> placeBet(
//     BuildContext context,
//     String gamename,
//     String betamt,
//     String x,
//     List<String> digits,
//     String loginID,
//     int currentBetAmount,
//     String digitStatus,
//     {bool isZero = false,
//     bool isTarget = false}) async {
//   log(digits.toString());
//   if (Provider.of<MyVariableModel>(context, listen: false).winAmount == "0") {
//     // final audioPlayer = AudioManager.getInstance();

//     Future<void> playAudio() async {
//       final audioProvider = Provider.of<AudioProvider>(context, listen: false);

//       audioProvider.playOneTimeAudioWithoutStopping("audio/bet_placed.mp3");
//     }

//     if (Provider.of<MyVariableModel>(context, listen: false).acceptBet ||
//         currentBetAmount + int.parse(betamt) > 5001) {
//       return false;
//     } else {
//       List<Map<String, dynamic>> jsonList = digits.map((digit) {
//         return {
//           'Digit': digit == "0"
//               ? "38"
//               : digit == "00"
//                   ? "37"
//                   : digit
//         };
//       }).toList();
//       final roundid = getRoundId();
//       String amt = betamt;
//       String status = digits[0].contains("Row") ? "Block" : digitStatus;

//       if (digits.contains("100")) {
//         status = "100";
//       }
//       if (digits.length == 3) {
//         status = "3";
//       }
//       if (digits.length == 6) {
//         status = "6";
//       }
//       if (digits.length == 2) {
//         status = "2";
//       }
//       if (digits.length == 4) {
//         status = "4";
//       }
//       if (status == "Number" ||
//           status == "3" ||
//           status == "6" ||
//           status == "2" ||
//           status == "4") {
//         log(amt);
//         amt = (num.parse(amt) / digits.length).toString();
//       } else {
//         if (x == "3") {
//           amt = (num.parse(betamt) / 12).toString();
//         } else if (x == "2") {
//           amt = (num.parse(betamt) / 18).toString();
//         } else if (digits[0].contains("Row")) {
//           amt = (num.parse(betamt) / 12).toString();
//         }
//       }

//       final url = Uri.parse('$baseUrl/NewRound');
//       log(status);

//       Map<String, dynamic> requestBody = {
//         'token': token,
//         'json': digits.contains("100")
//             ? '[{digit:"0"},{digit:"00"}]'
//             : status == "Number" ||
//                     status == "3" ||
//                     status == "6" ||
//                     status == "2" ||
//                     status == "4"
//                 ? jsonList.toString()
//                 : digits[0],
//         'userid': loginID,
//         'time': roundid,
//         'gamename': gamename,
//         'amt': amt,
//         'x': isTarget ? "9" : '36',
//         'digitstatus': status,
//         "totalamt":
//             (Provider.of<MyVariableModel>(context, listen: false).coinAmount <=
//                     5000)
//                 ? Provider.of<MyVariableModel>(context, listen: false)
//                     .coinAmount
//                     .toString()
//                 : "0",
//       };
//       log(requestBody.toString());

//       final response = await http.post(
//         url,
//         body: requestBody,
//       );
//       // audioPlayer.dispose();
//       log(response.body);
//       // log(message)

//       if (response.statusCode == 200) {
//         final msg = jsonDecode(response.body)["message"];
//         if (msg == "Successfully Inserted!") {
//           playAudio();

//           Provider.of<MyVariableModel>(context, listen: false)
//               .updateInsuff(false);
//           Provider.of<MyVariableModel>(context, listen: false)
//               .addBet(PreviousBets(betamt, digits));
//           Provider.of<MyVariableModel>(context, listen: false)
//               .updateSpecificBlockBet(null);

//           log("sending amt");
//           log(amt);
//           return true;
//         } else {
//           Provider.of<MyVariableModel>(context, listen: false)
//               .updateInsuff(true);
//           return false;
//         }
//       } else {
//         logPrint('Failed to place bet. Response: ${response.body}');
//         return false;
//       }
//     }
//   }
//   return false;
// }

// Future<void> updateBetStatus(
//     String loginid, String betstatus, String gamename, String roundId) async {
//   final url = Uri.parse(
//       '$baseUrl/UpdateBetStatus?token=$token&loginid=$loginid&betstatus=$betstatus&gamename=$gamename&roundid=$roundId');
//   final response = await http.get(url);
//   if (response.statusCode == 200) {
//     log(response.body);
//     logPrint('Bet status updated successfully');
//   } else {
//     logPrint('Failed to update bet status. Response: ${response.body}');
//   }
// }

// getLastRoundInvestingAmount(String loginid) async {
//   final roundId = getLastRoundId();
//   final url = Uri.parse(
//       '$baseUrl/GETBETAMOUNTS?token=$token&gamename=Roulette&roundid=$roundId&loginid=$loginid');
//   final response = await http.get(url);
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body)["message"];

//     return data.toString();
//   } else {
//     throw ('Failed to get winning amount. Response: ${response.body}');
//   }
// }

// Future<bool> placePreviousBet(
//   BuildContext context,
//   String loginid,
//   String gamename,
// ) async {
//   final lastRoundId = getLastRoundId();
//   final roundId = getRoundId();

//   final url = Uri.parse(
//       '$baseUrl/prevbet?token=$token&oldtime=$lastRoundId&gamename=$gamename&userid=$loginid&newtime=$roundId');
//   final response = await http.get(url);
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body)["message"];
//     if (data == "Insufficiant Balance!") {
//       Provider.of<MyVariableModel>(context, listen: false).updateInsuff(true);
//       return false;
//     } else {
//       return true;
//     }
//   } else {
//     // logPrint('Failed to place previous bet status. Response: ${response.body}');
//     return false;
//   }
// }

// Future<void> updateWallet({
//   required String loginid,
//   required String amount,
// }) async {
//   final url = Uri.parse(
//       '$baseUrl/UpdateWallet?token=$token&mark=Plus&login=$loginid&amount=$amount');
//   final response = await http.get(url);
//   log(url.toString());

//   if (response.statusCode == 200) {
//     log(response.body);
//   } else {
//     log('Failed to update wallet. Response: ${response.body}');
//   }
// }
