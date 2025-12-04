import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../../constants/colors.dart';
import '../../../main.dart';
import '../../../utils/validator.dart';
import '../../../widgets/reusable_button.dart';

class DepositController extends GetxController {
  var selectedAmount = "".obs;
  TextEditingController amountController = TextEditingController();
  TextEditingController gamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>(); // ✅ Form Key

  void setAmount(String amount) {
    selectedAmount.value = amount;
    amountController.text = amount;
    amountController.selection = TextSelection.fromPosition(
      TextPosition(offset: amountController.text.length),
    );
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}

class DepositAddMoneyScreen extends StatelessWidget {
  final RegisterController controllerss = Get.put(RegisterController());
  final DepositController controller = Get.put(DepositController());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonWidth = screenWidth * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: Text("Bet", style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.getotp,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: controller.formKey, // ✅ Wrap with Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                spacing: 15,
                runSpacing: 18,
                children: ["500", "1000", "2000", "5000", "10000", "20000"].map((amount) {
                  return SizedBox(
                    width: buttonWidth,
                    child: ReusableButton(
                      onPressed: () => controller.setAmount(amount),
                      text: "₹ $amount",
                      backgroundColor: AppColors.getotp,
                      height: 80,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text("Place Bet", style: TextStyle(color: AppColors.getotp, fontSize: 16)),
              SizedBox(height: 8),

              CustomTextField(
                controller: controller.amountController,
                cursorColor: Colors.white,
                keyboardType: TextInputType.number,
                onChanged: (value) => controller.setAmount(value),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.currency_rupee, color: Colors.white),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  errorStyle: TextStyle(color: Colors.red), // ✅ Show error in red
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill amount"; // ✅ Show red error message
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              CustomTextField(
                hintText: "Enter your game name",
                controller: controller.gamecontroller,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter your game name",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)), // ✅ Corrected placement
                  prefixIcon: Icon(Icons.gamepad_outlined, color: Colors.white),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  errorStyle: TextStyle(color: Colors.red), // ✅ Show error in red
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter game"; // ✅ Show red error message
                  }
                  return null;
                },
              ),


              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: ReusableButton(
                    onPressed: () async { // ✅ Make the function async
                      if (controller.formKey.currentState!.validate()) {
                        try {
                          String? phone = await RegistrationController.getPhoneNumber(); // ✅ Await properly
                          if (phone == null || phone.isEmpty) {
                            logPrint("No saved phone number found.");
                            return;
                          }

                          final user = InsertbetUserModal(
                            token: 'BETLAJDNDNDBARKXTER',
                            game: controller.gamecontroller.text,
                            money: controller.amountController.text,
                            rate: '',
                            type: 'SUB',
                            phone: phone, bdate: '', game2: '', // ✅ Assign fetched phone
                          );
                          // RegistrationController.savePhoneNumber(phone:controller.phonecontroller.text.toString());
                          RegistrationController.saveGame(game:controller.gamecontroller.text.toString());
                          controllerss.insertUsercon(user);
                          logPrint("Bet Placed  Successfully: ${controller.amountController.text}");
                        } catch (e) {
                          logPrint("Error: $e");
                        }
                      }
                    },
                    text: "Place Bet",
                    backgroundColor: AppColors.getotp,
                  ),
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
