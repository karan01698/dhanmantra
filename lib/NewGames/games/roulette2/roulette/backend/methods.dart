// import 'dart:developer';

// import 'package:http/http.dart' as http;
// import 'package:money_star/models/balance.dart';
// import 'package:money_star/models/get_round.dart';
// import 'package:money_star/models/mode.dart';

// const String token = "polkhujaguarmercedez200SClass";
// const String baseUrl = "https://www.funrep.org/APIs/app.asmx/";
// const String baseUrl2 = "https://www.funrep.org/APIs/funrepweb.asmx/";

// addTransactions(
//     {required String tid,
//     required String amt,
//     required String loginid,
//     required String status}) async {
//   final url = Uri.parse(
//       "$baseUrl/AddTransactions?token=$token&tid=$tid&amt=$amt&loginid=$loginid&status=$status");
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     log('Transaction added successfully');
//   } else {
//     log('Failed to add transaction. Response: ${response.body}');
//   }
// }

// Future<void> addWallet(
//     {required String points,
//     required String loginid,
//     required String pin}) async {
//   final url = Uri.parse(
//       '$baseUrl/AddWallet?token=$token&points=$points&loginid=$loginid&pin=$pin');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     log('Wallet added successfully');
//   } else {
//     log('Failed to add wallet. Response: ${response.body}');
//   }
// }

// Future<void> createTransfer({
//   required String recieve,
//   required String transfer,
//   required String amount,
//   required String status,
//   required String currentBalance,
// }) async {
//   final link =
//       '$baseUrl2/CreateTransfer?token=$token&recieve=$recieve&transfer=$transfer&amount=$amount&status=$status&currentbalance=$currentBalance';
//   final url = Uri.parse(link);
//   final response = await http.get(url);
//   logPrint(link);
//   if (response.statusCode == 200) {
//     log(response.body);
//     logPrint('Create Transfer Successful');
//   } else {
//     logPrint('Create Transfer failed. Response: ${response.body}');
//   }
// }

// Future<void> createAccount(
//     {required String loginid,
//     required String pass,
//     required String pin,
//     required String ph,
//     required String name}) async {
//   final url = Uri.parse(
//       '$baseUrl/CreateAccount?token=$token&loginid=$loginid&Pass=$pass&pin=$pin&ph=$ph&name=$name');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     log('Account created successfully');
//   } else {
//     log('Failed to create account. Response: ${response.body}');
//   }
// }

// Future<void> displayOneDevice({required String loginid}) async {
//   final url =
//       Uri.parse('$baseUrl/DisplayOneDevice?token=$token&loginid=$loginid');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     log('Display one device success');
//   } else {
//     log('Failed to display one device. Response: ${response.body}');
//   }
// }

// Future<void> displayTransaction({required String loginid}) async {
//   final url =
//       Uri.parse('$baseUrl/DisplayTransaction?token=$token&loginid=$loginid');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     log('Display transaction success');
//   } else {
//     log('Failed to display transaction. Response: ${response.body}');
//   }
// }

// // Future<void> displayWallet({required String loginid}) async {
// //   final url = Uri.parse('$baseUrl/DisplayWallet?token=$token&loginid=$loginid');
// //   final response = await http.get(url);

// //   if (response.statusCode == 200) {
// //     log('Display wallet success');
// //   } else {
// //     log('Failed to display wallet. Response: ${response.body}');
// //   }
// // }

// Future<void> oneDeviceCount(
//     {required String loginid, required String imei}) async {
//   final url = Uri.parse(
//       '$baseUrl/OneDeviceCount?token=$token&loginid=$loginid&IMEI=$imei');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     log('One device count success');
//   } else {
//     log('Failed to get one device count. Response: ${response.body}');
//   }
// }

// Future<List<Balance>> getPoints({required String loginid}) async {
//   final url = Uri.parse('$baseUrl2/GetPoints?token=$token&loginid=$loginid');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     return balanceFromMap(response.body);
//   } else {
//     log('Login failed. Response: ${response.body}');
//     throw "cannot load transactions";
//   }
// }

// Future<void> oneDeviceLogin(
//     {required String loginid, required String imei}) async {
//   final url = Uri.parse(
//       '$baseUrl/OneDeviceLogin?token=$token&loginid=$loginid&IMEI=$imei');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     log('One device login success');
//   } else {
//     log('One device login failed. Response: ${response.body}');
//   }
// }

