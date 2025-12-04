// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../NewGames/backend/apis/methods.dart';
// import '../../../../../NewGames/games/color-pred/bottomsheet.dart';
// import '../../../../../authenticationsScreens/loginforgotregcontroller.dart';
// import '../../../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
// import '../../../../../backend/huraf/HarufController.dart';
// import '../../../../../backend/huraf/haruf_controller_wallet.dart';
// import '../../../../drawer/addmoney/updatebalance.dart';
//
// class GameSummaryWidget extends StatelessWidget {
//   final Map<String, String> inputs;
//   final String gameName;
//   final HarufController controller = Get.put(HarufController());
//   final HarufWalletController walletController = Get.put(HarufWalletController());
//   final controllerss = Get.put(InsertBetController());
//   GameSummaryWidget({
//     super.key,
//     required this.inputs,
//     required this.gameName,
//   });
//
//   int _calculateTotal(String prefix) {
//     int sum = 0;
//     inputs.forEach((key, value) {
//       if (key.startsWith(prefix)) {
//         sum += int.tryParse(value) ?? 0;
//       }
//     });
//     return sum;
//   }
//
//   Widget buildRow(String title, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         Container(
//           width: 80,
//           height: 50,
//           decoration: BoxDecoration(
//             color: const Color(0xFF222222),
//             border: Border.all(color: Colors.white),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           alignment: Alignment.center,
//           child: Text(value, style: const TextStyle(color: Colors.white)),
//         ),
//       ],
//     );
//   }
//
//   Future<void> _submitBets(BuildContext context, int totalAmount) async {
//     String? phone = await RegistrationController.getPhoneNumber();
//     if (phone == null || phone.isEmpty) {
//       Get.snackbar("Error", "Phone number not found.");
//       return;
//     }
//
//     await walletController.fetchBalance(phone);
//     final RegisterController userController = Get.put(RegisterController());
//     // int currentBalance = int.tryParse(jodiWalletController.balance.value) ?? 0;
//
//     final double currentBalance = (double.tryParse(
//         userController.userProfile.value?.balance.toString() ?? '0.0') ??
//         0.0) +
//         (double.tryParse(
//             userController.userProfile.value?.bonus.toString() ?? '0.0') ??
//             0.0);
//     // int currentBalance = int.tryParse(walletController.balance.value) ?? 0;
//
//     if (currentBalance < totalAmount) {
//       _showInsufficientBalanceDialog(context);
//       return;
//     }
//
//     controller.isLoading.value = true;
//
//     const token = "ADFHNSAMALOUAAKL";
//
//     for (var entry in inputs.entries) {
//       final betNumber = entry.key;
//       final amount = entry.value.trim();
//
//       if (amount.isNotEmpty) {
//         await controller.insertHaruf(
//           token: token,
//           betNumber: betNumber,
//           gameName: gameName, // ✅ Pass gameName here
//           amount: amount,
//           name: "Haruf",
//           phone: phone,
//         );
//
//         final UpdaBalanceControllersss datecontroller =
//         Get.put(UpdaBalanceControllersss());
//         datecontroller.setCurrentDate();
//         await controllerss.insertBet(
//           token: "ADFHNSAMALOUAAKL",
//           date: datecontroller.selectedDate.value,
//           gamename: "Satta Matka(${gameName})",
//           phone: phone!,
//           amount: amount,
//           winloose: '', bet: betNumber, type: 'Haruf',
//         );
//       }
//     }
//
//     // Deduct balance
//     await AppServices.updateWalletBalance("", totalAmount.toString(), 'SUB');
//
//     await walletController.fetchBalance(phone);
//
//     controller.isLoading.value = false;
//
//     _showSuccessDialog(context);
//   }
//
//   void _showInsufficientBalanceDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         backgroundColor: const Color(0xFF1D1D1D),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 60),
//               const SizedBox(height: 16),
//               const Text("Insufficient Balance", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
//               const SizedBox(height: 12),
//               const Text("You don't have enough balance to place this bet.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white70, fontSize: 14)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                 ),
//                 child: const Text("OK", style: TextStyle(color: Colors.white)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         backgroundColor: const Color(0xFF1D1D1D),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(Icons.check_circle, color: Colors.greenAccent, size: 60),
//               const SizedBox(height: 16),
//               const Text("Success", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
//               const SizedBox(height: 12),
//               const Text("Your bets have been successfully submitted!",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white70, fontSize: 14)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.greenAccent,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                 ),
//                 child: const Text("OK", style: TextStyle(color: Colors.black)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final totalAndar = _calculateTotal("A");
//     final totalBahar = _calculateTotal("B");
//     final totalAmount = totalAndar + totalBahar;
//
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white24),
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.black87,
//           ),
//           child: Column(
//             children: [
//               buildRow("Total Haruf Andar", totalAndar.toString()),
//               const SizedBox(height: 20),
//               buildRow("Total Haruf Bahar", totalBahar.toString()),
//               const SizedBox(height: 20),
//               buildRow("Total Amount", totalAmount.toString()),
//             ],
//           ),
//         ),
//         const SizedBox(height: 30),
//         SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: Obx(() {
//             return ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: controller.isLoading.value ? Colors.grey : const Color(0xFFFFD700),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//               ),
//               onPressed: controller.isLoading.value
//                   ? null
//                   : () => _submitBets(context, totalAmount),
//               child: controller.isLoading.value
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Text("Submit Bet", style: TextStyle(color: Colors.black)),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../NewGames/backend/apis/methods.dart';
import '../../../../../NewGames/games/color-pred/bottomsheet.dart';
import '../../../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../../../../backend/huraf/HarufController.dart';
import '../../../../../backend/huraf/haruf_controller_wallet.dart';
import '../../../../drawer/addmoney/updatebalance.dart';

