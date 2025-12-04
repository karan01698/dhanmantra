// import 'package:sattagames/authenticationsScreens/loginforgotregcontroller.dart';
// import 'package:sattagames/backend/authenticanapi/authencatemodals/registermodals.dart';
// import 'package:sattagames/backend/authenticanapi/controllerapi/registerapicontroller.dart';
// import 'package:sattagames/constants/colors.dart';
// import 'package:sattagames/screens/drawer/addmoney/placebet.dart';
// import 'package:sattagames/screens/drawer/custom_drawer.dart';
// import 'package:sattagames/screens/home/inplay.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
//
//
// class LiveScreensDatas extends StatelessWidget {
//   final BettingController bettingController = Get.put(BettingController());
//   final controller = Get.find<MatchController>();
//   final RegisterController controllerss = Get.put(RegisterController());
//   final AuthControllersss authController = Get.find<AuthControllersss>();
//
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return Padding(
//       padding: EdgeInsets.all(screenWidth * 0.01),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Odds & Stake Labels
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildText("ODDS",),
//               _buildText("STAKE"),
//               _buildText("Max Mkt: 2,50,000"),
//             ],
//           ),
//           SizedBox(height: screenHeight * 0.01),
//
//           // Odds & Stake Boxes
//           Row(
//             children: [
//               Expanded(
//                 child: Obx(() {
//                   final value = controller.selectedValue.value ?? "";
//                   return _buildBox(value.isEmpty ? "Tap on a cell to select" : value);
//                 }),
//               ),
//
//               // Text(
//               // "Selected Game: ${controller.selectedGame.value ?? "None"}\nSelected Value: ${controller.selectedValue.value ?? "None"}",
//               // textAlign: TextAlign.center,
//               // style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               // ),
//               SizedBox(width: screenWidth * 0.02),
//               Expanded(
//                 child: Obx(() => _buildBox("${bettingController.stakeAmount.value}")),
//               ),
//             ],
//           ),
//           SizedBox(height: screenHeight * 0.02),
//
//           // Betting Amount Buttons
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xffe4e4e4),
//               borderRadius: BorderRadius.circular(5),
//             ),
//             padding: EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 SizedBox(height: 3),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildGradientButton(context, "+1,000", 1000),
//                     _buildGradientButton(context, "+10,000", 10000),
//                     _buildGradientButton(context, "+20,000", 20000),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildGradientButton(context, "+2,000", 2000),
//                     _buildGradientButton(context, "+15,000", 15000),
//                     _buildGradientButton(context, "+25,000", 25000),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.001),
//
//           // Cancel & Place Bet Buttons
//           Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Get.find<MatchController>().cancelSelection();
//                     bettingController.resetStake();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                     side: BorderSide(color: Colors.red),
//                   ),
//                   child: Text("Cancel Bet", style: TextStyle(color: Colors.red, fontSize: screenWidth * 0.03)),
//                 ),
//               ),
//               SizedBox(width: screenWidth * 0.02),
//               Expanded(
//
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (authController.isLoggedIn.value) {
//                       _showConfirmationDialog(context);
//                     } else {
//                       Get.snackbar("Access Denied", "Please log in to continue.",
//                           backgroundColor: Colors.red, colorText: Colors.white);
//                     }
//
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.getotp,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                     side: BorderSide(color: Colors.red),
//                   ),
//                   child: Text("Place Bet", style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//
//
//           SizedBox(height: screenHeight * 0.002),
//
//           // Confirm Bet with Switch
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   children: [
//           //     Text(
//           //       "Confirm bet before placing",
//           //       style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.black),
//           //     ),
//           //     Transform.scale(
//           //       scale: 0.8,
//           //       child: Obx(() => Switch(
//           //         value: bettingController.isSwitched.value,
//           //         onChanged: (bool value) {
//           //           bettingController.toggleSwitch();
//           //         },
//           //         activeColor: Colors.white,
//           //         activeTrackColor: Colors.green,
//           //         inactiveThumbColor: Colors.black,
//           //         inactiveTrackColor: Colors.white,
//           //       )),
//           //     ),
//           //   ],
//           // ),
//         ],
//       ),
//     );
//   }
//
//   void _showConfirmationDialog(BuildContext context) {
//     if (bettingController.stakeAmount.value == 0 || (controller.selectedValue.value == null || controller.selectedValue.value!.isEmpty)) {
//       Get.snackbar("Error", "Please select your amount and rate", backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     Get.defaultDialog(
//       title: "Confirm Bet",
//       middleText: "Game: ${controller.selectedGame.value}\nAmount: ${bettingController.stakeAmount.value}\nRate: ${controller.selectedValue.value}",
//       textConfirm: "Yes",
//       textCancel: "No",
//       confirmTextColor: Colors.white,
//       onConfirm: () async {
//         try {
//           String? phone = await RegistrationController.getPhoneNumber();
//           if (phone == null || phone.isEmpty) {
//             Get.snackbar("Error", "No saved phone number found.", backgroundColor: Colors.red, colorText: Colors.white);
//             return;
//           }
//
//           final user = InsertbetUserModal(
//             token: 'BETLAJDNDNDBARKXTER',
//             game:  controller.selectedGame.value ?? '',
//             money: "${bettingController.stakeAmount.value}",
//             rate: controller.selectedValue.value ?? '',
//             type: 'SUB',
//             phone: phone, bdate: '', game2: '',
//
//           );
//           RegistrationController.saveGame(game:controller.selectedGame.value.toString());
//           controllerss.insertUsercon(user);
//
//           Get.back(); // Close the dialog
//           Get.snackbar("Success", "Bet Placed Successfully!", backgroundColor: Colors.green, colorText: Colors.white);
//         } catch (e) {
//           Get.snackbar("Error", "Something went wrong!", backgroundColor: Colors.red, colorText: Colors.white);
//         }
//       },
//     );
//   }
//
//   Widget _buildText(String text) {
//     return Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white));
//   }
//
//   Widget _buildBox(String text) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Center(child: Text(text, style: TextStyle(fontSize: 10))),
//     );
//   }
//
//   Widget _buildGradientButton(BuildContext context, String text, int amount) {
//     return ElevatedButton(
//       onPressed: () {
//         bettingController.addStake(amount);
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.getotp2,
//         shadowColor: Colors.transparent,
//       ),
//       child: Text(text, style: TextStyle(color: Colors.white)),
//     );
//   }
// }
