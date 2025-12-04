
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../main.dart';
import '../../../utils/validator.dart';
import '../../../widgets/reusable_button.dart';
import '../../profile/profilescreen.dart';


class WithdrawScreen extends StatelessWidget {

  final RegistrationController controller = Get.put(RegistrationController());
  final RegisterController controllerss = Get.put(RegisterController());
  final ImageController imageController = Get.put(ImageController());
  final RegisterController userController = Get.put(RegisterController());

  final TextEditingController amountController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController confirmAccountController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController upiController = TextEditingController();

  WithdrawScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double balance = double.tryParse(userController.userProfile.value?.balance.toString() ?? '0.0') ?? 0.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Dialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Container(
                width: constraints.maxWidth * 0.9,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppImages.splashLogo,
                          height: 50,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField("₹Amount", "Enter Your Amount", amountController, Icons.currency_rupee, "INR", Validators.validateWithdrawAmount),
                        Text(" Minimum withdrawal amount: ₹300", style: TextStyle(color: Colors.white, fontSize: 12)),
                        _buildTextField("Enter Account Name", "Enter Account Name", accountNameController, null, null, Validators.validateName),  // Optional field, no validator
                        _buildTextField("UPI", "Enter UPI", upiController, null, null, Validators.validateUPI),  // Mandatory UPI field
                        _buildTextField("IFSC Code", "Enter IFSC Code(Optional)", ifscController, null, null, null),  // Optional field, no validator
                        _buildTextField("Account", "Enter Your Account Number(Optional)", accountController, null, null, null),  // Optional field, no validator
                        _buildTextField("Confirm Account", "Confirm Account Number(Optional)", confirmAccountController, null, null,
                                null),  // Optional but with custom validator

                        const SizedBox(height: 10),

                        Obx(() =>ReusableButton(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              controllerss.isLoading.value = true;
                              double enteredAmount = double.tryParse(amountController.text) ?? 0.0;

                              if (balance >= enteredAmount) {
                                try {
                                  String? phone = await RegistrationController.getPhoneNumber();
                                  if (phone == null || phone.isEmpty) {
                                    logPrint("No saved phone number found.");
                                    controllerss.isLoading.value = false;
                                    return;
                                  }
                                  final user = UpdateBalanceModal(
                                    phone: phone,
                                    bal: amountController.text.toString(),
                                    token: 'BETLAJDNDNDBARKXTER', add: 'SUB',
                                  );
                                  imageController.setCurrentDate();
                                  imageController.generateTransactionId();
                                  final users = WithdrawAmountModal(
                                    token: 'BETLAJDNDNDBARKXTER',
                                    tid: imageController.transactionId.value,
                                    amt: amountController.text.toString(),
                                    purpose: '',
                                    type: 'Withdraw',
                                    tDate: imageController.selectedDate.value,
                                    accountNumber: accountController.text.toString(),
                                    ifsc: ifscController.text.toString(),
                                    branch: '',
                                    upi: upiController.text.toString(),
                                    phone: phone,
                                    dealer: '',
                                  );

                                 await  controllerss.UpdateBalnceMethod(user);
                                 await  controllerss.withdrawAmountMethod(users);
                                } catch (e) {
                                  logPrint("Error: $e");
                                } finally {
                                  controllerss.isLoading.value = false;
                                }
                              } else {
                                controllerss.isLoading.value = false;
                                // Show a proper message (you can use Get.snackbar or any other method you prefer)
                                Get.snackbar(
                                  "Insufficient Balance",
                                  "You don't have sufficient balance to withdraw.",
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                );
                              }
                            } else {
                              logPrint("Form Validation Failed");
                            }
                          },
                          text: controllerss.isLoadingss.value ? "Processing..." : "Withdraw",
                          backgroundColor: AppColors.getotp,
                          height: 35,
                          width: 300,
                        )

                          // ReusableButton(
                        //   onPressed: () async {
                        //     if (controller.formKey.currentState!.validate()) {
                        //       controllerss.isLoading.value = true;
                        //       try {
                        //         String? phone = await RegistrationController.getPhoneNumber();
                        //         if (phone == null || phone.isEmpty) {
                        //           logPrint("No saved phone number found.");
                        //           controllerss.isLoading.value = false;
                        //           return;
                        //         }
                        //         final user = WithdrawAmountModal(
                        //           token: 'BETLAJDNDNDBARKXTER',
                        //           tid: '',
                        //           amt: amountController.text.toString(),
                        //           purpose: '',
                        //           type: 'WITHDRAW',
                        //           tDate: '',
                        //           accountNumber: accountController.text.toString(),
                        //           ifsc: ifscController.text.toString(),
                        //           branch: '',
                        //           upi: upiController.text.toString(),
                        //           phone: phone,
                        //         );
                        //         await controllerss.withdrawAmountMethod(user);
                        //       } catch (e) {
                        //         logPrint("Error: $e");
                        //       } finally {
                        //         controllerss.isLoading.value = false;
                        //       }
                        //     } else {
                        //       logPrint("Form Validation Failed");
                        //     }
                        //   },
                        //   text: controllerss.isLoadingss.value ? "Processing..." : "Withdraw",
                        //   backgroundColor: AppColors.getotp,
                        //   height: 35,
                        //   width: 300,
                        // )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildTextField(String label, String hint, TextEditingController controller, IconData? icon, String? suffixText, String? Function(String?)? validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MandatoryLabel(labelText: label),
        const SizedBox(height: 5),
        CustomTextField(
          hintText: hint,
          controller: controller,
          prefixIcon: icon != null ? Icon(icon, size: 20) : null,
          suffixText: suffixText,
          validator: validator,
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}

void showWithdrawDialog() {
  Get.dialog(
    WithdrawScreen(),
    barrierDismissible: false,
  );
}

class MandatoryLabel extends StatelessWidget {
  final String labelText;
  const MandatoryLabel({Key? key, required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$labelText ",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // const TextSpan(
            //   text: "*",
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.red,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