class GameSummaryWidget extends StatelessWidget {
  final Map<String, String> inputs;
  final String gameName;
  final HarufController controller = Get.put(HarufController());
  final HarufWalletController walletController = Get.put(HarufWalletController());
  final controllerss = Get.put(InsertBetController());

  GameSummaryWidget({
    super.key,
    required this.inputs,
    required this.gameName,
  });

  int _calculateTotal(String prefix) {
    int sum = 0;
    inputs.forEach((key, value) {
      if (key.startsWith(prefix)) {
        sum += int.tryParse(value) ?? 0;
      }
    });
    return sum;
  }

  Widget buildRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF222222),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(value, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> _submitBets(BuildContext context, int totalAmount) async {
    String? phone = await RegistrationController.getPhoneNumber();
    if (phone == null || phone.isEmpty) {
      Get.snackbar("Error", "Phone number not found.");
      return;
    }

    await walletController.fetchBalance(phone);
    final RegisterController userController = Get.put(RegisterController());

    final double currentBalance =
        (double.tryParse(userController.userProfile.value?.balance.toString() ?? '0.0') ?? 0.0);
            // +
            // (double.tryParse(userController.userProfile.value?.bonus.toString() ?? '0.0') ?? 0.0);

    if (currentBalance < totalAmount) {
      _showInsufficientBalanceDialog(context);
      return;
    }

    controller.isLoading.value = true;

    const token = "ADFHNSAMALOUAAKL";

    for (var entry in inputs.entries) {
      final betNumber = entry.key;
      final amount = entry.value.trim();

      if (amount.isNotEmpty) {
        await controller.insertHaruf(
          token: token,
          betNumber: betNumber,
          gameName: gameName, // ✅ Pass gameName here
          amount: amount,
          name: "Haruf",
          phone: phone,
        );

        final UpdaBalanceControllersss datecontroller = Get.put(UpdaBalanceControllersss());
        datecontroller.setCurrentDate();
        await controllerss.insertBet(
          token: "ADFHNSAMALOUAAKL",
          date: datecontroller.selectedDate.value,
          gamename: "Satta Matka($gameName)",
          phone: phone,
          amount: amount,
          winloose: '',
          bet: betNumber,
          type: 'Haruf',
        );
      }
    }

    // Deduct balance
    await AppServices.updateWalletBalance("", totalAmount.toString(), 'SUB');

    await walletController.fetchBalance(phone);

    controller.isLoading.value = false;

    _showSuccessDialog(context, inputs, totalAmount);
  }

  void _showInsufficientBalanceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1D1D1D),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 60),
              const SizedBox(height: 16),
              const Text("Insufficient Balance",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 12),
              const Text("You don't have enough balance to place this bet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Success Dialog with OK + View Bets
  void _showSuccessDialog(BuildContext context, Map<String, String> bets, int totalAmount) {
    showDialog(
      context: context,
      barrierDismissible: false, // can't dismiss by tapping outside
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1D1D1D),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.greenAccent, size: 60),
              const SizedBox(height: 16),
              const Text("Success",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 12),
              const Text("Your bets have been successfully submitted!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // ✅ Don't close the first dialog
                      _showBetsDialog(context, bets, totalAmount);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text("View Bets", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), // ✅ Close only on OK
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text("OK", style: TextStyle(color: Colors.black)),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Bets Dialog with table
  void _showBetsDialog(BuildContext context, Map<String, String> bets, int totalAmount) {
    showDialog(
      context: context,
      barrierDismissible: true, // can close with back/close button
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1D1D1D),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title + Cancel
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Your Bets",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.redAccent),
                    onPressed: () => Navigator.pop(context), // only close bets popup
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Table
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: SingleChildScrollView(
                  child: Table(
                    border: TableBorder.all(color: Colors.white24, width: 1),
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                    },
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(color: Colors.white12),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Bet Number",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Amount",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      ...bets.entries
                          .where((entry) => entry.value.trim().isNotEmpty)
                          .map(
                            (entry) => TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(entry.key,
                                  style: const TextStyle(color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(entry.value,
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Text("Total Amount: $totalAmount",
                  style: const TextStyle(
                      color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final totalAndar = _calculateTotal("A");
    final totalBahar = _calculateTotal("B");
    final totalAmount = totalAndar + totalBahar;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(10),
            color: Colors.black87,
          ),
          child: Column(
            children: [
              buildRow("Total Haruf Andar", totalAndar.toString()),
              const SizedBox(height: 20),
              buildRow("Total Haruf Bahar", totalBahar.toString()),
              const SizedBox(height: 20),
              buildRow("Total Amount", totalAmount.toString()),
            ],
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: Obx(() {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.isLoading.value ? Colors.grey : const Color(0xFFFFD700),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: controller.isLoading.value
                  ? null
                  : () => _submitBets(context, totalAmount),
              child: controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Submit Bet", style: TextStyle(color: Colors.black)),
            );
          }),
        ),
      ],
    );
  }
}