// Future<void> oneDeviceUpdate(
//     {required String loginid, required String imei}) async {
//   final url = Uri.parse(
//       '$baseUrl/OneDeviceUpdate?token=$token&loginid=$loginid&IMEI=$imei');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     log('One device update success');
//   } else {
//     log('Failed to update one device. Response: ${response.body}');
//   }
// }

// // Future<void> placeBet({
// //   required String token,
// //   required String roundid,
// //   required String points,
// //   required String gamename,
// //   required String betamt,
// //   required String x,
// //   required String digit,
// //   required String betStatus,
// //   required String result,
// //   required String loginID,
// // }) async {
// //   final url = Uri.parse(
// //       '$baseUrl/PlaceBet?token=$token&roundid=$roundid&points=$points&gamename=$gamename&betamt=$betamt&x=$x&digit=$digit&betStatus=$betStatus&result=$result&loginID=$loginID');
// //   final response = await http.get(url);

// //   if (response.statusCode == 200) {
// //     log('Bet placed successfully');
// //   } else {
// //     log('Failed to place bet. Response: ${response.body}');
// //   }
// // }

// // Future<void> updateBet({
// //   required String token,
// //   required String roundid,
// //   required String loginid,
// //   required String betstatus,
// // }) async {
// //   final url = Uri.parse(
// //       '$baseUrl/UpdateBet?token=$token&roundid=$roundid&loginid=$loginid&betstatus=$betstatus');
// //   final response = await http.get(url);

// //   if (response.statusCode == 200) {
// //     log('Bet updated successfully');
// //   } else {
// //     log('Failed to update bet. Response: ${response.body}');
// //   }
// // }

// Future<void> updateRoundResult({
//   required String token,
//   required String gamename,
//   required String roundstatus,
//   required String result,
// }) async {
//   final url = Uri.parse(
//       '$baseUrl/UpdateRoundResult?token=$token&gamename=$gamename&roundstatus=$roundstatus&result=$result');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     log('Round result updated successfully');
//   } else {
//     log('Failed to update round result. Response: ${response.body}');
//   }
// }

// Future<void> updateTransaction({required String loginid}) async {
//   final url =
//       Uri.parse('$baseUrl/UpdateTransaction?token=$token&loginid=$loginid');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     log('Transaction update success');
//   } else {
//     log('Failed to update transaction. Response: ${response.body}');
//   }
// }

// Future<List<GetRound>> getRounds(String gameName) async {
//   http.Response response = await http.get(
//     Uri.parse('$baseUrl/GETRound?token=$token&gamename=$gameName'),
//   );

//   if (response.statusCode == 200) {
//     return getRoundFromMap(response.body);
//   } else {
//     log("error while getting rounds from api");
//     throw '';
//   }
// }

// // https://funrep.org/APIs/App.asmx/GETRoundCompleted?token=polkhujaguarmercedez200SClass&gamename=Roulette&roundid=999390479

// // Future<List<GetResults>> getResults(String roundId) async {
// //   http.Response response = await http.get(
// //     Uri.parse('$baseUrl/GetResult?token=$token&roundid=$roundId'),
// //   );

// //   if (response.statusCode == 200) {
// //     return getResultsFromMap(response.body);
// //   } else {
// //     log("error while getting results from api");
// //     throw '';
// //   }
// // }

// // Future<List<GetResults>> getLast10RoundsResult(String gameName) async {
// //   http.Response response = await http.get(
// //     Uri.parse('$baseUrl/Last10RoundResults?token=$token&gamename=$gameName'),
// //   );

// //   if (response.statusCode == 200) {
// //     return getResultsFromMap(response.body);
// //   } else {
// //     log("error while getting results from api");
// //     throw '';
// //   }
// // }

// Future<List<Mode>> getModes(String gameName) async {
//   http.Response response = await http.get(
//     Uri.parse('$baseUrl/Mode?token=$token'),
//   );

//   if (response.statusCode == 200) {
//     return getModeFromMap(response.body);
//   } else {
//     log("error while getting mode from api");
//     throw '';
//   }
// }
