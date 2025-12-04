//
// import 'dart:async';
//
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:xml/xml.dart';
//
// // class RoomPlayerModel {
// //   final String username;
// //   final String card1;
// //   final String card2;
// //   final String card3;
// //   final String userStatus;
// //   final String seenStatus;
// //
// //   RoomPlayerModel({
// //     required this.username,
// //     required this.card1,
// //     required this.card2,
// //     required this.card3,
// //     required this.userStatus,
// //     required this.seenStatus,
// //   });
// //
// //   factory RoomPlayerModel.fromJson(Map<String, dynamic> json) {
// //     return RoomPlayerModel(
// //       username: json['Username'],
// //       card1: json['Card1'],
// //       card2: json['Card2'],
// //       card3: json['Card3'],
// //       userStatus: json['UserStatus'],
// //       seenStatus: json['SeenStatus'],
// //     );
// //   }
// // }
// //
// //
// // class RoomPlayerController extends GetxController {
// //   var playerList = <RoomPlayerModel>[].obs;
// //   var isLoading = false.obs;
// //   var roomId = "123".obs;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchRoomPlayers();
// //   }
// //
// //   Future<void> fetchRoomPlayers() async {
// //     isLoading(true);
// //     try {
// //       final url = Uri.parse('https://dhanmantragame.com/APIs/WebService1.asmx/GetRoomPlayers?roomId=${roomId.value}');
// //       final response = await http.get(url);
// //
// //       if (response.statusCode == 200) {
// //         // Extract only JSON part from SOAP-wrapped XML
// //         final start = response.body.indexOf('>') + 1;
// //         final end = response.body.lastIndexOf('<');
// //         final jsonString = response.body.substring(start, end);
// //
// //         List<dynamic> decoded = json.decode(jsonString);
// //         playerList.value = decoded.map((e) => RoomPlayerModel.fromJson(e)).toList();
// //       } else {
// //         Get.snackbar("Error", "Failed to load players");
// //       }
// //     } catch (e) {
// //       Get.snackbar("Exception", e.toString());
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// // }
//
//
// // 📦 Model
// class RoomPlayerModel {
//   final String username;
//   final String card1;
//   final String card2;
//   final String card3;
//   final String userStatus;
//   final String seenStatus;
//
//   RoomPlayerModel({
//     required this.username,
//     required this.card1,
//     required this.card2,
//     required this.card3,
//     required this.userStatus,
//     required this.seenStatus,
//   });
//
//   factory RoomPlayerModel.fromJson(Map<String, dynamic> json) {
//     return RoomPlayerModel(
//       username: json['Username'] ?? '',
//       card1: json['Card1'] ?? '',
//       card2: json['Card2'] ?? '',
//       card3: json['Card3'] ?? '',
//       userStatus: json['UserStatus'] ?? '',
//       seenStatus: json['SeenStatus'] ?? '',
//     );
//   }
// }
//
// // 🧠 Controller
// class RoomPlayerController extends GetxController {
//   var playerList = <RoomPlayerModel>[].obs;
//   var isLoading = false.obs;
//   var isGameStarting = false.obs;
//   var roomId = "TP_248953".obs; // Replace with actual dynamic ID if needed
//
//   @override
//   void onInit() {
//     super.onInit();
//     startPolling(); // Start auto-fetching players every few seconds
//   }
//
//   void startPolling() {
//     Timer.periodic(const Duration(seconds: 2), (timer) {
//       fetchRoomPlayers();
//     });
//   }
//   Future<void> fetchRoomPlayers() async {
//     isLoading(true);
//     try {
//       final url = Uri.parse(
//           'https://dhanmantragame.com/APIs/WebService1.asmx/GetRoomPlayers?roomId=${roomId.value}');
//
//       final response = await http.get(url);
//       final body = response.body.trim();
//
//       logPrint("🔵 Raw Response Body:\n$body");
//
//       // ✅ Parse XML safely
//       final xmlDoc = XmlDocument.parse(body);
//       final stringElement = xmlDoc.findAllElements('string').firstOrNull;
//
//       if (stringElement != null) {
//         final jsonString = stringElement.innerText.trim();
//         logPrint("🟢 Extracted JSON:\n$jsonString");
//
//         try {
//           final decoded = json.decode(jsonString);
//           playerList.value =
//               (decoded as List).map((e) => RoomPlayerModel.fromJson(e)).toList();
//           await checkPlayerCount();
//         } catch (jsonError) {
//           logPrint("🔴 JSON Parse Error: $jsonError");
//           Get.snackbar("Error", "JSON Parse Error: $jsonError");
//         }
//       } else {
//         logPrint("❌ <string> tag not found.");
//         Get.snackbar("Error", "SOAP <string> tag not found.");
//       }
//     } catch (e) {
//       logPrint("❌ Exception: $e");
//       Get.snackbar("Exception", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
//
//
//   Future<void> checkPlayerCount() async {
//     if (playerList.length == 5 && !isGameStarting.value) {
//       isGameStarting.value = true;
//       await Future.delayed(const Duration(seconds: 5));
//       isGameStarting.value = false;
//     }
//   }
// }
//
//
// class RoomScreen extends StatelessWidget {
//   final RoomPlayerController controller = Get.put(RoomPlayerController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Room Players")),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (controller.playerList.length < 5) {
//           return Center(child: Text("Waiting for players... (${controller.playerList.length}/5)"));
//         } else {
//           return Column(
//             children: [
//               const Text("Game Started!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: controller.playerList.length,
//                   itemBuilder: (context, index) {
//                     final player = controller.playerList[index];
//                     return ListTile(
//                       title: Text(player.username),
//                       subtitle: Text("Cards: ${player.card1}, ${player.card2}, ${player.card3}"),
//                       trailing: Text(player.seenStatus),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         }
//       }),
//     );
//   }
// }
