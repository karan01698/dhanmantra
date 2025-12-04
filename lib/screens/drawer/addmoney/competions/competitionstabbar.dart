//
// import 'package:sattagames/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'LIveclass.dart';
// import 'Openbets.dart';
//
// class BetsController extends GetxController {
//   var openBetsCount = 0.obs;
// }
//
// class MatchTabBar extends StatelessWidget {
//
//   final BetsController controller = Get.put(BetsController());
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Column(
//         children: [
//           TabBar(
//             indicatorSize: TabBarIndicatorSize.tab, // ✅ Full width underline
//             indicatorColor: Color(0xff932fff), // ✅ Change indicator color
//             indicatorWeight: 4.0,
//             // Reduce horizontal padding
//             tabs: [
//               Tab(
//
//                 child: Text("🟡  Live", style: TextStyle(color: Color(0xffa7d9fe),fontSize: 16)),
//               ),
//
//               Tab(
//
//                 child: Text(
//                   "🏏Bets",
//                   style: TextStyle(color:Color(0xffa7d9fe),fontSize: 18),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               children: [
//                 LiveScreen(),
//                 OpenBets(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
