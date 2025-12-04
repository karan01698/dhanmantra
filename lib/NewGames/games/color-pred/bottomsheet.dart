import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../main.dart';
import '../../../screens/drawer/addmoney/updatebalance.dart';
import '../../backend/apis/methods.dart';
import '../roulette2/roulette/home/roulette/text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void showBettingBottomSheet(
  BuildContext context,
  final String date,
  final String number,
  final String type,
  final String roundid,
  final int walletBalance,
  final String email,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF0A1F44), // Dark background color
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return BettingBottomSheetContent(
        date: date,
        number: number,
        type: type,
        roundid: roundid,
        walletBalance: walletBalance,
        email: email,
      );
    },
  );
}

class BettingBottomSheetContent extends StatefulWidget {
  final String date;
  final String number;
  final String type;
  final String roundid;
  final int walletBalance;
  final String email;

  const BettingBottomSheetContent({
    super.key,
    required this.date,
    required this.number,
    required this.type,
    required this.roundid,
    required this.walletBalance,
    required this.email,
  });

  @override
  _BettingBottomSheetContentState createState() =>
      _BettingBottomSheetContentState();
}

class _BettingBottomSheetContentState extends State<BettingBottomSheetContent> {
  int selectedBalance = 0; // Default selected balance
  int quantity = 1; // Default quantity
  bool agreeToTerms = false; // Checkbox state
  final controller = Get.put(InsertBetController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Place Your Bet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Balance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [10, 50, 100, 1000].map((value) {
              return ChoiceChip(
                label: Text(
                  '₹ $value',
                  style: TextStyle(
                    color:
                        selectedBalance == value ? Colors.black : Colors.white,
                  ),
                ),
                selected: selectedBalance == value,
                onSelected: (selected) {
                  setState(() {
                    selectedBalance = value;
                  });
                },
                selectedColor: Colors.amber,
                backgroundColor: Colors.black,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Quantity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (quantity > 1) quantity--;
                  });
                },
                icon: const Icon(Icons.remove, color: Colors.white),
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: agreeToTerms,
                onChanged: (value) {
                  setState(() {
                    agreeToTerms = value ?? false;
                  });
                },
                activeColor: Colors.amber,
              ),
              const Flexible(
                child: Text(
                  'I agree to the terms and conditions',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: agreeToTerms
          //         ? () async {
          //             final amount = quantity * selectedBalance;
          //             if (amount <= widget.walletBalance) {
          //               await AppServices.updateWalletBalance(
          //                   widget.email, (amount).toString(), 'SUB');
          //               await AppServices.insertColorPredictionBet(
          //                 context,
          //                 roundId: widget.roundid,
          //                 number: widget.number,
          //                 type: widget.type,
          //                 amount: (amount * 0.98).toString(),
          //                 date: widget.date,
          //               );
          //   } else {
          //               Fluttertoast.showToast(msg: "Insufficient Balance");
          //             }
          //           }
          //         : null, // Disable button if terms are not agreed
          //     style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          //     child: CustomText(
          //       text: "Place Bet",
          //       color: agreeToTerms ? Colors.black : Colors.white,
          //     ),
          //   ),
          // ),
          Obx(() => SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (agreeToTerms && selectedBalance > 0 && !controller.isLoading.value)
                  ? () async {
                final amount = quantity * selectedBalance;

                if (amount <= widget.walletBalance) {
                  await AppServices.updateWalletBalance(
                      widget.email, amount.toString(), 'SUB');

                  await AppServices.insertColorPredictionBet(
                    context,
                    roundId: widget.roundid,
                    number: widget.number,
                    type: widget.type,
                    amount: (amount * 0.98).toString(),
                    date: widget.date,
                  );

                  String? phone = await RegistrationController.getPhoneNumber();
                  final UpdaBalanceControllersss datecontroller =
                  Get.put(UpdaBalanceControllersss());
                  datecontroller.setCurrentDate();

                  await controller.insertBet(
                    token: "ADFHNSAMALOUAAKL",
                    date: datecontroller.selectedDate.value,
                    gamename: "Color Prediction",
                    phone: phone!,
                    amount: amount.toString(),
                    winloose: '',  bet: widget.number, type: '',
                  );

                  if (controller.responseMessage.value == "Inserted") {
                    Fluttertoast.showToast(msg: "Bet placed successfully!");
                    // Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(msg: "Failed to place bet");
                  }
                } else {
                  Fluttertoast.showToast(msg: "Insufficient Balance");
                }
              }
                  : null, // Button disabled
              style: ElevatedButton.styleFrom(
                backgroundColor: (agreeToTerms && selectedBalance > 0)
                    ? Colors.amber
                    : Colors.grey.shade700, // Use grey when disabled
              ),
              child: controller.isLoading.value
                  ? CircularProgressIndicator(color: Colors.black)
                  : CustomText(
                text: "Place Bet",
                color: (agreeToTerms && selectedBalance > 0)
                    ? Colors.black
                    : Colors.white, // Adjust text color when disabled
              ),
            ),
          ))


        ],
      ),
    );
  }
}

class InsertResponseModel {
  final String message;

  InsertResponseModel({required this.message});

  factory InsertResponseModel.fromJson(Map<String, dynamic> json) {
    return InsertResponseModel(message: json['message'] ?? '');
  }
}

class InsertBetController extends GetxController {
  var isLoading = false.obs;
  var responseMessage = ''.obs;

  Future<void> insertBet({
    required String token,
    required String date,
    required String gamename,
    required String phone,
    required String amount,
    required String bet,
    required String type,
    required String winloose,
  }) async {
    isLoading.value = true;

    final url =
        "https://dhanmantragame.com/APIs/WebService1.asmx/InsertBetHistory?token=$token&date=$date&gamename=$gamename&phone=$phone&amount=$amount&bet=$bet&type=$type&winloose=$winloose";
logPrint("url https://dhanmantragame.com/APIs/WebService1.asmx/InsertBetHistory?token=$token&date=$date&gamename=$gamename&phone=$phone&amount=$amount&profit=$winloose&bet=$bet&type=$type");
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = InsertResponseModel.fromJson(data);
        logPrint("colrospreditresults ${data}");
        responseMessage.value = result.message;
        logPrint('✅ API Success: ${result.message}');
      } else {
        responseMessage.value = 'Failed with status: ${response.statusCode}';
        logPrint('❌ API Error: ${response.statusCode}');
      }
    } catch (e) {
      responseMessage.value = 'Error: $e';
      logPrint('❌ Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }
}


