// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../../authenticationsScreens/loginforgotregcontroller.dart';
// import '../../../backend/authenticanapi/authencatemodals/registermodals.dart';
//
//
// class BetProfileController extends GetxController {
//   var betProfiles = <GetBetProfileModal>[].obs;
//   var isLoading = true.obs;
//
//   @override
//   void onInit() {
//     fetchBetProfile();
//     super.onInit();
//   }
//
//   Future<void> fetchBetProfile() async {
//     try {
//       String? phone = await RegistrationController.getPhoneNumber(); // 🔹 Get saved phone number
//       if (phone == null || phone.isEmpty) {
//         logPrint("No saved phone number found.");
//         return;
//       }
//
//       final url = Uri.parse(
//           "https://dhanmantragame.com/APIs/WebService1.asmx/GetBet?token=BETLAJDNDNDBARKXTER&Game=aviator&Phone=9828705454");
//
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         betProfiles.value = jsonData.map((e) => GetBetProfileModal.fromJson(e)).toList();
//       } else {
//         betProfiles.clear();
//       }
//     } catch (e) {
//       logPrint("Error fetching user profile: $e");
//       betProfiles.clear();
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
//
// class Transcationsscreenss extends StatelessWidget {
//   final BetProfileController controller = Get.put(BetProfileController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Bet Profile")),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.betProfiles.isEmpty) {
//           return Center(child: Text("No data found"));
//         }
//
//         return ListView.builder(
//           itemCount: controller.betProfiles.length,
//           itemBuilder: (context, index) {
//             final profile = controller.betProfiles[index];
//             return Card(
//               margin: EdgeInsets.all(10),
//               child: ListTile(
//                 title: Text("Game: ${profile.game}"),
//                 subtitle: Text("Balance: ${profile.bal}"),
//                 trailing: ElevatedButton(
//                   onPressed: () {
//                     // Add button functionality here
//                   },
//                   child: Text("Click"),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//       bottomNavigationBar: Container(
//         color: Colors.black,
//         height: 60,
//         child: Center(
//           child: Text(
//             "INSERT BUTTON",
//             style: TextStyle(color: Colors.white, fontSize: 18),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;


import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../../constants/colors.dart';
import '../../../main.dart';
class Transcationsscreenss extends StatefulWidget {
  @override
  _BetProfileScreenState createState() => _BetProfileScreenState();
}

class _BetProfileScreenState extends State<Transcationsscreenss> {
  final StreamController<List<GetBetProfileModal>> _betProfileController =
  StreamController.broadcast();
  List<GetBetProfileModal> _betList = [];
  @override
  void initState() {
    super.initState();
    fetchBetProfile();
  }

  Future<void> fetchBetProfile() async {
    try {
      String? phone = await RegistrationController
          .getPhoneNumber(); // 🔹 Get saved phone number
      if (phone == null || phone.isEmpty) {
        logPrint("No saved phone number found.");
        return null;
      }

      String? game = await RegistrationController
          .getGame(); // 🔹 Get saved phone number
      if (game== null || game.isEmpty) {
        logPrint("No saved Games found.");
        return null;
      }
      final url = Uri.parse(
          "https://dhanmantragame.com/APIs/WebService1.asmx/GetBet?token=BETLAJDNDNDBARKXTER&Phone=$phone&Gamename=$game");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        // List<GetBetProfileModal> betProfiles =
        // jsonData.map((e) => GetBetProfileModal.fromJson(e)).toList();

        List<GetBetProfileModal> newBets = jsonData
            .map((e) => GetBetProfileModal.fromJson(e))
            .toList();
        // _betProfileController.add(betProfiles);
        _betList.addAll(newBets);
        _betProfileController.add(List.from(_betList));
      } else {
        logPrint("Failed to load profile: ${response.statusCode}");
        _betProfileController.add([]);
      }
    } catch (e) {
      logPrint("Error fetching user profile: $e");
      _betProfileController.add([]);
    }
  }

  @override
  void dispose() {
    // _betProfileController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Bet Profile",style: TextStyle(color: Colors.white),

      ),
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: Colors.black,

      ),
      body: StreamBuilder<List<GetBetProfileModal>>(
        stream: _betProfileController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data found"));
          }

          List<GetBetProfileModal> profiles = snapshot.data!;

          return ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              return Card(
                color: AppColors.white,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    "Game: ${profile.game},",
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 👈 aligns children to the left
                    children: [
                      Text("Type: ${profile.type}", style: TextStyle(color: Colors.blue)),
                      Text("Rate: ${profile.rate}", style: TextStyle(color: Colors.green)),
                      Row(
                        children: [
                          Text("Balance: ${profile.bal}", style: TextStyle(color: Colors.red)),
                          SizedBox(width: 100),
                          Text("Date: ${profile.bdate}", style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ],
                  ),
                ),
              );

            },
          );
        },
      ),

    );
  }
}
// Adjust the path accordingly

class ALLTransactionScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  String getTransactionMessage(String type) {
    switch (type) {
      case 'Add':
        return 'Processing';
      case 'Withdraw':
        return 'Withdraw';
      case 'DoneAdd':
        return 'Deposited';
      case 'Invalid':
        return 'Request Declined';
      case 'DoneWithdraw':
        return 'Amount Withdraw Successfully';
      default:
        return 'Unknown';
    }
  }

  Color getTransactionColor(String type) {
    switch (type) {
      case 'Add':
      case 'DoneAdd':
      case 'DoneWithdraw':
      case 'Withdraw':
        return Colors.green;
      case 'Invalid':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Transactions',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FutureBuilder<List<Transaction>>(
          future: controller.fetchTransactions(), // Your API call
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No transactions found.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final transactions = snapshot.data!;
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.currency_rupee, color: Colors.green),
                            SizedBox(width: 10),

                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [

                                Text(
                                  '${transaction.transactionAmt}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(width:80 ,),
                                Text(
                                  'Date:${transaction.tDate}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),



                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Transaction ID: ${transaction.transactionID}',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "Status: ",
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            Text(
                              getTransactionMessage(transaction.transactionType),
                              style: TextStyle(
                                fontSize: 16,
                                color: getTransactionColor(transaction.transactionType),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
class TableTransactionScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  String getTransactionMessage(String type) {
    switch (type) {
      case 'Add':
        return 'Processing';
      case 'Withdraw':
        return 'Withdraw';
      case 'DoneAdd':
        return 'Deposited';
      case 'Invalid':
        return 'Request Declined';
      case 'DoneWithdraw':
        return 'Amount Withdraw Successfully';
      default:
        return 'Unknown';
    }
  }

  Color getTransactionColor(String type) {
    switch (type) {
      case 'Add':
      case 'DoneAdd':
      case 'DoneWithdraw':
      case 'Withdraw':
        return Colors.green;
      case 'Invalid':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  TableCell tableCell(String text, {bool isHeader = false, Color? color}) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(

            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: isHeader ? Colors.white : color ?? Colors.black,
          ),
        ),
      ),
    );
  }

  TableRow buildHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.green),
      children: [
        tableCell('Transaction ID', isHeader: true),
        tableCell('Amount', isHeader: true),
        // Removed: tableCell('Type', isHeader: true),
        tableCell('Date', isHeader: true),
        tableCell('Status', isHeader: true),
      ],
    );
  }

  TableRow buildDataRow(Transaction transaction) {
    return TableRow(
      decoration: BoxDecoration(color: Colors.white),
      children: [
        tableCell(transaction.transactionID ?? ''),
        tableCell('${transaction.transactionAmt}'),
        // Removed: tableCell(transaction.transactionType ?? ''),
        tableCell(transaction.tDate ?? ''),
        tableCell(
          getTransactionMessage(transaction.transactionType),
          color: getTransactionColor(transaction.transactionType),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
        future: controller.fetchTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No transactions found.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final transactions = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 12),
            child: Column(
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),  // Transaction ID
                    1: FlexColumnWidth(1.5), // Amount
                    // Removed: 2: FlexColumnWidth(1.5), // Type
                    2: FlexColumnWidth(2),  // Date
                    3: FlexColumnWidth(3),  // Status
                  },
                  border: TableBorder.all(color: Colors.grey),
                  children: [
                    buildHeaderRow(),
                    ...transactions.map(buildDataRow).toList(),
                  ],
                ),
              ],
            ),
          );
        },

    );
  }
}
