
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../backend/otpapi.dart';
import '../constants/colors.dart';
import '../constants/images.dart';
import '../utils/validator.dart';
import '../widgets/reusable_button.dart';
import 'login.dart';
import 'loginforgotregcontroller.dart';
import 'otp.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());
  final CountryCodeController countryController = Get.put(CountryCodeController());
  final TextEditingController otpController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                width: constraints.maxWidth * 0.9,
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(AppImages.splashLogo, height: 50),
                        const SizedBox(height: 10),

                        /// 📌 **Phone Number Field**
                        CustomTextField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: phoneController,
                          hintText: "XXXXXXXXXX",
                          keyboardType: TextInputType.phone,
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 10),
                              Obx(() => Text(
                              "+91",
                                style: TextStyle(color: Colors.black),
                              )),
                              SizedBox(width: 10),
                              Text("-", style: TextStyle(color: Colors.black)),
                              SizedBox(width: 1),
                            ],
                          ),
                          suffixIcon: IntrinsicHeight( // Ensures the button takes the full height
                            child: ReusableButton(
                              onPressed: () async{
                                controller.generateRandomNumber(); // Generate OTP once
                                final otp = controller.randomNumber.toString();
                                String phone = phoneController.text;
                                await  sendSms( phone, otp);

                              },
                              text: "Get OTP",
                              backgroundColor: AppColors.getotp,
                              height: double.infinity, // Makes button take full height of text field
                              width: 80,
                              fontSize: 12,
                            ),
                          ),
                          validator: Validators.validatePhoneNumber,
                          onChanged: (value) {

                            controller.phoneNumberLength.value = value.length;
                          },
                        ),
                        SizedBox(height: 10,),


                        const SizedBox(height: 2),
                        Align(
                          alignment: Alignment.topRight,
                          child: Obx(() => Text(
                            "${controller.phoneNumberLength.value}/10",
                            style: const TextStyle(color: Colors.grey),
                          )),
                        ),
                        const SizedBox(height: 5),

                        /// 📌 **OTP Field**
                        CustomTextField(
                          controller:otpController,
                          validator: (value) => Validators.validateOTP(value, controller.randomNumber.toString()),
                          hintText: "OTP",style: TextStyle(fontWeight: FontWeight.bold)
                          ,),
                        const SizedBox(height: 10),

                        /// 📌 **Password Field**
                        Obx(
                              () => CustomTextField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: passwordController,
                            hintText: "Enter your Password",
                            obscureText: controller.obscurePassword.value,
                            prefixIcon: const Icon(Icons.lock, size: 20),
                            prefixIconColor: AppColors.getotp,
                            suffixIconColor: AppColors.getotp,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscurePassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                              ),
                              onPressed: () {
                                controller.obscurePassword.value =
                                !controller.obscurePassword.value;
                              },
                            ),
                            validator: Validators.validatePassword,
                          ),
                        ),
                        const SizedBox(height: 10),

                        /// 📌 **Confirm Password Field**
                        Obx(
                              () => CustomTextField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: confirmPassController,
                            hintText: "Confirm Password",
                            obscureText: controller.obscureConfirmPassword.value,
                            prefixIcon: const Icon(Icons.lock, size: 20),
                            prefixIconColor: AppColors.getotp,
                            suffixIconColor: AppColors.getotp,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscureConfirmPassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                              ),
                              onPressed: () {
                                controller.obscureConfirmPassword.value =
                                !controller.obscureConfirmPassword.value;
                              },
                            ),
                            validator: (value) => Validators.validateConfirmPassword(
                                value, passwordController.text),
                          ),
                        ),
                        const SizedBox(height: 10),

                        /// 📌 **Submit Button**
                        ReusableButton(
                          onPressed: () async {
                            Get.close(1);
                            if (controller.formKey.currentState!.validate()) {
                              final user = forgotPasswordModal(
                                phone: phoneController.text,
                                password: passwordController.text,
                                token: "BETLAJDNDNDBARKXTER",
                              );

                              await registerController.forgotPasswordController(user);

                              // Get.snackbar(
                              //   "Success",
                              //   "Password Updated Successfully!",
                              //   backgroundColor: Colors.green,
                              //   colorText: Colors.white,
                              // );

                              
                            }
                          },
                          text: "Update Password",
                          backgroundColor: AppColors.getotp,
                          height: 35,
                          width: 300,
                          borderRadius: 6,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),

              /// 📌 **Cancel Icon (Top Right Inside Dialog)**
              Positioned(
                right: 10,
                top: 5,
                child: GestureDetector(
                  onTap: () => Get.close(1),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void showForgotPassDialog() {
  Get.dialog(
    ForgotPasswordDialog(),
    barrierDismissible: false,
  );
}
