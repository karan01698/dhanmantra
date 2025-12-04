import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../NewGames/backend/apis/methods.dart';
import '../../../NewGames/games/color-pred/bottomsheet.dart';
import '../../../NewGames/games/roulette2/roulette/home/roulette/wheel/wheel.dart';
import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../drawer/addmoney/updatebalance.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: SattaMatkaScreen(),
  ));
}

class SattaMatkaScreen extends StatefulWidget {
  @override
  _SattaMatkaScreenState createState() => _SattaMatkaScreenState();
}

class _SattaMatkaScreenState extends State<SattaMatkaScreen> {
  int? selectedNumber;
  final amountController = TextEditingController();
  final controller = Get.put(InsertBetController());
  final RegisterController userController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Satta Matka UK",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 8,
                backgroundColor: Colors.yellow.withOpacity(0.2),
                // 🔶 Transparent yellow
                shadowColor: Colors.blue,
                // 🔵 Blue shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                      color: Colors.yellow, width: 2), // 🔶 Yellow border
                ),
              ),
              onPressed: () {
                // Optional: Navigate to balance screen or do something
              },
              child: Obx(() {
                final balance = double.tryParse(
                        userController.userProfile.value?.balance.toString() ??
                            '0.0') ??
                    0.0;
                final bonus = double.tryParse(
                        userController.userProfile.value?.bonus.toString() ??
                            '0.0') ??
                    0.0;
                final total = balance + bonus;

                return Text(
                  "₹${total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white, // ✅ White text
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Number Grid
            Expanded(
              child: GridView.builder(
                itemCount: 100,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final number = index + 1;
                  final isSelected = selectedNumber == number;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedNumber = number;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.amber, width: 2),
                        color: isSelected ? Colors.amber : Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.4),
                            blurRadius: 6,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        number.toString().padLeft(2, '0'),
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 5),

            // Enter Number and Amount
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    if (selectedNumber != null)
                      Text(
                        "Selected Number: ${selectedNumber.toString().padLeft(2, '0')}",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    SizedBox(height: 10),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Enter Amount",
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      onPressed: () async {
                        if (selectedNumber == null ||
                            amountController.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please select a number and enter amount",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        String? phone =
                            await RegistrationController.getPhoneNumber();

                        if (phone == null || phone.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Phone number not found. Please log in.",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        // ✅ Set the date from date controller
                        final UpdaBalanceControllersss datecontroller =
                            Get.put(UpdaBalanceControllersss());
                        datecontroller.setCurrentDate();
                        await AppServices.updateWalletBalance(
                            "e", amountController.text, 'SUB');
                        // ✅ Call the insertBet API with amount and number (as profit)
                        await controller.insertBet(
                          token: "ADFHNSAMALOUAAKL",
                          date: datecontroller.selectedDate.value,
                          gamename: "Satta Matka",
                          phone: phone,
                          amount: amountController.text,
                          // ✅ Amount passed here
                          winloose : selectedNumber
                              .toString()
                              .padLeft(2, '0'), bet: '', type: '', // ✅ Number passed here
                        );

                        // ✅ Show success snackbar
                        Get.snackbar(
                          "Success",
                          "Number ${selectedNumber.toString().padLeft(2, '0')} placed with amount ₹${amountController.text}",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      },
                      child: Text("Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
