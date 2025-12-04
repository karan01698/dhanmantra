// // import 'package:sattagames/screens/drawer/addmoney/paymentscreen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// //
// //
// // import '../../../authenticationsScreens/loginforgotregcontroller.dart';
// // import '../../../backend/authenticanapi/authencatemodals/registermodals.dart';
// // import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
// // import '../../../constants/colors.dart';
// // import '../../../utils/validator.dart';
// // import '../../../widgets/reusable_button.dart';
// //
// // class DepositControllersss extends GetxController {
// //   var selectedAmount = "".obs;
// //   TextEditingController amountController = TextEditingController();
// //
// //   GlobalKey<FormState> formKey = GlobalKey<FormState>();
// //
// //   void setAmount(String amount) {
// //     selectedAmount.value = amount;
// //     amountController.text = amount;
// //     amountController.selection = TextSelection.fromPosition(
// //       TextPosition(offset: amountController.text.length),
// //     );
// //   }
// //
// //   @override
// //   void onClose() {
// //     amountController.dispose();
// //     super.onClose();
// //   }
// // }
// //
// // class AddBalanceScreen extends StatelessWidget {
// //   final RegisterController controllerss = Get.put(RegisterController());
// //   final DepositControllersss controller = Get.put(DepositControllersss());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Deposit", style: TextStyle(color: AppColors.white)),
// //         backgroundColor: AppColors.getotp2,
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back, color: AppColors.white),
// //           onPressed: () => Get.back(),
// //         ),
// //       ),
// //       backgroundColor: AppColors.backgroundColor,
// //       body: Stack(
// //         children: [
// //           SingleChildScrollView(
// //             padding: const EdgeInsets.all(10.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //
// //                 GridView.count(
// //                   shrinkWrap: true,
// //                   crossAxisCount: 3,
// //                   crossAxisSpacing: 10,
// //                   mainAxisSpacing: 12,
// //                   childAspectRatio: 2.5,
// //                   children: ["500", "1000", "2000", "5000", "10000", "20000"].map((amount) {
// //                     return ReusableButton(
// //                       onPressed: () => controller.setAmount(amount),
// //                       text: "₹ $amount",
// //                       gradientColors: [AppColors.getotp1, AppColors.getotp2],
// //                       height: 80,
// //                     );
// //                   }).toList(),
// //                 ),
// //                 SizedBox(height: 20),
// //                 Text("Deposit Amount", style: TextStyle(color: AppColors.getotp, fontSize: 16)),
// //                 SizedBox(height: 8),
// //
// //                 CustomTextField(
// //                   controller: controller.amountController,
// //                   cursorColor: Colors.white,
// //                   keyboardType: TextInputType.number,
// //                   onChanged: (value) => controller.setAmount(value),
// //                   style: TextStyle(color: Colors.white),
// //                   decoration: InputDecoration(
// //                     prefixIcon: Icon(Icons.currency_rupee, color: Colors.white),
// //                     filled: true,
// //                     fillColor: Colors.black.withOpacity(0.6),
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(8),
// //                       borderSide: BorderSide.none,
// //                     ),
// //                     errorStyle: TextStyle(color: Colors.red),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return "Please fill amount";
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 10),
// //
// //                 SizedBox(height: 20),
// //                 SizedBox(height: 800, child: PaymentScreen()), // ✅ This content will scroll
// //               ],
// //             ),
// //           ),
// //
// //           // **Add Amount Button Stays Fixed at the Bottom**
// //           Positioned(
// //             bottom: 0,
// //             left: 0,
// //             right: 0,
// //             child: Container(
// //               color: AppColors.backgroundColor, // Background color for visibility
// //               padding: const EdgeInsets.all(2),
// //               child: Center(
// //                 child: ReusableButton(
// //                   width: 380,
// //                   height: 40,
// //                   onPressed: () async {
// //                     if (controller.formKey.currentState!.validate()) {
// //                       try {
// //                         String? phone = await RegistrationController.getPhoneNumber();
// //                         if (phone == null || phone.isEmpty) {
// //                           logPrint("No saved phone number found.");
// //                           return;
// //                         }
// //                         final user = UserModel(
// //                           phone: phone,
// //                           password: "",
// //                           promoCode: "",
// //                           name: "",
// //                           email: "",
// //                           balance: controller.amountController.text,
// //                           exposure: "",
// //                           token: 'BETLAJDNDNDBARKXTER', countryCode: '',
// //                         );
// //
// //                         controllerss.registerUser(user);
// //
// //                         logPrint("Deposit Successful: ${controller.amountController.text}");
// //                       } catch (e) {
// //                         logPrint("Error: $e");
// //                       }
// //                     }
// //                   },
// //                   text: "Add Amount",
// //                   gradientColors: [AppColors.getotp2, AppColors.getotp1],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../authenticationsScreens/loginforgotregcontroller.dart';
// import '../../../backend/authenticanapi/authencatemodals/registermodals.dart';
// import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
// import '../../../constants/colors.dart';
// import '../../../utils/validator.dart';
// import '../../../widgets/reusable_button.dart';
//
// class UpdaBalanceControllersss extends GetxController {
//   var selectedAmount = "".obs;
//   TextEditingController amountController = TextEditingController();
//
//   GlobalKey<FormState> formKey = GlobalKey<FormState>(); // ✅ Form Key
//
//   void setAmount(String amount) {
//     selectedAmount.value = amount;
//     amountController.text = amount;
//     amountController.selection = TextSelection.fromPosition(
//       TextPosition(offset: amountController.text.length),
//     );
//   }
//
//   @override
//   void onClose() {
//     amountController.dispose();
//     super.onClose();
//   }
// }
//
// class newUpdatebalanceScreens extends StatelessWidget {
//   final RegisterController controllerss = Get.put(RegisterController());
//   final UpdaBalanceControllersss controller = Get.put(UpdaBalanceControllersss());
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double buttonWidth = screenWidth * 0.4;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Update Balance", style: TextStyle(color: AppColors.white)),
//         backgroundColor: AppColors.getotp,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.white),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       backgroundColor: AppColors.backgroundColor,
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Form(
//           key: controller.formKey, // ✅ Wrap with Form
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Wrap(
//                 spacing: 15,
//                 runSpacing: 18,
//                 children: ["500", "1000", "2000", "5000", "10000", "20000"].map((amount) {
//                   return SizedBox(
//                     width: buttonWidth,
//                     child: ReusableButton(
//                       onPressed: () => controller.setAmount(amount),
//                       text: "₹ $amount",
//                       backgroundColor: AppColors.getotp,
//                       height: 80,
//                     ),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 20),
//               Text("Enter your updating amount", style: TextStyle(color: AppColors.getotp, fontSize: 16)),
//               SizedBox(height: 8),
//
//               CustomTextField(
//                 controller: controller.amountController,
//                 cursorColor: Colors.white,
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) => controller.setAmount(value),
//                 style: TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.currency_rupee, color: Colors.white),
//                   filled: true,
//                   fillColor: Colors.black.withOpacity(0.6),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                   errorStyle: TextStyle(color: Colors.red), // ✅ Show error in red
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please fill amount"; // ✅ Show red error message
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10,),
//
//               SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ReusableButton(
//                   onPressed: () async { // ✅ Make the function async
//                     if (controller.formKey.currentState!.validate()) {
//                       try {
//                         String? phone = await RegistrationController.getPhoneNumber(); // ✅ Await properly
//                         if (phone == null || phone.isEmpty) {
//                           logPrint("No saved phone number found.");
//                           return;
//                         }
//                         final user = UpdateBalanceModal(
//                           phone: phone,
//                           bal: controller.amountController.text,
//                           token: 'BETLAJDNDNDBARKXTER', add: 'ADD',
//                         );
//
//                         controllerss.UpdateBalnceMethod(user);
//
//                         logPrint("Balance Updated Successful: ${controller.amountController.text}");
//                       } catch (e) {
//                         logPrint("Error: $e");
//                       }
//                     }
//                   },
//                   text: "Add Amount",
//                   backgroundColor: AppColors.getotp,
//                 ),
//
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
