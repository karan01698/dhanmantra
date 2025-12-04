import 'package:sattagames/authenticationsScreens/google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';


import '../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../backend/otpapi.dart';
import '../constants/colors.dart';
import '../constants/images.dart';
import '../screens/allScreens/allscreens.dart';
import '../screens/cutomappbar/custom_app_bar.dart';
import '../screens/drawer/custom_drawer.dart';
import '../screens/home/home_screen.dart';
import '../utils/validator.dart';
import '../widgets/reusable_button.dart';
import 'login.dart';
import 'loginforgotregcontroller.dart';
// Create a model for country details




class RegistrationDialog extends StatelessWidget {
  GoogleSignInController googleController= Get.put(GoogleSignInController());
  final RegistrationController controller = Get.put(RegistrationController());
  final RegisterController controllerss = Get.put(RegisterController());
  // final TabControllerssX tabController = Get.find<TabControllerssX>();
  final CountryCodeController countruController = Get.put(CountryCodeController());

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController promoCodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController exposureController = TextEditingController();
  final RxBool isLoading = false.obs;




  @override
  Widget build(BuildContext context) {
    String otp = "";
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
                width: constraints.maxWidth * 0.9, // Responsive width
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  // Prevent scrolling
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),

                        Image.asset(
                          AppImages.splashLogo,
                          height: 50,
                        ),
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
                                countruController.selectedCountryCode.value,
                                style: TextStyle(color: Colors.black),
                              )),
                              SizedBox(width: 10),
                              Text("-", style: TextStyle(color: Colors.black)),
                              SizedBox(width: 1),
                            ],
                          ),
                           suffixIcon: IntrinsicHeight(
                             child: Obx(() => ReusableButton(
                               onPressed:() async {
                                 controller.generateRandomNumber();
                                 String otp = controller.randomNumber.toString();
                                 String phone = phoneController.text;
                                 await sendSms(phone, otp);
                               },
                               text: controller.isOtpLoading.value ? "Sending..." : "Get OTP",
                               backgroundColor: AppColors.getotp,
                               height: double.infinity,
                               width: 80,
                               fontSize: 12,
                             )),
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
                        CustomTextField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: emailController,
                          hintText: "Enter your email",
                          prefixIcon: const Icon(Icons.email, size: 20),
                          prefixIconColor: AppColors.getotp,
                          validator: Validators.validateEmail,

                        ),
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
                        // Text("Password Length is 6 Digit",style: TextStyle(color: Colors.white,fontSize: 10), ),
                        const SizedBox(height: 10),

                        /// 📌 **Confirm Password Field**
                        Obx(
                          () => CustomTextField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            controller: confirmPassController,
                            hintText: "Confirm Password",
                            obscureText:
                                controller.obscureConfirmPassword.value,
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
                                value, passwordController.text), // ✅ Validate confirm password
                          ),
                          ),

                        const SizedBox(height: 10),

                        /// 📌 **Promo Code Field**

                        const SizedBox(height: 10),

                        /// 📌 **Submit Button* *

                        ReusableButton(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              isLoading.value = true; // ✅ Show loading state

                              final user = UserModel(
                                phone: phoneController.text,
                                password: passwordController.text,
                                promoCode: "",
                                name: "",
                                email: emailController.text,
                                balance: "0.00",
                                exposure: "0.00",
                                token: "BETLAJDNDNDBARKXTER", // 🔹 Assign dynamically later
                                countryCode: "",
                                bonus: "0.00"
                                // 🔹 Set correctly if needed
                              );

                              try {
                                bool isLoggedIn = await controllerss.registerUser(user);

                                if (isLoggedIn) {
                                  final authController = Get.find<AuthControllersss>();
                                  await authController.setLoggedIn(true); // ✅ Save login state

                                  Get.find<AppBarController>().login();
                                  Get.snackbar("Success", "Registration Successful!",
                                      backgroundColor: Colors.green, colorText: Colors.white);

                                  RegistrationController.savePhoneNumber(phone: phoneController.text);

                                  await Future.delayed(Duration(milliseconds: 500)); // Optional

                                  Get.offAll(() => MainHomeScreen());
                                  controller.saveLoginState();
                                } else {
                                  Get.snackbar("Error", "Already Register. Please Login.",
                                      backgroundColor: Colors.red, colorText: Colors.white);
                                }
                              } catch (e) {
                                Get.snackbar("Error", "Something went wrong: ${e.toString()}",
                                    backgroundColor: Colors.red, colorText: Colors.white);
                              } finally {
                                isLoading.value = false; // ✅ Hide loading state
                              }
                            } else {
                              Get.snackbar("Error", "Please fill in all fields correctly.",
                                  backgroundColor: Colors.orange, colorText: Colors.white);
                            }
                          },
                          text: isLoading.value ? "Loading..." : "Submit",
                          backgroundColor: AppColors.getotp,
                          height: 35,
                          width: 300,
                        ),
SizedBox(height: 10,),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     ReusableButton(
                        //       onPressed: () {
                        //
                        //           googleController.signInWithGoogle(); // existing mobile method
                        //
                        //
                        //       },
                        //       text: "Google",
                        //       textColor: AppColors.white,
                        //       backgroundColor: Colors.transparent,
                        //       height: 35,
                        //       width: 270,
                        //       borderColor: AppColors.borderColoriconbutton,
                        //       borderWidth: 0.5,
                        //       imagePath: AppImages.googleIcon,
                        //     ),
                        //   ],
                        // ),



                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(onPressed: (){
                              Get.back();
                              showLoginDialog();
                            }, child:Text("Login", style: TextStyle(color: Colors.blue),))
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              /// 📌 **Cancel Icon (Top Right Inside Dialog)**
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child:
                        const Icon(Icons.close, color: Colors.white, size: 20),
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

/// ✅ **Prevent Screen from Scrolling When Keyboard Opens**
void showRegistrationDialog() {
  Get.dialog(
    RegistrationDialog(),
    barrierDismissible: false, // Prevent accidental dismiss
  );
}
