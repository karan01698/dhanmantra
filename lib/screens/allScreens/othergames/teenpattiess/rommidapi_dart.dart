// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:xml/xml.dart';
// import 'package:flutter/material.dart';
// // models/room_response_model.dart
// class RoomResponseModel {
//   final String status;
//   final String roomId;
//
//   RoomResponseModel({
//     required this.status,
//     required this.roomId,
//   });
//
//   factory RoomResponseModel.fromJson(Map<String, dynamic> json) {
//     return RoomResponseModel(
//       status: json['status'],
//       roomId: json['RoomID'],
//     );
//   }
// }
//
// class RoomController extends GetxController {
//   var isLoading = false.obs;
//   var roomResponse = Rxn<RoomResponseModel>();
//
//   Future<void> joinOrCreateRoom(String username, String phone) async {
//     isLoading.value = true;
//
//     final url = Uri.parse('https://dhanmantragame.com/APIs/WebService1.asmx/JoinOrCreateRoom');
//     final headers = {
//       'Content-Type': 'application/x-www-form-urlencoded',
//     };
//     final body = "username=$username&phone=$phone";
//
//     logPrint("Request Body: $body");
//     try {
//       final response = await http.post(url, headers: headers, body: body);
//
//       if (response.statusCode == 200) {
//         final xmlDoc = XmlDocument.parse(response.body);
//         final stringContent = xmlDoc.findAllElements('string').first.text;
//         logPrint("Raw Response Bodyss:\n${response.body}");
//         final jsonMap = json.decode(stringContent);
//         roomResponse.value = RoomResponseModel.fromJson(jsonMap);
//
//         final roomModel = RoomResponseModel.fromJson(jsonMap);
//         roomResponse.value = roomModel;
//
//         // ✅ Save Room ID to SharedPreferences
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('roomId', roomModel.roomId);
//       } else {
//         Get.snackbar("Error", "Failed with status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Exception", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   Future<void> joinOrCreateRooms(String username, String phone) async {
//     isLoading.value = true;
//
//     final url = Uri.parse('https://dhanmantragame.com/APIs/WebService1.asmx/JoinOrCreateRoom');
//     final headers = {
//       'Content-Type': 'application/x-www-form-urlencoded',
//     };
//     final body = "username=$username&phone=$phone";
//
//     logPrint("Request Body: $body");
//     try {
//       final response = await http.post(url, headers: headers, body: body);
//
//       if (response.statusCode == 200) {
//         final xmlDoc = XmlDocument.parse(response.body);
//         final stringContent = xmlDoc.findAllElements('string').first.text;
//         logPrint("Raw Response Body:\n${response.body}");
//         final jsonMap = json.decode(stringContent);
//         roomResponse.value = RoomResponseModel.fromJson(jsonMap);
//
//         final roomModel = RoomResponseModel.fromJson(jsonMap);
//         roomResponse.value = roomModel;
//
//         // ✅ Save Room ID to SharedPreferences
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('roomId', roomModel.roomId);
//       } else {
//         Get.snackbar("Error", "Failedss with status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Exception", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> removeUserBeforeStart(String username, String roomId) async {
//     final url = Uri.parse(
//       'https://dhanmantragame.com/APIs/WebService1.asmx/RemoveUserBeforeStart?username=$username&roomId=$roomId',
//     );
//
//     try {
//       final response = await http.get(url);
//
//       logPrint("📥 Raw response body:");
//       logPrint(response.body);
//       if (response.statusCode == 200) {
//         final xmlDoc = XmlDocument.parse(response.body);
//         final stringElement = xmlDoc.findAllElements('string').first.text;
//         final jsonMap = json.decode(stringElement);
//         final result = RemoveUserResponse.fromJson(jsonMap);
//         logPrint('userdelete ${result}');
//         if (result.status == "removed") {
//
//           Get.snackbar("✅ Success", "User removed from the room.");
//         } else {
//           Get.snackbar("⚠️ Error", "Unexpected status: ${result.status}");
//         }
//       } else {
//         Get.snackbar("❌ Error", "Failed: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("🚨 Exception", e.toString());
//     }
//   }
//
//
//
//   Future<void> forfeit(String username, String roomId) async {
//     final url = Uri.parse(
//       'https://https://dhanmantragame.com/APIs/WebService1.asmx/MarkUserAsForfeit?username=$username&roomId=$roomId',
//     );
//
//     try {
//       final response = await http.get(url);
//
//       logPrint("📥 Raw response body:");
//       logPrint(response.body);
//       if (response.statusCode == 200) {
//         final xmlDoc = XmlDocument.parse(response.body);
//         final stringElement = xmlDoc.findAllElements('string').first.text;
//         final jsonMap = json.decode(stringElement);
//         final result = RemoveUserResponse.fromJson(jsonMap);
//         logPrint('userdelete ${result}');
//         if (result.status == "removed") {
//
//           Get.snackbar("✅ Success", "User removed from the room.");
//         } else {
//           Get.snackbar("⚠️ Error", "Unexpected status: ${result.status}");
//         }
//       } else {
//         Get.snackbar("❌ Error", "Failed: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("🚨 Exception", e.toString());
//     }
//   }
// }
// class RemoveUserResponse {
//   final String status;
//
//   RemoveUserResponse({required this.status});
//
//   factory RemoveUserResponse.fromJson(Map<String, dynamic> json) {
//     return RemoveUserResponse(status: json['status']);
//   }
// }
//
