// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../constants/colors.dart';
// import '../../home/inplay.dart';
// import 'competions/competitionstabbar.dart';
//
// class CompetitionDetailScreen extends StatelessWidget {
//
//   final String competitionName;
//
//   CompetitionDetailScreen({required this.competitionName}) {
//     CompetitionCache().competitionName = competitionName; // Store selection globally
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double horizontalPadding = screenWidth * 0.00; // 3% of screen width
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//
//         backgroundColor: Color(0xff932fff),
//         elevation: 4,
//         shadowColor: Colors.white,
//         leading: IconButton(
//           icon: Container(
//               decoration: BoxDecoration(
//                 color: Colors.yellow, // Background color
//                 // Makes it circular
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26, // Soft shadow
//                     blurRadius: 6,
//                     spreadRadius: 2,
//                     offset: Offset(0, 3), // Moves shadow slightly down
//                   ),
//                 ],
//               ),
//
//               child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,size: 24, )),
//           // onPressed: () {
//           //   if (Get.nestedKey(1)!.currentState!.canPop()) {
//           //     Get.nestedKey(1)!.currentState!.pop(); // Pop from nested navigator
//           //   }
//           //   if (Get.nestedKey(2)!.currentState!.canPop()) {
//           //     Get.nestedKey(2)!.currentState!.pop(); // Pop from nested navigator
//           //   }
//           //   else {
//           //     Get.back(); // Fallback to root navigator if no pages in the stack
//           //   }
//           // },
//           onPressed: () {
//             Get.back(); // Fallback to root navigator if no pages in the stack
//
//           },
//
//         ),
//
//         title: Column(
//           mainAxisAlignment: MainAxisAlignment.center, // Center align vertically
//           crossAxisAlignment: CrossAxisAlignment.center, // Center align horizontally
//           children: [
//             Center(
//               child: Text(
//                 textAlign: TextAlign.center,
//                 competitionName.replaceAll('/', '\n'), // Moves text after "/" to the next line
//                 style: TextStyle(
//                   color: AppColors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 softWrap: true, // Allow wrapping
//               ),
//             ),
//
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               SizedBox(width: 50),
//
//             ],
//           ),
//           SizedBox(height: 10),
//
//           Expanded(
//             child: MatchTabBar(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CompetitionCache {
//   static final CompetitionCache _instance = CompetitionCache._internal();
//
//   String? competitionName;
//
//   factory CompetitionCache() {
//     return _instance;
//   }
//
//   CompetitionCache._internal();
// }
//
