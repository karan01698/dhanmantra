// import 'package:sattagames/screens/drawer/addmoney/competions/LIveclass.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../constants/colors.dart';
// import '../allScreens/allscreens.dart';
// import '../drawer/addmoney/CompetitionDetailScreen.dart';
// import '../drawer/custom_drawer.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class MatchModelss {
//   String gameId;
//   String marketId;
//   String eventName;
//   double back1;
//   double back11;
//   double back12;
//   double lay1;
//   double lay11;
//   double lay12;
//   bool inPlay;
//   bool tv;
//   bool f;
//   int vir;
//
//   MatchModelss({
//     required this.gameId,
//     required this.marketId,
//     required this.eventName,
//     required this.back1,
//     required this.back11,
//     required this.back12,
//     required this.lay1,
//     required this.lay11,
//     required this.lay12,
//     required this.inPlay,
//     required this.tv,
//     required this.f,
//     required this.vir,
//   });
//
//   factory MatchModelss.fromJson(Map<String, dynamic> json) {
//     return MatchModelss(
//       gameId: json['gameId'],
//       marketId: json['marketId'],
//       eventName: json['eventName'],
//       back1: (json['back1'] as num).toDouble(),
//       back11: (json['back11'] as num).toDouble(),
//       back12: (json['back12'] as num).toDouble(),
//       lay1: (json['lay1'] as num).toDouble(),
//       lay11: (json['lay11'] as num).toDouble(),
//       lay12: (json['lay12'] as num).toDouble(),
//       inPlay: json['inPlay'] == "True",
//       tv: json['tv'] == "True",
//       f: json['f'] == "True",
//       vir: int.parse(json['vir']),
//     );
//   }
// }
//
// class MatchController extends GetxController {
//   int? selectedRow;
//   int? selectedColumn;
//   bool isZoomed = false;
//   var selectedGame = RxnString();
//   var selectedValue = RxnString(); // RxnString allows null values
//   TextEditingController selectedValueController = TextEditingController();
//
//   void selectCell(int row, int column, String value, String gameName) {
//     if (selectedRow == row && selectedColumn == column) {
//       cancelSelection();
//     } else {
//       selectedRow = row;
//       selectedColumn = column;
//       selectedGame.value = gameName;
//       selectedValue.value = value;
//       selectedValueController.text = value;
//     }
//     update();
//   }
//
//   void toggleZoom() {
//     isZoomed = !isZoomed;
//     update();
//   }
//
//   void cancelSelection() {
//     selectedRow = null;
//     selectedColumn = null;
//     selectedGame.value = null;
//     selectedValue.value = null;
//     selectedValueController.clear();
//     update();
//   }
// }
//
// class MainMatchApiControllerss extends GetxController {
//   var matches = <MatchModelss>[].obs;
//   var isLoading = true.obs;
//
//   @override
//   void onInit() {
//     fetchMatches();
//     super.onInit();
//   }
//
//   Future<void> fetchMatches() async {
//     try {
//       isLoading(true);
//       final response = await http.get(
//           Uri.parse("https://marketsarket.qnsports.live/getcricketmatches"));
//
//       if (response.statusCode == 200) {
//         List<dynamic> jsonResponse = json.decode(response.body);
//         matches.value =
//             jsonResponse.map((data) => MatchModelss.fromJson(data)).toList();
//       } else {
//         Get.snackbar("Error", "Failed to load matches");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Something went wrong");
//     } finally {
//       isLoading(false);
//     }
//   }
// }
// class MatchScreen extends StatelessWidget {
//   // final TabControllerssX tabController = Get.find<TabControllerssX>();
//   final MatchController controller = Get.put(MatchController());
//   final AuthControllersss authController = Get.put(AuthControllersss());
//   final MainMatchApiControllerss matchController =
//   Get.put(MainMatchApiControllerss());
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Header
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [AppColors.getotp1, AppColors.getotp2],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//           child: Row(
//             children: [
//               Icon(Icons.play_arrow, color: Colors.white, size: 18),
//               SizedBox(width: 8),
//               Text(
//                 "InPlay",
//                 style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold),
//               ),
//               Spacer(),
//               Text(
//                 "All Cricket Matches",
//                 style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//
//         // Cricket Section
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//           color: Colors.white,
//           child: Row(
//             children: [
//               Icon(Icons.sports_cricket, color: Colors.red, size: 15),
//               SizedBox(width: 8),
//               Text("Cricket",
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//               Spacer(),
//             ],
//           ),
//         ),
//
//         // Matches List
//         Expanded(
//           child: Obx(() {
//             if (matchController.isLoading.value) {
//               return Center(child: CircularProgressIndicator());
//             }
//
//             final matches = matchController.matches;
//
//             if (matches.isEmpty) {
//               return Center(child: Text("No matches available"));
//             }
//
//             return
//               ListView.builder(
// physics: ClampingScrollPhysics( ),
//                 itemCount: matches.length,
//                 itemBuilder: (context, index) {
//                   return matchCard(matches[index]);
//                 },
//               );
//           }),
//         ),
//
//       ],
//     );
//   }
//
//   Widget matchCard(match) {
//     return Container(
//       width: 400,
//       margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 1.0),
//       padding: EdgeInsets.all(12.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: GestureDetector(
//         onTap: () async {
//           if (authController.isLoggedIn.value) {
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             await prefs.setString('eventId', match.gameId);
//
//
//             Get.to(
//                 //     () => CompetitionDetailScreen(competitionName: match.eventName),
//                 // id: 1);
//                 () => CompetitionDetailScreen(competitionName: match.eventName),
//           );
//
//           } else {
//             Get.snackbar("Access Denied", "Please log in to continue.",
//                 backgroundColor: Colors.red, colorText: Colors.white);
//           }
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ...match.eventName.split('/').map((part) => Text(
//               part.trim(),
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//               ),
//             )),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: List.generate(5, (index) {
//                 bool isBlue = index.isEven;
//                 return Container(
//                   height: 20,
//                   width: 60 + (index % 2) * 5,
//                   color: isBlue ? Colors.blue : Colors.pink.shade100,
//                   child: Center(
//                     child: Text(
//                       "-",
//                       style: TextStyle(
//                         color: isBlue ? Colors.white : Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // class MatchScreen extends StatelessWidget {
// //   final MatchController controller = Get.put(MatchController());
// //   final AuthControllersss authController = Get.put(AuthControllersss());
// //   final MainMatchApiControllerss matchController =
// //       Get.put(MainMatchApiControllerss());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         // Header
// //         SizedBox(
// //           child: Container(
// //             decoration: BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [AppColors.getotp1, AppColors.getotp2],
// //                 begin: Alignment.topLeft,
// //                 end: Alignment.bottomRight,
// //               ),
// //
// //             ),
// //             width: double.infinity,
// //             padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
// //             child: Row(
// //               children: [
// //                 Icon(Icons.play_arrow, color: Colors.white, size: 18),
// //                 SizedBox(width: 8),
// //                 Row(
// //                   children: [
// //                     Text(
// //                       "InPlay",
// //                       style: TextStyle(
// //                           fontSize: 15,
// //                           color: Colors.black,
// //                           fontWeight: FontWeight.bold),
// //                     ),
// //           SizedBox(width: 50,),
// //                     Text(
// //                       "All Cricket Matches",
// //                       style: TextStyle(
// //                           fontSize: 15,
// //                           color: Colors.black,
// //                           fontWeight: FontWeight.bold),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //
// //         // Cricket Section
// //         Container(
// //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
// //           color: Colors.white,
// //           child: Row(
// //             children: [
// //               Icon(Icons.sports_cricket, color: Colors.red, size: 15),
// //               SizedBox(width: 8),
// //               Text("Cricket",
// //                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
// //               Spacer(),
// //             ],
// //           ),
// //         ),
// //
// //         // Matches List
// //         Obx(() {
// //           if (matchController.isLoading.value) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //           return Column(
// //             children: matchController.matches.asMap().entries.map((entry) {
// //               final match = entry.value;
// //
// //               return Container(
// //                 width: 400,
// //
// //                 // Fixed width
// //                 margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 1.0),
// //                 padding: EdgeInsets.all(12.0),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.grey.withOpacity(0.2),
// //                       spreadRadius: 2,
// //                       blurRadius: 5,
// //                       offset: Offset(0, 2),
// //                     ),
// //                   ],
// //                 ),
// //                 child: GestureDetector(
// //                   onTap: () async {
// //                     if (authController.isLoggedIn.value) {
// //                       SharedPreferences prefs =
// //                           await SharedPreferences.getInstance();
// //                       await prefs.setString('eventId', match.gameId);
// //
// //                       Get.to(
// //                           () => CompetitionDetailScreen(
// //                               competitionName: match.eventName),
// //                           id: 1);
// //                       Get.to(
// //                           () => CompetitionDetailScreen(
// //                               competitionName: match.eventName),
// //                           id: 2);
// //                     } else {
// //                       Get.snackbar(
// //                           "Access Denied", "Please log in to continue.",
// //                           backgroundColor: Colors.red, colorText: Colors.white);
// //                     }
// //                   },
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       // Text(match.gameId,style: TextStyle(color: Colors.black),),
// //                       ...match.eventName.split('/').map((part) => Text(
// //                             part.trim(),
// //                             style: TextStyle(
// //                               fontSize: 15,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           )),
// //                       SizedBox(height: 10),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: List.generate(5, (index) {
// //                           bool isBlue = index.isEven;
// //                           return Container(
// //                             height: 20,
// //                             width: 60 + (index % 2) * 5,
// //                             color: isBlue ? Colors.blue : Colors.pink.shade100,
// //                             child: Center(
// //                               child: Text(
// //                                 "-",
// //                                 style: TextStyle(
// //                                   color: isBlue ? Colors.white : Colors.black,
// //                                   fontWeight: FontWeight.bold,
// //                                   fontSize: 20,
// //                                 ),
// //                               ),
// //                             ),
// //                           );
// //                         }),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             }).toList(),
// //           );
// //         }),
// //       ],
// //     );
// //   }
// // }
//
// // Widget matchCard(int rowIndex, String? teams, String gameId) {
// //   return Card(
// //     elevation: 2,
// //     margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
// //     child: Padding(
// //       padding: EdgeInsets.all(10),
// //       child: Row(
// //         children: [
// //           Icon(Icons.play_arrow, color: Colors.green, size: 20),
// //           SizedBox(width: 8),
// //           Expanded(
// //             child: tableCell(teams ?? "No Event",
// //                 gameId: gameId, isBold: true, maxLines: 2),
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// // }
//
// // Widget tableCell(String text, {required String gameId, bool isGreen = false, bool isBold = false, int maxLines = 1}) {
// //   final AuthControllersss authController = Get.find<AuthControllersss>();
// //   final GameController gamesController = Get.put(GameController());
// //
// //   return GestureDetector(
// //     onTap: () {
// //       if (authController.isLoggedIn.value) {
// //         gamesController.fetchGameData(gameId);
// //         Get.to(() => CompetitionDetailScreen(competitionName: text), id: 1);
// //       } else {
// //         Get.snackbar("Access Denied", "Please log in to continue.",
// //             backgroundColor: Colors.red, colorText: Colors.white);
// //       }
// //     },
// //     child: Text(
// //       text,
// //       textAlign: TextAlign.left,
// //       maxLines: maxLines,
// //       overflow: TextOverflow.ellipsis,
// //       style: TextStyle(
// //         fontSize: 15,
// //         fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
// //         color: isGreen ? Colors.white : Colors.black,
// //       ),
// //     ),
// //   );
// // }
// //
