import 'package:sattagames/authenticationsScreens/google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




import '../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../constants/colors.dart';
import '../constants/images.dart';
import '../screens/allScreens/allscreens.dart';
import '../screens/cutomappbar/custom_app_bar.dart';
import '../screens/drawer/custom_drawer.dart';
import '../screens/home/home_screen.dart';
import '../utils/validator.dart';
import '../widgets/reusable_button.dart';
import 'Registrationscreen.dart';
import 'forgotpassword.dart';
import 'loginforgotregcontroller.dart';
class CountryCodeController extends GetxController {
  var selectedCountryCode = '+91'.obs;
  TextEditingController countrycode = TextEditingController();

  // Function to update country code and text field
  void updateCountryCode(String newCode) {
    selectedCountryCode.value = newCode;
    countrycode.text = "$newCode "; // Auto-update in text field
  }
}

class LoginDialouges extends StatelessWidget {
  GoogleSignInController googleController= Get.put(GoogleSignInController());
  final RegistrationController controller = Get.put(RegistrationController());
  final RegisterController controllerss = Get.put(RegisterController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final CountryCodeController countruController = Get.put(CountryCodeController());
  final RxBool isLoading = false.obs;

  // final Map<String, String> countryCodes = {
  //   'India': '+91',
  //   'USA': '+1 (US)',
  //   'UK': '+44',
  //   'Canada': '+1 (CA)',
  //   'Australia': '+61',
  //   'Germany': '+49',
  //   'France': '+33',
  //   'Italy': '+39',
  //   'Spain': '+34',
  //   'China': '+86',
  //   'Japan': '+81',
  //   'South Korea': '+82',
  //   'Brazil': '+55',
  //   'Russia': '+7',
  //   'Mexico': '+52',
  //   'South Africa': '+27',
  //   'Saudi Arabia': '+966',
  //   'United Arab Emirates': '+971',
  //   'Pakistan': '+92',
  //   'Bangladesh': '+880',
  //   'Sri Lanka': '+94',
  //   'Nepal': '+977',
  //   'Thailand': '+66',
  //   'Indonesia': '+62',
  //   'Malaysia': '+60',
  //   'Philippines': '+63',
  //   'Vietnam': '+84',
  //   'Turkey': '+90',
  //   'Argentina': '+54',
  //   'Colombia': '+57',
  //   'Nigeria': '+234',
  //   'Egypt': '+20',
  //   'Netherlands': '+31',
  //   'Sweden': '+46',
  //   'Switzerland': '+41',
  //   'Belgium': '+32',
  //   'Austria': '+43',
  //   'Denmark': '+45',
  //   'Norway': '+47',
  //   'Finland': '+358',
  //   'Portugal': '+351',
  //   'Greece': '+30',
  //   'New Zealand': '+64',
  //   'Ireland': '+353',
  //   'Poland': '+48',
  // };

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
                width: constraints.maxWidth * 0.9, // Responsive width
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:Colors.black
                ),

                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(), // Prevent scrolling
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),

                        /// 📌 **App Logo**
                        Image.asset(AppImages.splashLogo, height: 50),
                        const SizedBox(height: 10),

                        /// 📌 **Phone Number Field**
                        /// 📌 **Phone Number Field**

                        CustomTextField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: phoneController,
                          hintText: "XXXXXXXXXX",
                          keyboardType: TextInputType.phone,
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:  [
                              SizedBox(width: 10),
                              Obx(() => Text(countruController.selectedCountryCode.value, style: TextStyle(color: Colors.black))),
                              SizedBox(width: 10),
                              Text("-",  style: TextStyle(color: Colors.black)),

                              SizedBox(width: 1),
                            ],
                          ),

                          suffixIcon: Icon(Icons.phone_android_sharp, color: AppColors.getotp),
                          validator: Validators.validatePhoneNumber,
                        ),

                        const SizedBox(height: 15),

                        /// 📌 **OTP Field**

                        /// 📌 **Password Field**
                        Obx(
                              () => CustomTextField(
                                controller: passwordController,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                hintText: "Password",
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

SizedBox(height: 15,),
                        ReusableButton(
                          onPressed: () {
                            Get.close(1);
                            showForgotPassDialog();


                          },
                          text: "Forgot Password",
                          textColor: Colors.white,
                          backgroundColor:Colors.transparent,
                          height: 35,
                          width: 300,
                        ),


                        /// 📌 **Submit Button**
                        // ReusableButton(
                        //   onPressed: () async {
                        //     if (controller.formKey.currentState!.validate()) {
                        //       final user = loginUsers(
                        //         phone: emailController.text.trim(),  // ✅ Ensure phone is not empty
                        //         password: passwordController.text.trim().toString(),  // ✅ Ensure password is not empty
                        //         token: 'BETLAJDNDNDBARKXTER',
                        //         // code: countruController.countrycode.text.trim().toString(),
                        //         code: "",
                        //       );
                        //
                        //       bool isLoggedIn = await controllerss.loginUser(user); // Check login status
                        //
                        //       if (isLoggedIn) {
                        //         final authController = Get.find<AuthControllersss>();
                        //         await authController.setLoggedIn(true); // ✅ Save login state in SharedPreferences
                        //
                        //         Get.find<AppBarController>().login();
                        //
                        //         Get.back();
                        //         Get.offAll(() => MainHomeScreen());
                        //         Get.snackbar("Success", "Login Successful!",
                        //             backgroundColor: Colors.green, colorText: Colors.white);
                        //         await Future.delayed(Duration(milliseconds: 800));
                        //         RegistrationController.savePhoneNumber(phone: emailController.text);
                        //
                        //         // controller.saveLoginState();
                        //       } else {
                        //         logPrint("Login failed. User not authenticated.");
                        //       }
                        //     } else {
                        //       logPrint("Form Validation Failed");
                        //     }
                        //   },
                        //   text: "Submit",
                        //   backgroundColor: AppColors.primaryColor,
                        //   height: 35,
                        //   width: 300,
                        // ),
                        Obx(() => ReusableButton(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              isLoading.value = true; // ✅ Start loading

                              final user = loginUsers(
                                phone: phoneController.text.trim(),
                                password: passwordController.text.trim(),
                                token: 'BETLAJDNDNDBARKXTER',
                                code: "",
                              );

                              bool isLoggedIn = await controllerss.loginUser(user);

                              if (isLoggedIn) {
                                // final authController = Get.find<AuthControllersss>();
                                // await authController.setLoggedIn(true);
                                // logPrint("🔥 Login success, state saved in prefs: ${authController.isLoggedIn.value}");
                                Get.find<AppBarController>().login();
                                Get.back();
                                Get.offAll(() => MainHomeScreen());

                                Get.snackbar("Success", "Login Successful!",
                                    backgroundColor: Colors.green, colorText: Colors.white);
                                await Future.delayed(Duration(milliseconds: 800));
                                RegistrationController.savePhoneNumber(phone: phoneController.text);

                              } else {
                                Get.snackbar("Error", "Login Failed!",
                                    backgroundColor: Colors.red, colorText: Colors.white);
                              }

                              isLoading.value = false; // ✅ Stop loading
                            }
                          },
                          text: isLoading.value ? "Loading..." : "Submit", // ✅ Fixed
                          backgroundColor: AppColors.getotp,
                          height: 35,
                          width: 300,
                        )),


                        // const SizedBox(height: 10),
                        // const Text("Or Login With"),
                        const SizedBox(height: 8),
                        //
                        // /// 📌 **Social Login Buttons**
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     ReusableButton(
                        //       onPressed: () {
                        //         googleController.signInWithGoogle();
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
                        //     // ReusableButton(
                        //     //   onPressed: () {},
                        //     //   text: "Whatsapp",
                        //     //   textColor: AppColors.authenticationIconColor,
                        //     //   backgroundColor: Colors.transparent,
                        //     //   height: 35,
                        //     //   width: 120,
                        //     //   borderColor: AppColors.borderColoriconbutton,
                        //     //   borderWidth: 2,
                        //     //   imagePath: AppImages.whatIcons,
                        //     // ),
                        //    ]
                        // ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "New User?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(onPressed: (){
                              Get.back();
                              showRegistrationDialog();
                            }, child:Text("Create an account", style: TextStyle(color: Colors.blue),))
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

/// ✅ **Prevent Screen from Scrolling When Keyboard Opens**
void showLoginDialog() {
  Get.dialog(
    LoginDialouges(),
    barrierDismissible: false, // Prevent accidental dismiss
  );
}



