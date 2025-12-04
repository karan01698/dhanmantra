// import 'package:sattagames/screens/drawer/addmoney/competions/LIveclass.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../constants/colors.dart';
// import '../drawer/addmoney/CompetitionDetailScreen.dart';
// import '../drawer/custom_drawer.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../home/inplay.dart';
//
//
// class CrickettabScreen extends StatelessWidget {
//   final MatchController controller = Get.put(MatchController());
//   final AuthControllersss authController = Get.put(AuthControllersss());
//   final MainMatchApiControllerss matchController =
//       Get.put(MainMatchApiControllerss());
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
//             return ListView.builder(
//               itemCount: matches.length,
//               itemBuilder: (context, index) {
//                 return matchCard(matches[index]);
//               },
//             );
//           }),
//         ),
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
//             Get.to(
//                 () => CompetitionDetailScreen(competitionName: match.eventName),
//                 );
//           } else {
//             Get.snackbar("Access Denied", "Please log in to continue.",
//                 backgroundColor: Colors.red, colorText: Colors.white);
//           }
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ...match.eventName.split('/').map((part) => Text(
//                   part.trim(),
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )),
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
