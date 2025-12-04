// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
//
// import 'package:sattagames/screens/drawer/addmoney/placebet.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../constants/colors.dart';
// import '../../../allScreens/marquee.dart';
// import '../../../crickettab/livescrore.dart';
// import '../../../home/inplay.dart';
// import '../CompetitionDetailScreen.dart';
// import 'package:http/http.dart' as http;
//
// class LiveScreen extends StatelessWidget {
//   final MainMatchApiControllerss matchControllerss =
//       Get.put(MainMatchApiControllerss());
//   final MatchController controller = Get.put(MatchController());
//   final GameController gameController = Get.put(GameController());
//
//   @override
//   Widget build(BuildContext context) {
//     // Get the updated competition name inside build()
//     String competitionName =
//         CompetitionCache().competitionName ?? "No Competition Selected";
//
//     return SingleChildScrollView(
//         child: Column(
//           children: [
//             // Match Details Section
//             // Container(
//             //   decoration: BoxDecoration(
//             //     color: Colors.orange,
//             //     border: Border.all(width: 0.2, color: AppColors.getotp2),
//             //     borderRadius: BorderRadius.circular(5),
//             //   ),
//             //   child: MatchDetailsScreen(),
//             // ),
//
//             // Competition Name Section
//             SizedBox(height: 20,),
//             Container(
//
//                 padding: EdgeInsets.symmetric(horizontal: 3, vertical: 8),
//                 // Padding for spacing
//                 decoration: BoxDecoration(
//
//                   color: Color(0xff932fff), // Background color
//                    // Optional rounded corners
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       competitionName
//                           .split('/')
//                           .first
//                           .trim(), // Handle null safely
//                       maxLines: 1,
//                       // Ensures text stays on one line
//                       overflow: TextOverflow.ellipsis,
//                       // Adds "..." if text overflows
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(width: 8), // Space between the two texts
//                     Text(
//                       competitionName.contains('/')
//                           ? competitionName.split('/').last.trim()
//                           : "",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 )
//
//             ),
//             Container(child: IframeScreen(),height: 220,),
//
// // SizedBox(height: 300,child:LiveScorePage() ,),
//
//             GameScreen(),
//             // SizedBox(height: 150,),
//           ],
//         ),
//
//     );
//   }
// }
//
// // class MatchDetailsController extends GetxController {
// //   var isExpanded = false.obs; // Controls the visibility of the expanded section
// // }
// //
// // class MatchDetailsScreen extends StatelessWidget {
// //   final MatchDetailsController controller = Get.put(MatchDetailsController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //
// //       child: Column(
// //         children: [
// //
// //           Obx(() => AnimatedContainer(
// //                 duration: Duration(milliseconds: 300),
// //                 height: controller.isExpanded.value ? 100 : 0,
// //                 // Adjust height dynamically
// //                 width: double.infinity,
// //                 color: Colors.grey.shade200,
// //                 padding: EdgeInsets.all(15),
// //                 child: controller.isExpanded.value
// //                     ? Center(
// //                         child: Text("Hello! More details here.",
// //                             style: TextStyle(fontSize: 16)))
// //                     : SizedBox.shrink(),
// //               )),
// //         ],
// //       ),
// //     );
// //   }
// // }
// // Model Class for Parsing JSON
//
// // Model Class
// class GameData {
//   final int gmid;
//   final String mname;
//   final String gtype;
//   final String status;
//   final List<Section> sections;
//
//   GameData({
//     required this.gmid,
//     required this.mname,
//     required this.gtype,
//     required this.status,
//     required this.sections,
//   });
//
//   factory GameData.fromJson(Map<String, dynamic> json) {
//     return GameData(
//       gmid: json['gmid'],
//       mname: json['mname'],
//       gtype: json['gtype'],
//       status: json['status'],
//       sections: (json['section'] as List)
//           .map((section) => Section.fromJson(section))
//           .toList(),
//     );
//   }
// }
//
// class Section {
//   final int sid;
//   final String gstatus;
//   final String nat;
//   final List<Odds> odds;
//
//   Section({
//     required this.sid,
//     required this.gstatus,
//     required this.nat,
//     required this.odds,
//   });
//
//   factory Section.fromJson(Map<String, dynamic> json) {
//     return Section(
//       sid: json['sid'],
//       gstatus: json['gstatus'],
//       nat: json['nat'],
//       odds: (json['odds'] as List).map((odd) => Odds.fromJson(odd)).toList(),
//     );
//   }
// }
//
// class Odds {
//   final double odds;
//   final String otype;
//
//   Odds({required this.odds, required this.otype});
//
//   factory Odds.fromJson(Map<String, dynamic> json) {
//     return Odds(
//       odds: json['odds'].toDouble(),
//       otype: json['otype'],
//     );
//   }
// }
//
// class GameController extends GetxController {
//   var isLoading = true.obs;
//   var gameList = <GameData>[].obs;
//   var selectedGameIndex = (-1).obs;
//   var selectedSectionIndex = (-1).obs;
//   var selectedOdds = ''.obs;
//   var selectedOddType = ''.obs;
//   var selectedGameType = ''.obs;
//   var selectedBACKType = ''.obs;
//   var selectedLayType = ''.obs;
//   var eventId = ''.obs;
//
//   void increaseOdds() {
//     if (selectedOdds.value.isNotEmpty) {
//       double currentOdds = double.tryParse(selectedOdds.value) ?? 0;
//       selectedOdds.value =
//           (currentOdds + 0.1).toStringAsFixed(2); // Increase by 0.1
//     }
//   }
//
//   void decreaseOdds() {
//     if (selectedOdds.value.isNotEmpty) {
//       double currentOdds = double.tryParse(selectedOdds.value) ?? 0;
//       if (currentOdds > 1.0) {
//         // Prevent odds from going below 1.0
//         selectedOdds.value =
//             (currentOdds - 0.1).toStringAsFixed(2); // Decrease by 0.1
//       }
//     }
//   }
//
//   @override
//   void onInit() {
//     startRandomUpdates();
//     super.onInit();
//   }
//
//   final StreamController<List<GameData>> _gameStreamController =
//       StreamController.broadcast();
//
//   Stream<List<GameData>> get gameStream => _gameStreamController.stream;
//
//   Future<List<GameData>> fetchGameData(String id) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     eventId.value = prefs.getString('eventId') ?? "";
//     logPrint(
//         'https://dhanmantragame.com/APIs/WebService1.asmx/Rates?eventid=${eventId.value}');
//
//     try {
//       isLoading(true);
//       final response = await http.get(Uri.parse(
//           'https://dhanmantragame.com/APIs/WebService1.asmx/Rates?eventid=${eventId.value}'));
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         if (jsonData['success'] == true) {
//           var data = jsonData['data'] as List;
//           gameList.value = data.map((game) => GameData.fromJson(game)).toList();
//         }
//       }
//     } catch (e) {
//       logPrint('Error fetching data: $e');
//     } finally {
//       isLoading(false);
//     }
//
//     return gameList.isNotEmpty ? gameList : [];
//   }
//
//   void setBet(
//     String odds,
//     String type,
//     String game,
//   ) {
//     selectedOdds.value = odds;
//
//     selectedOddType.value = type;
//     selectedGameType.value = game;
//   }
//
//   var randomBackValues = <double>[].obs;
//   var randomLayValues = <double>[].obs;
//
//   Timer? _randomTimer;
//
//   void startRandomUpdates() {
//     _randomTimer = Timer.periodic(Duration(seconds: 5), (timer) {
//       updateRandomValues();
//     });
//   }
//
//   void updateRandomValues() {
//     if (gameList.isNotEmpty) {
//       randomBackValues.value =
//           List.generate(gameList.length, (_) => getRandomValue());
//       randomLayValues.value =
//           List.generate(gameList.length, (_) => getRandomValue());
//     }
//   }
//
//   double getRandomValue() {
//     return (Random().nextDouble() * 10 + 1)
//         .toDouble(); // Random value between 1-10
//   }
//
//   void clearBet() {
//     selectedOdds.value = '';
//     selectedOddType.value = '';
//     selectedGameIndex.value = -1;
//     selectedSectionIndex.value = -1;
//   }
//
//   void toggleBettingSection(int gameIndex, int sectionIndex) {
//     if (selectedGameIndex.value == gameIndex &&
//         selectedSectionIndex.value == sectionIndex) {
//       clearBet(); // Reset selection if same section is clicked
//     } else {
//       selectedGameIndex.value = gameIndex;
//       selectedSectionIndex.value = sectionIndex;
//     }
//   }
//
//   @override
//   void onClose() {
//     _randomTimer?.cancel(); // Cancel the timer when the controller is disposed
//     super.onClose();
//   }
// }
//
// class GameScreen extends StatelessWidget {
//   final GameController gameController = Get.put(GameController());
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<GameData>>(
//       stream: Stream.periodic(Duration(seconds: 1)).asyncMap((_) async {
//         await gameController.fetchGameData(gameController.eventId.value);
//         return gameController.gameList;
//       }).distinct(),
//       builder: (context, snapshot) {
//         return Obx(() {
//           if (gameController.isLoading.value &&
//               gameController.gameList.isEmpty) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (gameController.gameList.isEmpty) {
//             return Center(
//               child: Text("No Data Available",
//                   style: TextStyle(fontSize: 16, color: Colors.white)),
//             );
//           }
//
//           return Container(
//
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white),
//               color: Colors.black,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3), // ✅ Light shadow
//                   blurRadius: 4, // ✅ Soft blur
//                   offset: Offset(2, 2), // ✅ Slight movement down-right
//                 ),
//               ],
//             ),
//             // padding: EdgeInsets.all(8),
//
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                  width: double.infinity,
//                   padding: EdgeInsets.only(left: 10),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white),
//                     color: Color(0xff7f00ff),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3), // ✅ Light shadow
//                         blurRadius: 4, // ✅ Soft blur
//                         offset: Offset(2, 2), // ✅ Slight movement down-right
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     "Live Games",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       shadows: [
//                         Shadow(
//                           color: Colors.black.withOpacity(0.5),
//                           // ✅ Adds depth to text
//                           blurRadius: 3,
//                           offset: Offset(1, 1),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 SingleChildScrollView(
//                   child: ListView.builder(
//
//                     shrinkWrap: true,
//                     // This allows ListView to take only the required space
//                     physics: NeverScrollableScrollPhysics(),
//
//                     itemCount: gameController.gameList.length,
//                     itemBuilder: (context, gameIndex) {
//                       final game = gameController.gameList[gameIndex];
//
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//
//                             color: Colors.white,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.all(8),
//                                   color: Color(0xff932fff),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         game.mname,
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       // Text(
//                                       //   "Status: ${game.status}",
//                                       //   style: TextStyle(
//                                       //     color: Colors.red,
//                                       //     fontWeight: FontWeight.bold,
//                                       //   ),
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 SizedBox(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Game Type: ${game.gtype}",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.black54),
//                                       ),
//                                       game.gtype == "match"
//                                           ? MarqueeWidget(
//                                               text: "🏆 IPL cup winner"
//                                                   "🏆special market stared in our exchange🏆"
//                                                   "All players includes of both teams (cricket bet) 🏏",
//                                               textColor: Colors.black,
//                                             )
//                                           : MarqueeWidget(
//                                               text:
//                                                   "🔥 Duck Out not considered in this even🏆",
//                                               textColor: Colors.black,
//                                             ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 // Table
//                                 Table(
//                                   border:
//                                       TableBorder.all(color: Colors.grey),
//                                   columnWidths: {
//                                     0: FlexColumnWidth(2),
//                                     1: FlexColumnWidth(1),
//                                     2: FlexColumnWidth(1),
//                                   },
//                                   children: [
//                                     TableRow(
//                                       decoration: BoxDecoration(
//                                           color: Colors.blue.shade100),
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.all(8),
//                                           child: Text("Section",
//                                               style: TextStyle(
//                                                   fontWeight:
//                                                       FontWeight.bold)),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.all(8),
//                                           child: Text("Back (Yes)",
//                                               style: TextStyle(
//                                                   fontWeight:
//                                                       FontWeight.bold)),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.all(8),
//                                           child: Text("Lay (No)",
//                                               style: TextStyle(
//                                                   fontWeight:
//                                                       FontWeight.bold)),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//
//                                 // Section Rows
//                                 ...game.sections
//                                     .asMap()
//                                     .entries
//                                     .map((sectionEntry) {
//                                   int sectionIndex = sectionEntry.key;
//                                   var section = sectionEntry.value;
//
//                                   List<double> backOdds = section.odds
//                                       .where((odd) =>
//                                           odd.otype.toLowerCase() == 'back')
//                                       .map((odd) => odd.odds)
//                                       .toList();
//
//                                   List<double> layOdds = section.odds
//                                       .where((odd) =>
//                                           odd.otype.toLowerCase() == 'lay')
//                                       .map((odd) => odd.odds)
//                                       .toList();
//
//                                   double? lastBackOdd = backOdds.isNotEmpty
//                                       ? backOdds.last
//                                       : null;
//                                   double? firstLayOdd = layOdds.isNotEmpty
//                                       ? layOdds.first
//                                       : null;
//
//                                   return Column(
//
//                                     children: [
//                                       Table(
//                                         border: TableBorder.all(
//                                             color: Colors.grey),
//                                         columnWidths: {
//                                           0: FlexColumnWidth(2),
//                                           1: FlexColumnWidth(1),
//                                           2: FlexColumnWidth(1),
//                                         },
//                                         children: [
//                                           TableRow(
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets.all(2),
//                                                 child: Text(section.nat,
//                                                     style: TextStyle(
//                                                         fontSize: 12,
//                                                         fontWeight:
//                                                             FontWeight
//                                                                 .bold)),
//                                               ),
//
//                                               // Back (Yes) Button
//                                               GestureDetector(
//                                                 onTap: () {
//                                                   if (lastBackOdd != null) {
//                                                     if (gameController
//                                                                 .selectedGameIndex
//                                                                 .value ==
//                                                             gameIndex &&
//                                                         gameController
//                                                                 .selectedSectionIndex
//                                                                 .value ==
//                                                             sectionIndex &&
//                                                         gameController
//                                                                 .selectedOdds
//                                                                 .value ==
//                                                             lastBackOdd
//                                                                 .toString()) {
//                                                       gameController
//                                                           .clearBet();
//                                                     } else {
//                                                       gameController.setBet(
//                                                           lastBackOdd
//                                                               .toString(),
//                                                           'back',
//                                                           section.nat);
//                                                       gameController
//                                                           .selectedBACKType
//                                                           .value = "Back";
//                                                       gameController
//                                                           .selectedGameIndex
//                                                           .value = gameIndex;
//                                                       gameController
//                                                           .selectedSectionIndex
//                                                           .value = sectionIndex;
//                                                     }
//                                                   }
//                                                 },
//                                                 child: Obx(() => Container(
//                                                       padding:
//                                                           EdgeInsets.all(8),
//                                                       alignment:
//                                                           Alignment.center,
//                                                       color: (gameController.selectedGameIndex.value == gameIndex &&
//                                                               gameController
//                                                                       .selectedSectionIndex
//                                                                       .value ==
//                                                                   sectionIndex &&
//                                                               gameController
//                                                                       .selectedOdds
//                                                                       .value ==
//                                                                   lastBackOdd
//                                                                       .toString())
//                                                           ? Colors.white
//                                                           : Colors.blue
//                                                               .shade100,
//                                                       child: Column(
//                                                         children: [
//                                                           Text(
//                                                             lastBackOdd !=
//                                                                     null
//                                                                 ? "$lastBackOdd"
//                                                                 : "--",
//                                                             style: TextStyle(
//                                                                 fontSize:
//                                                                     12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                           Text(
//                                                             "${gameController.randomBackValues.length > gameIndex ? gameController.randomBackValues[gameIndex].toStringAsFixed(2) : '--'}",
//                                                             // Random number stays
//                                                             style: TextStyle(
//                                                                 fontSize:
//                                                                     12,
//                                                                 color: Colors
//                                                                     .grey,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     )),
//                                               ),
//
//                                               // Lay (No) Button
//                                               GestureDetector(
//                                                 onTap: () {
//                                                   if (firstLayOdd != null) {
//                                                     if (game.status
//                                                             .toLowerCase() ==
//                                                         "suspended") {
//                                                       Get.snackbar(
//                                                         "Game Suspended",
//                                                         "You cannot place a bet on this game.",
//                                                         backgroundColor:
//                                                             Colors.red,
//                                                         colorText:
//                                                             Colors.white,
//                                                         snackPosition:
//                                                             SnackPosition
//                                                                 .TOP,
//                                                       );
//                                                       return;
//                                                     }
//                                                     if (gameController
//                                                                 .selectedGameIndex
//                                                                 .value ==
//                                                             gameIndex &&
//                                                         gameController
//                                                                 .selectedSectionIndex
//                                                                 .value ==
//                                                             sectionIndex &&
//                                                         gameController
//                                                                 .selectedOdds
//                                                                 .value ==
//                                                             firstLayOdd
//                                                                 .toString()) {
//                                                       gameController
//                                                           .clearBet();
//                                                     } else {
//                                                       gameController.setBet(
//                                                           firstLayOdd
//                                                               .toString(),
//                                                           'lay',
//                                                           section.nat);
//                                                       gameController
//                                                           .selectedLayType
//                                                           .value = "lay";
//                                                       gameController
//                                                           .selectedGameIndex
//                                                           .value = gameIndex;
//                                                       gameController
//                                                           .selectedSectionIndex
//                                                           .value = sectionIndex;
//                                                     }
//                                                   }
//                                                 },
//                                                 child: Obx(() => Container(
//                                                       padding:
//                                                           EdgeInsets.all(8),
//                                                       alignment:
//                                                           Alignment.center,
//                                                       color: (gameController.selectedGameIndex.value == gameIndex &&
//                                                               gameController
//                                                                       .selectedSectionIndex
//                                                                       .value ==
//                                                                   sectionIndex &&
//                                                               gameController
//                                                                       .selectedOdds
//                                                                       .value ==
//                                                                   firstLayOdd
//                                                                       .toString())
//                                                           ? Colors.white
//                                                           : Colors.pink
//                                                               .shade100,
//                                                       child: Column(
//                                                         children: [
//                                                           Text(
//                                                             firstLayOdd !=
//                                                                     null
//                                                                 ? "$firstLayOdd"
//                                                                 : "--",
//                                                             style: TextStyle(
//                                                                 fontSize:
//                                                                     12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                           Text(
//                                                             "${gameController.randomLayValues.length > gameIndex ? gameController.randomLayValues[gameIndex].toStringAsFixed(2) : '--'}",
//                                                             style: TextStyle(
//                                                                 fontSize:
//                                                                     12,
//                                                                 color: Colors
//                                                                     .grey,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     )),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//
//                                       // Betting Screen Appears Directly Below the Selected Row
//                                       Obx(() {
//                                         if (gameController.selectedGameIndex
//                                                     .value ==
//                                                 gameIndex &&
//                                             gameController
//                                                     .selectedSectionIndex
//                                                     .value ==
//                                                 sectionIndex) {
//                                           return Container(
//                                             width: double.infinity,
//                                             // Full width
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: 5),
//                                             color: Colors.grey.shade200,
//                                             // Light background
//                                             child: BettingScreenss(),
//                                           );
//                                         }
//                                         return SizedBox(); // Hide when not selected
//                                       }),
//                                     ],
//                                   );
//                                 }).toList(),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(
//
//                   height: 10,
//                 ),
//               ],
//             ),
//           );
//         });
//       },
//     );
//   }
// }
//
// // class GameScreen extends StatelessWidget {
// //   final GameController gameController = Get.put(GameController());
// //
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<List<GameData>>(
// //       stream: Stream.periodic(Duration(seconds: 1)).asyncMap((_) async {
// //         await gameController.fetchGameData(gameController.eventId.value);
// //         return gameController.gameList;
// //       }).distinct(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.active ||
// //             snapshot.connectionState == ConnectionState.waiting) {
// //         }
// //
// //         return Obx(() {
// //           if (gameController.isLoading.value && gameController.gameList.isEmpty) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //
// //           if (gameController.gameList.isEmpty) {
// //             return Center(
// //               child: Text("No Data Available",
// //                   style: TextStyle(fontSize: 16, color: Colors.white)),
// //             );
// //           }
// //
// //           return Container(
// //             padding: EdgeInsets.all(1),
// //             color: Colors.black,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "Live Games",
// //                   style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.orange),
// //                 ),
// //                 SizedBox(height: 10),
// //                 Expanded(
// //                   child: ListView.builder(
// //                     itemCount: gameController.gameList.length,
// //                     itemBuilder: (context, gameIndex) {
// //                       final game = gameController.gameList[gameIndex];
// //
// //                       return Card(
// //                         color: Colors.white,
// //                         shape: RoundedRectangleBorder(
// //                           // borderRadius: BorderRadius.circular(10),
// //                           // side: BorderSide(color: Colors.orange, width: 1),
// //                         ),
// //                         child: Padding(
// //                           padding: EdgeInsets.all(0),
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Row(
// //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                 children: [
// //                                   Expanded(
// //                                     child: Container(
// //                                       padding:EdgeInsets.only(bottom:10),
// //                                       decoration: BoxDecoration(
// //                                         color: Color(0xff932fff),
// //
// //                                       ),
// //                                       child: Row(
// //                                         mainAxisAlignment: MainAxisAlignment.start,
// //                                         children: [
// //                                           SizedBox(width: 5,),
// //
// //                                           Text(
// //                                             game.mname,
// //                                             style: TextStyle(
// //                                               fontSize: 15,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.white,
// //                                             ),
// //                                           ),
// // Spacer(),
// //                                           Text(
// //                                             "Status: ${game.status}",
// //                                             style: TextStyle(
// //                                                 color: Colors.red, fontWeight: FontWeight.bold),
// //                                           ),
// //                                           SizedBox(width: 5,),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   ),
// //
// //                                 ],
// //                               ),
// //
// //                               Text("Game Type: ${game.gtype}",
// //                                   style: TextStyle(fontSize: 14, color: Colors.black54)),
// //                               SizedBox(height: 10),
// // // Table to display game sections in rows with back and lay odds
// //                               Table(
// //                                 border: TableBorder.all(color: Colors.grey), // Adds borders for better visibility
// //                                 columnWidths: {
// //                                   0: FlexColumnWidth(2), // Section Name
// //                                   1: FlexColumnWidth(1), // Back (Yes)
// //                                   2: FlexColumnWidth(1), // Lay (No)
// //                                 },
// //                                 children: [
// //                                   // Table Header Row
// //                                   TableRow(
// //                                     decoration: BoxDecoration(color: Colors.blue.shade100), // Header styling
// //                                     children: [
// //                                       Padding(
// //                                         padding: EdgeInsets.all(8),
// //                                         child: Text("Section", style: TextStyle(fontWeight: FontWeight.bold)),
// //                                       ),
// //                                       Padding(
// //                                         padding: EdgeInsets.all(8),
// //                                         child: Text("Back (Yes)", style: TextStyle(fontWeight: FontWeight.bold)),
// //                                       ),
// //                                       Padding(
// //                                         padding: EdgeInsets.all(8),
// //                                         child: Text("Lay (No)", style: TextStyle(fontWeight: FontWeight.bold)),
// //                                       ),
// //                                     ],
// //                                   ),
// //
// //                                   // Data Rows
// //                                   ...game.sections.asMap().entries.map((sectionEntry) {
// //                                     int sectionIndex = sectionEntry.key;
// //                                     var section = sectionEntry.value;
// //
// //                                     // Extract 'back' and 'lay' odds
// //                                     List<double> backOdds = section.odds
// //                                         .where((odd) => odd.otype.toLowerCase() == 'back')
// //                                         .map((odd) => odd.odds)
// //                                         .toList();
// //
// //                                     List<double> layOdds = section.odds
// //                                         .where((odd) => odd.otype.toLowerCase() == 'lay')
// //                                         .map((odd) => odd.odds)
// //                                         .toList();
// //
// //                                     double? lastBackOdd = backOdds.isNotEmpty ? backOdds.last : null;
// //                                     double? firstLayOdd = layOdds.isNotEmpty ? layOdds.first : null;
// //
// //                                     return TableRow(
// //                                       children: [
// //                                         // Section Name
// //                                         Padding(
// //                                           padding: EdgeInsets.all(8),
// //                                           child: Text(section.nat, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
// //                                         ),
// //
// //                                         // Back (Yes) Button
// //                                         GestureDetector(
// //                                           onTap: () {
// //                                             if (lastBackOdd != null) {
// //                                               if (gameController.selectedGameIndex.value == gameIndex &&
// //                                                   gameController.selectedSectionIndex.value == sectionIndex &&
// //                                                   gameController.selectedOdds.value == lastBackOdd.toString()) {
// //                                                 gameController.clearBet();
// //                                               } else {
// //                                                 gameController.setBet(lastBackOdd.toString(), 'back', section.nat);
// //                                                 gameController.selectedGameIndex.value = gameIndex;
// //                                                 gameController.selectedSectionIndex.value = sectionIndex;
// //                                               }
// //                                             }
// //                                           },
// //                                           child: Obx(() => Container(
// //                                             padding: EdgeInsets.all(8),
// //                                             alignment: Alignment.center,
// //                                             color: (gameController.selectedGameIndex.value == gameIndex &&
// //                                                 gameController.selectedSectionIndex.value == sectionIndex &&
// //                                                 gameController.selectedOdds.value == lastBackOdd.toString())
// //                                                 ? Colors.white
// //                                                 : Colors.blue.shade100,
// //                                             child: Text(
// //                                               lastBackOdd != null ? "$lastBackOdd" : "--",
// //                                               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //                                             ),
// //                                           )),
// //                                         ),
// //
// //                                         // Lay (No) Button
// //                                         GestureDetector(
// //                                           onTap: () {
// //                                             if (firstLayOdd != null) {
// //                                               if (game.status.toLowerCase() == "suspended") {
// //                                                 Get.snackbar(
// //                                                   "Game Suspended",
// //                                                   "You cannot place a bet on this game.",
// //                                                   backgroundColor: Colors.red,
// //                                                   colorText: Colors.white,
// //                                                   snackPosition: SnackPosition.TOP,
// //                                                 );
// //                                                 return;
// //                                               }
// //                                               if (gameController.selectedGameIndex.value == gameIndex &&
// //                                                   gameController.selectedSectionIndex.value == sectionIndex &&
// //                                                   gameController.selectedOdds.value == firstLayOdd.toString()) {
// //                                                 gameController.clearBet();
// //                                               } else {
// //                                                 gameController.setBet(firstLayOdd.toString(), 'lay', section.nat);
// //                                                 gameController.selectedGameIndex.value = gameIndex;
// //                                                 gameController.selectedSectionIndex.value = sectionIndex;
// //                                               }
// //                                             }
// //                                           },
// //                                           child: Obx(() => Container(
// //                                             padding: EdgeInsets.all(8),
// //                                             alignment: Alignment.center,
// //                                             color: (gameController.selectedGameIndex.value == gameIndex &&
// //                                                 gameController.selectedSectionIndex.value == sectionIndex &&
// //                                                 gameController.selectedOdds.value == firstLayOdd.toString())
// //                                                 ? Colors.white
// //                                                 : Colors.pink.shade100,
// //                                             child: Text(
// //                                               firstLayOdd != null ? "$firstLayOdd" : "--",
// //                                               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //                                             ),
// //                                           )),
// //                                         ),
// //                                       ],
// //                                     );
// //                                   }).toList(),
// //                                 ],
// //                               ),
// //                               // Betting Screen (Expanding Below Clicked Section)
// //                               Obx(() {
// //                                 if (gameController.selectedGameIndex.value == gameIndex &&
// //                                     gameController.selectedSectionIndex.value == sectionIndex) {
// //
// //                                   // Prevent opening if game is suspended
// //                                   if (game.status.toLowerCase() == "suspended") {
// //                                     Get.snackbar(
// //                                       "Game Suspended",
// //                                       "You cannot place a bet on this game.",
// //                                       backgroundColor: Colors.red,
// //                                       colorText: Colors.white,
// //                                       snackPosition: SnackPosition.TOP,
// //                                     );
// //                                     return SizedBox(); // ❌ Do not open betting screen
// //                                   }
// //
// //                                   // ✅ Show betting screen when conditions match
// //                                   return BettingScreenss();
// //                                 }
// //                                 return SizedBox();
// //                               }),
// //
// //
// //
// //
// //
// //                                               // Betting Screen (Expanding Below Clicked Section)
// //                                               Obx(() {
// //                                                 if (gameController.selectedGameIndex.value == gameIndex &&
// //                                                     gameController.selectedSectionIndex.value == sectionIndex) {
// //                                                   if (game.status.toLowerCase() == "suspended") {
// //                                                     Get.snackbar(
// //                                                       "Game Suspended",
// //                                                       "You cannot place a bet on this game.",
// //                                                       backgroundColor: Colors.red,
// //                                                       colorText: Colors.white,
// //                                                       snackPosition: SnackPosition.TOP,
// //                                                     );
// //                                                     return SizedBox(); // ❌ Do not open betting screen
// //                                                   }
// //                                                   return BettingScreenss();
// //                                                 }
// //                                                 return SizedBox();
// //                                               }),
// //                                             ],
// //                                           );
// //                                         }).toList(),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         });
// //       },
// //     );
// //   }
// // }
//
// // StreamBuilder<List<GameData>>(
// // stream: Stream.periodic(Duration(seconds: 1)).asyncMap((_) async {
// // await gameController.fetchGameData(gameController.eventId.value);
// // return gameController.gameList;
// // }).distinct(),
// // builder: (context, snapshot) {
// // if (snapshot.connectionState == ConnectionState.active ||
// // snapshot.connectionState == ConnectionState.waiting) {
// //
// // }
// //
// // class GameScreen extends StatelessWidget {
// //   final GameController gameController = Get.put(GameController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(() {
// //       if (gameController.isLoading.value) {
// //         return Center(child: CircularProgressIndicator());
// //       }
// //
// //       if (gameController.gameList.isEmpty) {
// //         return Center(
// //           child: Text("No Data Available",
// //               style: TextStyle(fontSize: 16, color: Colors.white)),
// //         );
// //       }
// //
// //       return Container(
// //         padding: EdgeInsets.all(10),
// //         color: Colors.black,
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               "Live Games",
// //               style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.orange),
// //             ),
// //             SizedBox(height: 10),
// //             Expanded(
// //               child: ListView.builder(
// //                 itemCount: gameController.gameList.length,
// //                 itemBuilder: (context, gameIndex) {
// //                   final game = gameController.gameList[gameIndex];
// //
// //                   return Card(
// //                     color: Colors.white,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                       side: BorderSide(color: Colors.orange, width: 1),
// //                     ),
// //                     child: Padding(
// //                       padding: EdgeInsets.all(10),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Expanded(
// //                                 child: Text(
// //                                   game.mname,
// //                                   style: TextStyle(
// //                                     fontSize: 18,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.black,
// //                                   ),
// //                                 ),
// //                               ),
// //                               Text(
// //                                 "Status: ${game.status}",
// //                                 style: TextStyle(
// //                                     color: Colors.red, fontWeight: FontWeight.bold),
// //                               ),
// //                             ],
// //                           ),
// //                           Divider(color: Colors.orange),
// //                           Text("Game Type: ${game.gtype}",
// //                               style: TextStyle(fontSize: 14, color: Colors.black54)),
// //                           SizedBox(height: 10),
// //
// //                           // Sections (Back & Lay Buttons)
// //                           Column(
// //                             children: game.sections.asMap().entries.map((sectionEntry) {
// //                               int sectionIndex = sectionEntry.key;
// //                               var section = sectionEntry.value;
// //
// //                               // Extract 'back' and 'lay' odds separately
// //                               List<double> backOdds = section.odds
// //                                   .where((odd) => odd.otype.toLowerCase() == 'back')
// //                                   .map((odd) => odd.odds)
// //                                   .toList();
// //
// //                               List<double> layOdds = section.odds
// //                                   .where((odd) => odd.otype.toLowerCase() == 'lay')
// //                                   .map((odd) => odd.odds)
// //                                   .toList();
// //
// //                               // Get the required values
// //                               double? lastBackOdd = backOdds.isNotEmpty ? backOdds.last : null; // Last value for Yes
// //                               double? firstLayOdd = layOdds.isNotEmpty ? layOdds.first : null; // First value for No
// //
// //                               return Column(
// //                                 children: [
// //                                   Container(
// //                                     padding: EdgeInsets.all(8),
// //                                     margin: EdgeInsets.only(bottom: 5),
// //                                     decoration: BoxDecoration(
// //                                       color: Colors.grey.shade200,
// //                                       borderRadius: BorderRadius.circular(5),
// //                                     ),
// //                                     child: Column(
// //                                       crossAxisAlignment: CrossAxisAlignment.start,
// //                                       children: [
// //                                         Text(
// //                                           "Section: ${section.nat}",
// //                                           style: TextStyle(
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.black),
// //                                         ),
// //                                         Text("Status: ${section.gstatus}",
// //                                             style: TextStyle(color: Colors.black54)),
// //                                         SizedBox(height: 5),
// //
// //                                         // Back & Lay Buttons (Last Yes & First No)
// //                                         Row(
// //                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                                           children: [
// //                                             if (lastBackOdd != null)
// //                                               GestureDetector(
// //                                                 onTap: () {
// //                                                   if (gameController.selectedGameIndex.value == gameIndex &&
// //                                                       gameController.selectedSectionIndex.value == sectionIndex &&
// //                                                       gameController.selectedOdds.value == lastBackOdd.toString()) {
// //                                                     gameController.clearBet();
// //                                                   } else {
// //                                                     gameController.setBet(lastBackOdd.toString(), 'back', section.nat);
// //                                                     gameController.selectedGameIndex.value = gameIndex;
// //                                                     gameController.selectedSectionIndex.value = sectionIndex;
// //                                                   }
// //                                                 },
// //                                                 child: Obx(() => Container(
// //                                                   padding: EdgeInsets.all(6),
// //                                                   decoration: BoxDecoration(
// //                                                     color: (gameController.selectedGameIndex.value == gameIndex &&
// //                                                         gameController.selectedSectionIndex.value == sectionIndex &&
// //                                                         gameController.selectedOdds.value == lastBackOdd.toString())
// //                                                         ? Colors.white
// //                                                         : Colors.blue.shade100,
// //                                                     borderRadius: BorderRadius.circular(5),
// //                                                   ),
// //                                                   child: Column(
// //                                                     children: [
// //                                                       Text(
// //                                                         "$lastBackOdd",
// //                                                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                                                       ),
// //                                                       Text("Yes", style: TextStyle(fontSize: 12, color: Colors.black54)),
// //                                                     ],
// //                                                   ),
// //                                                 )),
// //                                               ),
// //
// //                                             if (firstLayOdd != null)
// //                                               GestureDetector(
// //                                                 onTap: () {
// //                                                   if (gameController.selectedGameIndex.value == gameIndex &&
// //                                                       gameController.selectedSectionIndex.value == sectionIndex &&
// //                                                       gameController.selectedOdds.value == firstLayOdd.toString()) {
// //                                                     gameController.clearBet();
// //                                                   } else {
// //                                                     gameController.setBet(firstLayOdd.toString(), 'lay', section.nat);
// //                                                     gameController.selectedGameIndex.value = gameIndex;
// //                                                     gameController.selectedSectionIndex.value = sectionIndex;
// //                                                   }
// //                                                 },
// //                                                 child: Obx(() => Container(
// //                                                   padding: EdgeInsets.all(6),
// //                                                   decoration: BoxDecoration(
// //                                                     color: (gameController.selectedGameIndex.value == gameIndex &&
// //                                                         gameController.selectedSectionIndex.value == sectionIndex &&
// //                                                         gameController.selectedOdds.value == firstLayOdd.toString())
// //                                                         ? Colors.white
// //                                                         : Colors.pink.shade100,
// //                                                     borderRadius: BorderRadius.circular(5),
// //                                                   ),
// //                                                   child: Column(
// //                                                     children: [
// //                                                       Text(
// //                                                         "$firstLayOdd",
// //                                                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                                                       ),
// //                                                       Text("No", style: TextStyle(fontSize: 12, color: Colors.black54)),
// //                                                     ],
// //                                                   ),
// //                                                 )),
// //                                               ),
// //                                           ],
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //
// //                                   // Betting Screen (Expanding Below Clicked Section)
// //                                   Obx(() {
// //                                     if (gameController.selectedGameIndex.value == gameIndex &&
// //                                         gameController.selectedSectionIndex.value == sectionIndex) {
// //                                       return BettingScreenss();
// //                                     }
// //                                     return SizedBox();
// //                                   }),
// //                                 ],
// //                               );
// //                             }).toList(),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     });
// //   }
// // }
