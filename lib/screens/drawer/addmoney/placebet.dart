// // import 'package:sattagames/screens/drawer/addmoney/competions/LIveclass.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// // import '../../../authenticationsScreens/loginforgotregcontroller.dart';
// // import '../../../backend/authenticanapi/authencatemodals/registermodals.dart';
// // import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
// // import '../../../constants/colors.dart';
// // import '../../home/inplay.dart';
// // import '../custom_drawer.dart';
// //
// // class BettingController extends GetxController {
// //   var isSwitched = false.obs;
// //   var stakeAmount = 0.obs;
// //   var gameName = "".obs;
// //
// //   void toggleSwitch() {
// //     isSwitched.value = !isSwitched.value;
// //   }
// //
// //   void addStake(int amount) {
// //     stakeAmount.value += amount;
// //   }
// //
// //   void resetStake() {
// //     stakeAmount.value = 0;
// //   }
// // }
// //
// // class BettingScreenss extends StatelessWidget {
// //   GameController gameController=Get.find<GameController>();
// //
// //
// //   final BettingController bettingController = Get.put(BettingController());
// //   final controller = Get.find<MatchController>();
// //   final RegisterController controllerss = Get.put(RegisterController());
// //   final AuthControllersss authController = Get.find<AuthControllersss>();
// //
// //   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     double screenWidth = MediaQuery.of(context).size.width;
// //     double screenHeight = MediaQuery.of(context).size.height;
// //
// //     return Padding(
// //       padding: EdgeInsets.all(screenWidth * 0.01),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Odds & Stake Labels
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               _buildText("ODDS",),
// //               _buildText("STAKE"),
// //               _buildText("Max Mkt: 2,50,000"),
// //             ],
// //           ),
// //           SizedBox(height: screenHeight * 0.01),
// //
// //           // Odds & Stake Boxes
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: Obx(() {
// //
// //                   final value = gameController.selectedOdds.value ?? "";
// //                   return _buildBox(value.isEmpty ? "Tap on a cell to select" : value);
// //                 }),
// //               ),
// //
// //               SizedBox(width: screenWidth * 0.02),
// //               Expanded(
// //                 child: Obx(() => _buildBox("${bettingController.stakeAmount.value}")),
// //               ),
// //             ],
// //           ),
// //           SizedBox(height: screenHeight * 0.02),
// //
// //           // Betting Amount Buttons
// //           Container(
// //             decoration: BoxDecoration(
// //               color: Color(0xffe4e4e4),
// //               borderRadius: BorderRadius.circular(5),
// //             ),
// //             padding: EdgeInsets.all(8.0),
// //             child: Column(
// //               children: [
// //                 SizedBox(height: 3),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     _buildGradientButton(context, "+100", 1000),
// //                     _buildGradientButton(context, "+200", 10000),
// //                     _buildGradientButton(context, "+500", 20000),
// //                   ],
// //                 ),
// //                 SizedBox(height: 12),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     _buildGradientButton(context, "+1000", 1000),
// //                     _buildGradientButton(context, "+5000", 10000),
// //                     _buildGradientButton(context, "+10000", 20000),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(height: screenHeight * 0.001),
// //
// //           // Cancel & Place Bet Buttons
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     Get.find<GameController>().clearBet() ;
// //                     Get.find<MatchController>().cancelSelection();
// //                     bettingController.resetStake();
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
// //                     side: BorderSide(color: Colors.red),
// //                   ),
// //                   child: Text("Cancel Bet", style: TextStyle(color: Colors.red, fontSize: screenWidth * 0.03)),
// //                 ),
// //               ),
// //               SizedBox(width: screenWidth * 0.02),
// //               Expanded(
// //
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     if (authController.isLoggedIn.value) {
// //                       _showConfirmationDialog(context);
// //                     } else {
// //                       Get.snackbar("Access Denied", "Please log in to continue.",
// //                           backgroundColor: Colors.red, colorText: Colors.white);
// //                     }
// //
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.getotp,
// //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
// //                     side: BorderSide(color: Colors.red),
// //                   ),
// //                   child: Text("Place Bet", style: TextStyle(color: Colors.white)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //
// //
// //           SizedBox(height: screenHeight * 0.002),
// //
// //           // Confirm Bet with Switch
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 "Confirm bet before placing",
// //                 style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.black),
// //               ),
// //               Transform.scale(
// //                 scale: 0.8,
// //                 child: Obx(() => Switch(
// //                   value: bettingController.isSwitched.value,
// //                   onChanged: (bool value) {
// //                     bettingController.toggleSwitch();
// //                   },
// //                   activeColor: Colors.white,
// //                   activeTrackColor: Colors.green,
// //                   inactiveThumbColor: Colors.black,
// //                   inactiveTrackColor: Colors.white,
// //                 )),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   void _showConfirmationDialog(BuildContext context) {
// //     if (bettingController.stakeAmount.value == 0 || (gameController.selectedGameType.value.toString() == null || gameController.selectedOdds.value!.isEmpty)) {
// //       Get.snackbar("Error", "Please select your amount and rate", backgroundColor: Colors.red, colorText: Colors.white);
// //       return;
// //     }
// //
// //     Get.defaultDialog(
// //       title: "Confirm Bet",
// //       middleText: "Game: ${gameController.selectedGameType.value.toString()}\nAmount: ${bettingController.stakeAmount.value}\nRate: ${gameController.selectedOdds.value}",
// //       textConfirm: "Yes",
// //       textCancel: "No",
// //       confirmTextColor: Colors.white,
// //       onConfirm: () async {
// //         try {
// //           String? phone = await RegistrationController.getPhoneNumber();
// //           if (phone == null || phone.isEmpty) {
// //             Get.snackbar("Error", "No saved phone number found.", backgroundColor: Colors.red, colorText: Colors.white);
// //             return;
// //           }
// //
// //           final user = InsertbetUserModal(
// //             token: 'BETLAJDNDNDBARKXTER',
// //             game:  gameController.selectedGameType.value.toString() ?? '',
// //             money: "${bettingController.stakeAmount.value}",
// //             rate: gameController.selectedOdds.value ?? '',
// //             type: 'SUB',
// //             phone: phone,
// //
// //           );
// //           RegistrationController.saveGame(game:gameController.selectedGameType.value.toString());
// //           controllerss.insertUsercon(user);
// //
// //           Get.back(); // Close the dialog
// //           Get.snackbar("Success", "Bet Placed Successfully!", backgroundColor: Colors.green, colorText: Colors.white);
// //         } catch (e) {
// //           Get.snackbar("Error", "Something went wrong!", backgroundColor: Colors.red, colorText: Colors.white);
// //         }
// //       },
// //     );
// //   }
// //
// //   Widget _buildText(String text) {
// //     return Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white));
// //   }
// //
// //   Widget _buildBox(String text) {
// //     return Container(
// //       padding: EdgeInsets.symmetric(vertical: 10),
// //       decoration: BoxDecoration(
// //         color: Colors.grey[200],
// //         borderRadius: BorderRadius.circular(5),
// //       ),
// //       child: Center(child: Text(text, style: TextStyle(fontSize: 10))),
// //     );
// //   }
// //
// //   Widget _buildGradientButton(BuildContext context, String text, int amount) {
// //     return ElevatedButton(
// //       onPressed: () {
// //         bettingController.addStake(amount);
// //       },
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: AppColors.getotp2,
// //         shadowColor: Colors.transparent,
// //       ),
// //       child: Text(text, style: TextStyle(color: Colors.white)),
// //     );
// //   }
// // }
// import 'package:sattagames/screens/drawer/addmoney/competions/LIveclass.dart';
// import 'package:sattagames/utils/validator.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../authenticationsScreens/loginforgotregcontroller.dart';
// import '../../../backend/authenticanapi/authencatemodals/registermodals.dart';
// import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
// import '../../../backend/exposureapi.dart';
// import '../../../constants/colors.dart';
// import '../../home/inplay.dart';
// import '../custom_drawer.dart';
// import 'CompetitionDetailScreen.dart';
//
// class BettingController extends GetxController {
//   var isSwitched = false.obs;
//   var stakeAmount = 0.obs;
//   var gameName = "".obs;
//   var selectedDate = ''.obs;
//   TextEditingController stakeController = TextEditingController(); // Added controller
//
//   void setCurrentDate() {
//     final now = DateTime.now();
//     final formatted = DateFormat('dd.MM.yyyy').format(now); // 👈 this gives 17.04.2025
//     selectedDate.value = formatted;
//     logPrint('Selected Date: $formatted');
//   }
//   void onInit() {
//     super.onInit();
//     stakeController.text = stakeAmount.value.toString(); // Initialize with 0
//     stakeController.addListener(() {
//       stakeAmount.value = int.tryParse(stakeController.text) ?? 0;
//     });
//   }
//
//
//   void toggleSwitch() {
//     isSwitched.value = !isSwitched.value;
//   }
//
//   void resetStake() {
//     stakeAmount.value = 0;
//     stakeController.text = "0"; // Reset the text field
//   }
//
//   void addStake(int amount) {
//     stakeAmount.value += amount;
//     stakeController.text = stakeAmount.value.toString(); // Update text field
//   }
//
//   @override
//   void onClose() {
//     stakeController.dispose(); // Dispose controller when not needed
//     super.onClose();
//   }
// }
//
//
// class BettingScreenss extends StatelessWidget {
//   final RegisterController userController = Get.put(RegisterController());
//   final GameController gameController = Get.find<GameController>();
//   final BettingController bettingController = Get.put(BettingController());
//   final RegisterController controllerss = Get.put(RegisterController());
//   final AuthControllersss authController = Get.find<AuthControllersss>();
//   final exposureController = Get.put(ExposureController());
//
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(0xffa7d9fe)
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(screenWidth * 0.01),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Odds & Stake Labels
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildText("ODDS"),
//                 Obx(() {
//                   double odds = double.tryParse(gameController.selectedOdds.value) ?? 0.0;
//                   double stake = double.tryParse(bettingController.stakeController.text) ?? 0.0;
//                   double totalWin = odds * stake;
//
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 8),
//                     child: Text(
//
//                       "You can win: ${totalWin.toStringAsFixed(2)}",
//                       style: TextStyle(
//                         shadows: [
//                           Shadow(
//                             color: Colors.yellowAccent.withOpacity(0.7), // Glowing effect
//                             blurRadius: 15,
//                             offset: Offset(0, 2),
//                           ),
//                           Shadow(
//                             color: Colors.black.withOpacity(0.5), // Darker text depth
//                             blurRadius: 8,
//                             offset: Offset(2, 2),
//                           ),
//                         ],
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white, // White text for visibility
//                           letterSpacing: 1.3,
//                           // decoration: TextDecoration.underline, // Underline for highlight
//                           decorationColor: Colors.amberAccent, // Golden underline
//
//                           fontSize: 14, ),
//                     ),
//                   );
//                 }),
//
//                 _buildText("STAKE"),
//                 _buildText("Max Mkt: 2,50,000"),
//               ],
//             ),
//             SizedBox(height: screenHeight * 0.01),
//
//
//
//             // Odds & Stake Boxes
//             Row(
//               children: [
//                 Expanded(
//                   child: Obx(() {
//                     final value = gameController.selectedOdds.value ?? "";
//                     return _buildBox(value.isEmpty ? "Tap on a cell to select" : value);
//                   }),
//                 ),
//                 SizedBox(width: screenWidth * 0.02),
//                 Expanded(
//                   child: _buildStakeBox(),
//                 ),
//               ],
//             ),
//
//
//             // Betting Amount Buttons
//             Container(
//               decoration: BoxDecoration(
//                 // color: Color(0xffe4e4e4),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildGradientButton("+100", 100),
//                       _buildGradientButton("+200", 200),
//                       _buildGradientButton("+500", 500),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildGradientButton("+1000", 1000),
//                       _buildGradientButton("+5000", 5000),
//                       _buildGradientButton("+10000", 10000),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.001),
//
//             // Cancel & Place Bet Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       gameController.clearBet();
//                       Get.find<MatchController>().cancelSelection();
//                       bettingController.resetStake();
//                     },
//                     style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xffbb1b1b),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//                     ),
//
//                     child: Text("CANCEL", style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05)),
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.02),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (authController.isLoggedIn.value) {
//                         // Ensure balance is treated as a double
//                         double balance = double.tryParse(userController.userProfile.value?.balance.toString() ?? '0.0') ?? 0.0;
//                         double stakeAmount = double.tryParse(bettingController.stakeAmount.value.toString()) ?? 0.0;
//
//                         if (stakeAmount <= balance) {
//                           _showConfirmationDialog(context);
//                         } else {
//                           Get.snackbar("Insufficient Balance", "You don't have enough balance to place this bet.",
//                               backgroundColor: Colors.red, colorText: Colors.white);
//                         }
//                       } else {
//                         Get.snackbar("Access Denied", "Please log in to continue.",
//                             backgroundColor: Colors.red, colorText: Colors.white);
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xff01a005),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//
//
//                     ),
//                     child: Text("PLACE BET", style: TextStyle(color: Colors.white,fontSize: screenWidth * 0.05)),
//                   ),
//
//                 ),
//               ],
//             ),
//
//             SizedBox(height: screenHeight * 0.002),
//
//             // Confirm Bet with Switch
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //   children: [
//             //     Text(
//             //       "Confirm bet before placing",
//             //       style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.black),
//             //     ),
//             //     Transform.scale(
//             //       scale: 0.8,
//             //       child: Obx(() => Switch(
//             //         value: bettingController.isSwitched.value,
//             //         onChanged: (bool value) {
//             //           bettingController.toggleSwitch();
//             //         },
//             //         activeColor: Colors.white,
//             //         activeTrackColor: Colors.green,
//             //         inactiveThumbColor: Colors.black,
//             //         inactiveTrackColor: Colors.white,
//             //       )),
//             //     ),
//             //   ],
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // void _showConfirmationDialog(BuildContext context) {
//   //   if (bettingController.stakeAmount.value == 0 || gameController.selectedOdds.value!.isEmpty) {
//   //     Get.snackbar("Error", "Please select your amount and rate", backgroundColor: Colors.red, colorText: Colors.white);
//   //     return;
//   //   }
//   //
//   //   Get.defaultDialog(
//   //     title: "Confirm Bet",
//   //     middleText: "Odds: ${gameController.selectedGameType.value}\nAmount: ${bettingController.stakeAmount.value}\nRate: ${gameController.selectedOdds.value}",
//   //     textConfirm: "Yes",
//   //     textCancel: "No",
//   //     confirmTextColor: Colors.white,
//   //     onConfirm: () async {
//   //       try {
//   //         String? phone = await RegistrationController.getPhoneNumber();
//   //         if (phone == null || phone.isEmpty) {
//   //           Get.snackbar("Error", "No saved phone number found.", backgroundColor: Colors.red, colorText: Colors.white);
//   //           return;
//   //         }
//   //
//   //         final user = InsertbetUserModal(
//   //           token: 'BETLAJDNDNDBARKXTER',
//   //           game: gameController.selectedGameType.value.toString() ?? '',
//   //           money: "${bettingController.stakeAmount.value}",
//   //           rate: gameController.selectedOdds.value ?? '',
//   //           type: gameController.selectedLayType.value == "lay" ? "Khai" : "Lagai",
//   //           // type: "Khai",
//   //           phone: phone,bdate: bettingController.selectedDate.value,
//   //         );
//   //         RegistrationController.saveGame(game: gameController.selectedGameType.value.toString());
//   //         controllerss.insertUsercon(user);
//   //
//   //         Get.back(); // Close the dialog
//   //         Get.snackbar("Success", "Bet Placed Successfully!", backgroundColor: Colors.green, colorText: Colors.white);
//   //       } catch (e) {
//   //         Get.snackbar("Error", "Something went wrong!", backgroundColor: Colors.red, colorText: Colors.white);
//   //       }
//   //     },
//   //   );
//   // }
//   void _showConfirmationDialog(BuildContext context) {
//     String competitionName = CompetitionCache().competitionName ?? "No Competition Selected";
//     if (bettingController.stakeAmount.value == 0 || gameController.selectedOdds.value!.isEmpty) {
//       Get.snackbar("Error", "Please select your amount and rate", backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     Get.defaultDialog(
//       title: "CONFIRM BET",
//       titleStyle: TextStyle(color: Colors.blue),
//       middleText:
//       "Odds: ${gameController.selectedGameType.value}\nAmount: ${bettingController.stakeAmount.value}\nRate: ${gameController.selectedOdds.value}",
//       textConfirm: "Yes",
//       textCancel: "No",
//       confirmTextColor: Colors.white,
//       buttonColor: Color(0xff01a005),
//       cancelTextColor: Colors.white,
//       cancel: Container(
//         margin: const EdgeInsets.only(right: 10),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor:  Color(0xffbb1b1b),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//           onPressed: () {
//             Get.back();
//           },
//           child: const Text("No",style: TextStyle(color: Colors.white),),
//         ),
//       ),
//       confirm: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xff01a005),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5),
//           ),
//         ),
//         onPressed: () async {
//           try {
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             await prefs.setString('game2',competitionName );
//             String? phone = await RegistrationController.getPhoneNumber();
//             if (phone == null || phone.isEmpty) {
//               Get.snackbar("Error", "No saved phone number found.", backgroundColor: Colors.red, colorText: Colors.white);
//               return;
//             }
//             bettingController.setCurrentDate();
//             final user = InsertbetUserModal(
//               token: 'BETLAJDNDNDBARKXTER',
//               game: gameController.selectedGameType.value.toString() ?? '',
//               money: "${bettingController.stakeAmount.value}",
//               rate: gameController.selectedOdds.value ?? '',
//               type: gameController.selectedLayType.value == "lay" ? "Khai" : "Lagai",
//               phone: phone, bdate: bettingController.selectedDate.value, game2: competitionName,
//             );
//             RegistrationController.saveGame(game: gameController.selectedGameType.value.toString());
//             controllerss.insertUsercon(user);
//
//             exposureController.updateExposure(
//               token: "BETLAJDNDNDBARKXTER",
//               phone: phone,
//               bal: "${bettingController.stakeAmount.value}",
//               operation: "SUB", // ✅ one of the valid types
//             );
//             Get.back(); // Close the dialog
//             // Get.snackbar("Success", "Bet Placed Successfully!", backgroundColor: Colors.green, colorText: Colors.white);
//           } catch (e) {
//             Get.snackbar("Error", "Something went wrong!", backgroundColor: Colors.red, colorText: Colors.white);
//           }
//
//
//         },
//
//
//
//         child: Text(controllerss.isLoadingss.value ? "Loading..." : "Yes",style: TextStyle(color: Colors.white),),
//       ),
//     );
//   }
//
//   Widget _buildText(String text) {
//     return Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white));
//   }
//
//   Widget _buildBox(String text) {
//     return Container(
//       height: 45,
//
//       decoration: BoxDecoration(
//         color: Colors.white, // Light background
//         borderRadius: BorderRadius.circular(5),
//         border: Border.all(color: Colors.grey.shade400),
//
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 45, // Fixed width
//             decoration: BoxDecoration(
//               color: Colors.blue.shade900, // Dark blue button
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(5),
//                 bottomLeft: Radius.circular(5),
//               ),
//             ),
//             child: IconButton(
//               icon: Icon(Icons.remove, color: Colors.white, size: 18),
//               onPressed: () {
//                 double currentValue = double.tryParse(gameController.selectedOdds.value) ?? 1.0;
//                 if (currentValue > 1.0) {
//                   gameController.selectedOdds.value = (currentValue - 0.1).toStringAsFixed(2);
//                 }
//               },
//             ),
//           ),
//           Expanded(child: Container(color: Colors.white, // Light gray background
//               alignment: Alignment.center,child: Center(child: Text(text, style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))))),
//           Container(
//             width: 40, // Fixed width
//             decoration: BoxDecoration(
//               color: Colors.blue.shade900, // Dark blue button
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(5),
//                 bottomRight: Radius.circular(5),
//               ),
//             ),
//             child: IconButton(
//               icon: Icon(Icons.add, color: Colors.white, size: 18),
//               onPressed: () {
//                 double currentValue = double.tryParse(gameController.selectedOdds.value) ?? 1.0;
//                 gameController.selectedOdds.value = (currentValue + 0.1).toStringAsFixed(2);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStakeBox() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//
//       ),
//       child:  SizedBox(
//         height: 30,
//         child: CustomTextField(
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           controller: bettingController.stakeController, // Used existing controller
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: "Enter Amount",
//             hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
//
//
//           ),
//
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGradientButton(String text, int amount) {
//     return SizedBox(
//       width: 110,
//       child: ElevatedButton(
//         onPressed: () {
//           bettingController.addStake(amount);
//           bettingController.stakeController.text = (int.parse(bettingController.stakeController.text) + amount).toString();
//         },
//         style: ElevatedButton.styleFrom(backgroundColor: AppColors.white, shadowColor: Colors.transparent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),),
//         child: Text(text, style: TextStyle(color: Colors.black)),
//       ),
//     );
//   }
// }
