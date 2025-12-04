import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:sattagames/backend/jodi/jodi_controller.dart';
import 'package:sattagames/screens/allScreens/hrefgames/pages/crossing/first_page.dart';
import '../../../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../../../backend/crossing/CrossingController.dart';
import '../../../../../backend/crossing/crossing_controller_wallet.dart';
import '../../../NewGames/backend/apis/methods.dart';
import '../../../NewGames/games/color-pred/bottomsheet.dart';
import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../drawer/addmoney/updatebalance.dart';


class CrossingFullPage extends StatefulWidget {
  final String gameName;
  CrossingFullPage({super.key, required this.gameName});
  @override
  State<CrossingFullPage> createState() => _CrossingFullPageState();
}

class _CrossingFullPageState extends State<CrossingFullPage> {
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  // final InsertCrossingController controller = Get.put(InsertCrossingController());
  final CrossingControllerWallet walletController = Get.put(CrossingControllerWallet());
  final TextEditingController totalAmountController = TextEditingController(text: '0');
  final controller = Get.put(InsertBetController());
  final jcontroller = Get.put(JodiController());
  List<Map<String, String>> dataList = [];

  @override
  void initState() {
    super.initState();
    RegistrationController.getPhoneNumber().then((phone) {
      if (phone != null && phone.isNotEmpty) {
        walletController.fetchBalance(phone);
      }
    });
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    amountController.dispose();
    super.dispose();
  }

  List<String> generateCrossingNumbers(String first, String second) {
    List<String> combinations = [];
    for (var f in first.split('')) {
      for (var s in second.split('')) {
        combinations.add('$f$s');
      }
    }
    return combinations;
  }

  Future<void> addEntry() async {
    final first = firstController.text.trim();
    final second = secondController.text.trim();
    final amount = amountController.text.trim();

    if (first.isEmpty || second.isEmpty || amount.isEmpty) return;

    final crossingNumbers = generateCrossingNumbers(first, second);
    setState(() {
      dataList = crossingNumbers.map((number) => {"number": number, "amount": amount}).toList();
    });
  }

  Future<void> _submitBets() async {
    final int totalAmount = dataList.fold(0, (sum, item) => sum + int.parse(item['amount'] ?? '0'));
    // final int currentBalance = int.tryParse(walletController.balance.value) ?? 0;
    final RegisterController userController = Get.put(RegisterController());
    // int currentBalance = int.tryParse(jodiWalletController.balance.value) ?? 0;

   final double currentBalance = (double.tryParse(
        userController.userProfile.value?.balance.toString() ?? '0.0') ??
        0.0);
       // +
       //  (double.tryParse(
       //      userController.userProfile.value?.bonus.toString() ?? '0.0') ??
       //      0.0);
    if (currentBalance < totalAmount) {
      _showInsufficientBalanceDialog();
      return;
    }

    String? phone = await RegistrationController.getPhoneNumber();
    if (phone == null || phone.isEmpty) return;

    for (var bet in dataList) {
      await jcontroller.insertJodi(
        token: "ADFHNSAMALOUAAKL",
        betNumber: bet['number']!,
        gameName: widget.gameName,
        amount: bet['amount']!,
        name: "Jodi",
        phone: phone,
      );
      final UpdaBalanceControllersss datecontroller =
      Get.put(UpdaBalanceControllersss());
      datecontroller.setCurrentDate();
      await controller.insertBet(
        token: "ADFHNSAMALOUAAKL",
        date: datecontroller.selectedDate.value,
        gamename: "Satta Matka(${widget.gameName})",
        phone: phone!,
        amount: bet["amount"]!,
        winloose: '',
        bet: bet["number"]!,
        type: 'Jodi',
      );


    }

    await AppServices.updateWalletBalance("", totalAmount.toString(), 'SUB');

    if (phone.isNotEmpty) {
      await walletController.fetchBalance(phone);
    }
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    final int totalAmount = dataList.fold(
      0,
          (sum, item) => sum + int.parse(item['amount'] ?? '0'),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1D1D1D),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.check_circle_rounded,
                color: Colors.greenAccent, size: 60),
            const SizedBox(height: 16),
            const Text("Success",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 12),
            const Text("Your bets have been successfully submitted!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ✅ Keep Success popup open, show Bets popup
                _showBetsDialog(dataList, totalAmount);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text("View Bets",
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context); // Close Success popup
                    setState(() {
                      dataList.clear();
                      firstController.clear();
                      secondController.clear();
                      amountController.clear();
                    });
                  },
                  icon: const Icon(Icons.done, color: Colors.black),
                  label: const Text("OK",
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                const SizedBox(height: 10),

              ],
            ),
          ]),
        ),
      ),
    );
  }

  /// ✅ Bets Dialog
  void _showBetsDialog(List<Map<String, String>> bets, int totalAmount) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1D1D1D),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Your Bets",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.redAccent),
                  onPressed: () => Navigator.pop(context),
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Amount",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    ...bets.map((bet) => TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(bet['number'] ?? "",
                            style: const TextStyle(color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(bet['amount'] ?? "",
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ])),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            Text("Total Amount: $totalAmount",
                style: const TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ]),
        ),
      ),
    );
  }


  void _showInsufficientBalanceDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.red.shade800,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.warning_rounded, color: Colors.white, size: 60),
            const SizedBox(height: 16),
            const Text("Insufficient Balance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            const Text("You do not have enough balance to place this bet.",
                textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("OK", style: TextStyle(color: Colors.black)),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CrossingFirstPage(
                firstController: firstController,
                secondController: secondController,
                amountController: amountController,
                onAdd: addEntry,
              ),
              const SizedBox(height: 20),
              if (dataList.isNotEmpty) ...[
                Table(
                  border: TableBorder.all(color: Colors.white),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(color: Colors.grey),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Number", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Amount", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    ...dataList.map((data) => TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data["number"]!, style: const TextStyle(color: Colors.white)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            NumberFormat.decimalPattern().format(int.tryParse(data["amount"] ?? "0") ?? 0),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitBets,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Submit Bets", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
