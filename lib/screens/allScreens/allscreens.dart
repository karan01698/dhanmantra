// // GetX Controller to manage tab state
import 'dart:convert';
import 'dart:ui';

import 'package:sattagames/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../authenticationsScreens/sharecontroller.dart';
import '../../backend/shareapi.dart';
import '../../constants/colors.dart';
import '../../main.dart';
import '../cutomappbar/custom_app_bar.dart';
import '../drawer/rigthdrawer/rightdrawer.dart';
import '../home/home_screen.dart';
import 'package:http/http.dart' as http;
class TabControllerssX extends GetxController {
  RxInt selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}

// class LoginAuthController extends GetxController {
//   var isLoggedIn = false.obs; // Track if user is logged in
//
//   void login() {
//     isLoggedIn.value = true;
//   }
//
//   void logout() {
//     isLoggedIn.value = false;
//   }
// }
class LoginAuthController extends GetxController {
  final ShareControllerapi controller = Get.put(ShareControllerapi());
  var isLoggedIn = false.obs;
  RxString freezeStatus = "Normal!".obs;

  void login() {
    isLoggedIn.value = true;
  }

  void logout() {
    isLoggedIn.value = false;
  }
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchFreezeStatus(); // Call the function here
  // }
  Future<void> fetchFreezeStatus() async {

    String? phone = await RegistrationController.getPhoneNumber();
    if (phone == null || phone.isEmpty) {
      logPrint("No saved phone number found.");
      return;
    }

    final url = Uri.parse(
        'https://dhanmantragame.com/APIs/WebService1.asmx/GetFreeze?token=BETLAJDNDNDBARKXTER&Phone=$phone');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response. body);
        freezeStatus.value = data['message'];
        logPrint("Freeze Status: ${freezeStatus.value}");
        showFreezeDialogIfNeeded();
      } else {
        logPrint('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      logPrint('Error: $e');
    }
  }

  void showFreezeDialogIfNeeded() {
    String phoneNumber = controller.shareList.isNotEmpty && controller.shareList[0].number != null
        ? controller.shareList[0].number
        : '9211283318';
    if (freezeStatus.value != "Normal!") {
      // Get.dialog(
      //   AlertDialog(
      //     title: const Text("Account Frozen"),
      //     content: const Text("Your account is frozen. Please contact support."),
      //   ),
      //   barrierDismissible: true, // Prevent tap-outside to close
      //   useSafeArea: true,
      // );
      // Get.dialog(
      //   WillPopScope(
      //     onWillPop: () async => false, // Prevent back button
      //     child: AlertDialog(
      //       title: const Text("Account Frozen"),
      //       content: const Text("Your account is frozen. Please contact on this number(9637816666)."),
      //     ),
      //   ),
      //   barrierDismissible: false,
      //   useSafeArea: true,
      // );
      Get.dialog(

        WillPopScope(
          onWillPop: () async => false, // Prevent back button
          child: Stack(
            children: [
              // Glass background effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(
                      0.2), // Semi-transparent overlay
                ),
              ),
              Center(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                  ),
                  backgroundColor: Colors.white.withOpacity(0.95),
                  // Slightly transparent background
                  title: const Center(
                    child: Text(
                      "Account Frozen",
                      style: TextStyle(
                        color: Colors.red, // Red color for "Account Frozen"
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  content:  Text(
                    "Your account is frozen.\nPlease contact on this number:\n$phoneNumber ",
                    textAlign: TextAlign.center, // Center the content
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        barrierDismissible: false, // Prevent tap outside to close
        useSafeArea: true,
      );
    }
  }
}
//
// class MainHomeScreen extends StatelessWidget {
//   MainHomeScreen({Key? key}) : super(key: key);
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   final LoginAuthController authController = Get.find<LoginAuthController>();
//   final TabControllerssX tabController = Get.put(TabControllerssX());
//   final ShareController controller = Get.find<ShareController>();
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await authController.fetchFreezeStatus();
//       authController.showFreezeDialogIfNeeded();
//
//     });
//     return Scaffold(
//       key: scaffoldKey,
//       resizeToAvoidBottomInset: false,
//       backgroundColor: AppColors.backgroundColor,
//       appBar: CustomAppBar(scaffoldKey: scaffoldKey),
//       endDrawer: CustomDrawerss(),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Material(
//                 elevation: 5,
//                 shadowColor: Colors.black.withOpacity(0.5),
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   color: AppColors.backgroundColor,
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//                   child: _buildCategories(),
//                 ),
//               ),
//               Expanded(
//                child: HomePage(),
//                 ),
//
//             ],
//           ),
//
//           // Floating Action Button fixed at the middle-right
//           // Positioned(
//           //
//           //   right: 20, // Distance from right
//           //   bottom: MediaQuery
//           //       .of(context)
//           //       .size
//           //       .height * 0.1, // Middle of the screen
//           //   child: FloatingActionButton(
//           //     onPressed: () {
//           //       _openWhatsApp();
//           //     },
//           //     backgroundColor: Colors.green, // WhatsApp theme color
//           //     child: FaIcon(
//           //         FontAwesomeIcons.whatsapp, color: Colors.white, size: 30),
//           //   ),
//           // ),
//           Positioned(
//             right: 20,
//             bottom: MediaQuery.of(context).size.height / 70,
//             child: GestureDetector(
//               onTap: () {
//                 _openWhatsApp();
//               },
//               child: Container(
//                 width: 60, // Adjust image size
//                 height: 50,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(
//                       AppImages.callIcons,
//                     ),
//
//                     fit: BoxFit.cover,
//
//                     // Ensures the image fills the container
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: 20,
//             bottom: MediaQuery.of(context).size.height / 70,
//             child: SizedBox(
//               width: 45,
//               height: 45,
//               child: FloatingActionButton(
//                 onPressed: () {
//                  // Get.to(()=> ShareImageWidget());
//                   // controller.shareReferralCode();
//                   controller.shareImage();
//                 },
//                 backgroundColor: Colors.blue,
//                 child: Icon(Icons.share, color: Colors.white, size: 24),
//                 tooltip: 'Share Referral Code',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCategories() {
//     List<Map<String, dynamic>> categories = [
//       {"name": "Home", "icon": Icons.home},
//       {"name": "Live Casino", "icon": Icons.casino},
//       // {"name": "Cricket", "icon": Icons.sports_cricket},
//       {"name": "E - Games", "icon": Icons.videogame_asset},
//       {"name": "Horse Riding", "icon": Icons.videogame_asset},
//       {"name": "Baccarat", "icon": Icons.videogame_asset},
//       {"name": "Card Games", "icon": Icons.videogame_asset},
//       {"name": "Fishing Game", "icon": Icons.videogame_asset},
//     ];
//
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(categories.length, (index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 2),
//             child: Obx(() {
//               bool isSelected = tabController.selectedIndex.value == index;
//               return SizedBox(
//                 height: 30,
//                 child: OutlinedButton.icon(
//                   onPressed: () {
//                     tabController.changeTab(index);
//                   },
//                   style: OutlinedButton.styleFrom(
//                     backgroundColor:
//                         isSelected ? AppColors.getotp2 : Colors.white,
//                     side: const BorderSide(color: Colors.black),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   icon: Icon(
//                     categories[index]["icon"],
//                     color: isSelected ? Colors.white : Colors.black,
//                   ),
//                   label: Text(
//                     categories[index]["name"],
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black,
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           );
//         }),
//       ),
//     );
//   }
//
//   // Function to open WhatsApp chat
//
//   // void _openWhatsApp() async {
//   //   final ShareControllerapi controller = Get.put(ShareControllerapi());
//   //   // String phoneNumber = "9211283318";
//   //    String phoneNumber = controller.shareList[0].number;
//   //    String messagess = controller.shareList[0].message;
//   //   // Change to your WhatsApp number
//   //   String message = Uri.encodeComponent("Hello, I need some help${messagess}.");
//   //   String url = "https://wa.me/$phoneNumber?text=$message";
//   //
//   //   if (await canLaunchUrl(Uri.parse(url))) {
//   //     await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//   //   } else {
//   //     logPrint("Could not open WhatsApp.");
//   //   }
//   // }
//
  void _openWhatsApp() async {
    final ShareControllerapi controller = Get.put(ShareControllerapi());

    // Ensure +91 is added before the number
    String phoneNumber = controller.shareList[0].number;
    if (!phoneNumber.startsWith('+')) {
      phoneNumber = '+91$phoneNumber'; // Prepend +91 if not already present
    }

    String messagess = controller.shareList[0].message;
    // String message = Uri.encodeComponent("Hello, I need some help $messagess.");
    String message = Uri.encodeComponent("Hello, I need some help");
    String url = "https://wa.me/${phoneNumber.replaceAll('+', '')}?text=$message";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      logPrint("Could not open WhatsApp.");
    }
  }

// }
