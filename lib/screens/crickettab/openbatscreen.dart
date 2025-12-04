// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../../../authenticationsScreens/loginforgotregcontroller.dart';
// import '../drawer/addmoney/CompetitionDetailScreen.dart';
//
//
// class BetsScreen extends StatefulWidget {
//   @override
//   _BetsScreenState createState() => _BetsScreenState();
// }
//
// class _BetsScreenState extends State<BetsScreen> {
//   late Future<List<Map<String, dynamic>>> _openBetsFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _openBetsFuture = _fetchOpenBets();
//   }
//
//   Future<List<Map<String, dynamic>>> _fetchOpenBets() async {
//     String competitionName = CompetitionCache().competitionName ?? "No Competition Selected";
//     final token = 'BETLAJDNDNDBARKXTER';
//     String? phone = await RegistrationController.getPhoneNumber();
//     String? game = await RegistrationController.getGame();
//
//     if (phone == null || phone.isEmpty) {
//       logPrint("No saved phone number found.");
//       return [];
//     }
//
//     if (game == null || game.isEmpty) {
//       logPrint("No saved Games found.");
//       return [];
//     }
//
//     final url = Uri.parse(
//       'https://dhanmantragame.com/APIs/WebService1.asmx/openbets?token=$token&phone=$phone&Game=$competitionName',
//     );
//
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         return data.map((item) => item as Map<String, dynamic>).toList();
//       } else {
//         throw Exception('Failed to load bets');
//       }
//     } catch (e) {
//       throw Exception('Error fetching data: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: _openBetsFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               'Error: ${snapshot.error}',
//               style: TextStyle(color: Colors.red),
//               textAlign: TextAlign.center,
//             ),
//           );
//         }
//
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('No bets',style: TextStyle(color: Colors.white),));
//         }
//
//         final bets = snapshot.data!;
//
//         return ListView.builder(
//           padding: EdgeInsets.all(12),
//           itemCount: bets.length,
//           itemBuilder: (context, index) {
//             final bet = bets[index];
//
//             return Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 4,
//               margin: EdgeInsets.only(bottom: 12),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Type: ${bet['Type']}',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 4),
//                           Text('Money: ${bet['Money']}'),
//                           SizedBox(height: 4),
//                           Text('Date: ${bet['Bdate']}'),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           bet['Game'] ?? '',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(height: 6),
//                         Text(
//                           'Rate: ${bet['Rate']}',
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
