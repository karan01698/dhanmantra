import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../NewGames/backend/apis/methods.dart';
import '../../../../NewGames/games/color-pred/bottomsheet.dart';
import '../../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../../../backend/jodi/jodi_controller.dart';
import '../../../../backend/jodi/jodi_controller_wallet.dart';
import '../../../drawer/addmoney/updatebalance.dart';
import '../../hrefgames/widget/jodi/input_widget.dart';


class JodiFullPage extends StatefulWidget {
  final String gameName;


  JodiFullPage({super.key, required this.gameName});
  @override
  State<JodiFullPage> createState() => _JodiFullPageState();
}

class _JodiFullPageState extends State<JodiFullPage> {
  final List<TextEditingController> controllers =
  List.generate(100, (index) => TextEditingController());
  final JodiController jodiController = Get.put(JodiController());
  final JodiControllerWallet jodiWalletController = Get.put(JodiControllerWallet());
  final TextEditingController totalJodiController = TextEditingController(text: '0');
  final TextEditingController totalAmountController = TextEditingController(text: '0');
  final controller = Get.put(InsertBetController());
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(_updateSummary);

    }

    RegistrationController.getPhoneNumber().then((phone) {
      if (phone != null && phone.isNotEmpty) {
        jodiWalletController.fetchBalance(phone);
      }
    });
  }

  void _updateSummary() {
    int totalJodi = 0;
    int totalAmount = 0;

    for (var controller in controllers) {
      final value = int.tryParse(controller.text.trim()) ?? 0;
      if (value > 0) {
        totalJodi += 1;
        totalAmount += value;
      }
    }

    totalJodiController.text = totalJodi.toString();
    totalAmountController.text = totalAmount.toString();
  }

  Future<void> _submitBets() async {
    String? phone = await RegistrationController.getPhoneNumber();
    if (phone == null || phone.isEmpty) {
      Get.snackbar("Error", "Phone number not found.");
      return;
    }

    int totalBetAmount = 0;
    List<Map<String, String>> validBets = [];

    for (int i = 0; i < controllers.length; i++) {
      String input = controllers[i].text.trim();
      int? amount = int.tryParse(input);
      if (amount != null && amount > 0) {
        String label = (i + 1).toString().padLeft(2, '0');
        totalBetAmount += amount;
        validBets.add({
          "label": label,
          "amount": input,
        });
      }
    }
    final RegisterController userController = Get.put(RegisterController());
    // int currentBalance = int.tryParse(jodiWalletController.balance.value) ?? 0;

    double currentBalance = (double.tryParse(
        userController.userProfile.value?.balance.toString() ?? '0.0') ??
        0.0) ;
        // +
        // (double.tryParse(
        //     userController.userProfile.value?.bonus.toString() ?? '0.0') ??
        //     0.0);


    if (currentBalance < totalBetAmount) {
      _showInsufficientBalanceDialog(context);
      return;
    }

    await AppServices.updateWalletBalance(
        "", totalAmountController.text, 'SUB');


    jodiController.isLoading.value = true;
    final UpdaBalanceControllersss datecontroller =
    Get.put(UpdaBalanceControllersss());
    datecontroller.setCurrentDate();
    for (var bet in validBets) {
      await controller.insertBet(
        token: "ADFHNSAMALOUAAKL",
        date: datecontroller.selectedDate.value,
        gamename: "matka(${widget.gameName})",
        phone: phone!,
        amount: bet["amount"]!,
        winloose: '', bet: bet["label"]!, type: 'Jodi',
      );
      await jodiController.insertJodi(
        token: "ADFHNSAMALOUAAKL",
        betNumber: bet["label"]!,
        gameName: widget.gameName,
        amount: bet["amount"]!,
        name: "Jodi",
        phone: phone,
      );
    }

    double updatedBalance = currentBalance - totalBetAmount;
    jodiWalletController.balance.value = updatedBalance.toString();

    jodiController.isLoading.value = false;
    _showSuccessDialog(context, validBets);
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
              const Text("Insufficient Balance", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
// ✅ Success Dialog
  void _showSuccessDialog(BuildContext context, List<Map<String, String>> bets) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1D1D1D),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle,
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

                  // ✅ View Bets Button (no pop here)
                  ElevatedButton(
                    onPressed: () {
                      _showBetDetailsDialog(context, bets);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text("View Bets",
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 10),

                  // ✅ OK Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // closes only Success dialog
                      _resetInputs();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text("OK",
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),

            // ✅ Top-right Cancel Button
            Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                icon: const Icon(Icons.cancel, color: Colors.redAccent, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

// ✅ Bet Details Dialog
  void _showBetDetailsDialog(BuildContext context, List<Map<String, String>> bets) {
    int totalAmount = bets.fold(
        0, (sum, bet) => sum + (int.tryParse(bet["amount"] ?? '0') ?? 0));

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1D1D1D),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Bet Details",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 15),

                  // ✅ Table Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Number",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
                      Text("Amount",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(color: Colors.white24),

                  // ✅ Bets List
                  ...bets.map((bet) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(bet["label"] ?? "",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                          Text(bet["amount"] ?? "",
                              style: const TextStyle(
                                  color: Colors.greenAccent, fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),

                  const Divider(color: Colors.white24),

                  // ✅ Total Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      Text("$totalAmount",
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ],
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), // only close this popup
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text("Close", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            // ✅ Top-right Cancel Button
            Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                icon: const Icon(Icons.cancel, color: Colors.redAccent, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // void _showSuccessDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       backgroundColor: const Color(0xFF1D1D1D),
  //       child: Padding(
  //         padding: const EdgeInsets.all(20),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Icon(Icons.check_circle, color: Colors.greenAccent, size: 60),
  //             const SizedBox(height: 16),
  //             const Text("Success", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
  //             const SizedBox(height: 12),
  //             const Text("Your bets have been successfully submitted!",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(color: Colors.white70, fontSize: 14)),
  //             const SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 _resetInputs();
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.greenAccent,
  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //               ),
  //               child: const Text("OK", style: TextStyle(color: Colors.black)),
  //             ),
  //           ],
  //           bet["amount"]!,
  //           bet["amount"]!,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _resetInputs() {
    for (var controller in controllers) {
      controller.clear();
    }
    _updateSummary();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    totalJodiController.dispose();
    totalAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 100,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                    childAspectRatio: 4/6,
                  ),
                  itemBuilder: (context, index) {
                    final label = (index + 1).toString().padLeft(2, '0');
                    return GameInputBox(
                      label: label,
                      controller: controllers[index],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1D1D),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow("Total Amount", totalAmountController),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GestureDetector(
                onTap: jodiController.isLoading.value ? null : _submitBets,
                child: Obx(() => Container(
                  width: double.infinity,
                  height: 55,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF3B0), Color(0xFFFFC940)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: jodiController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Submit Bets",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        SizedBox(
          width: 90,
          height: 40,
          child: TextField(
            controller: controller,
            readOnly: true,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    );
  }
}