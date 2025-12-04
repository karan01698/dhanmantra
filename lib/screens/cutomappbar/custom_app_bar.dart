//
import 'package:sattagames/backend/authenticanapi/controllerapi/registerapicontroller.dart';
import 'package:sattagames/screens/drawer/addmoney/updatebalance.dart';
import 'package:sattagames/screens/home/all_games_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../authenticationsScreens/Registrationscreen.dart';
import '../../authenticationsScreens/login.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../main.dart';
import '../../widgets/reusable_button.dart';
import '../allScreens/allscreens.dart';
import '../drawer/addmoney/widthdraw.dart';
import '../drawer/custom_drawer.dart';

// class AppBarController extends GetxController {
//   var isLoggedIn = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//
//
//     try {
//       isLoggedIn.value = Get.find<AuthControllersss>().isLoggedIn.value;
//     } catch (e) {
//       logPrint("Error finding AuthControllersss: $e");
//     }
//   }
//
//   void login() {
//     isLoggedIn.value = true;
//     Get.find<AuthControllersss>().setLoggedIn(true);
//   }
//
//   void logout() {
//     isLoggedIn.value = false;
//     Get.find<AuthControllersss>().setLoggedIn(false);
//   }
// }
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final RegisterController userController = Get.put(RegisterController());
//
//   final GlobalKey<ScaffoldState> scaffoldKey;
//
//   CustomAppBar({Key? key, required this.scaffoldKey}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final AppBarController appBarController = Get.put(AppBarController());
//
//     // Set System UI Style
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: AppColors.getotp, // Status bar color
//       statusBarIconBrightness: Brightness.light, // White icons
//       systemNavigationBarColor: Colors.black, // Navbar color
//       systemNavigationBarIconBrightness: Brightness.light, // White navbar icons
//     ));
//
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       flexibleSpace: Container(
//         decoration: const BoxDecoration(
//           color: Colors.black, // ✅ Ensures AppBar stays black
//         ),
//       ),
//       elevation: 8,
//       shadowColor: Colors.black54,
//       title: Column(
//         children: [
//           Obx(() {
//             return appBarController.isLoggedIn.value
//                 ? Padding(
//                     padding: const EdgeInsets.only(top: 15.0),
//                     child: ReusableButton(
//                       onPressed: () async {},
//                       isShimmer: true,
//
//                       shimmerDuration: const Duration(seconds: 3),
//                       // text:
//                           // "र${userController.userProfile.value?.balance ?? 0.0}",
//                       text: "र${(double.tryParse(userController.userProfile.value?.balance.toString() ?? '0.0') ?? 0.0) + (double.tryParse(userController.userProfile.value?.bonus.toString() ?? '0.0') ?? 0.0)}",
//
//                       textColor: Colors.white,
//                       fontSize: 14,
//                       backgroundColor: Color(0xff07820d),
//                       borderColor: Colors.black,
//                       borderWidth: 1,
//                       borderRadius: 12,
//                       width: 1300,
//                       // ✅ Adjusted width
//                       height: 20,
//                       // ✅ Adjusted height
//                       alignment: Alignment.centerLeft,
//                     ),
//                   )
//                 : const SizedBox(height: 0,); // Hide if not logged in
//           }),
//           SizedBox(height: 3,),
//           Obx(() {
//             final isLoggedIn = Get.find<AppBarController>().isLoggedIn.value;
//
//             return Shimmer(
//               direction: ShimmerDirection.ltr,
//               period: Duration(seconds: 5), // Slow speed
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xffeccc55), // base
//                   Colors.white,       // narrow highlight
//                   Color(0xffeccc55), // base
//                 ],
//                 stops: [
//                   0.48, 0.5, 0.52, // Very narrow pink shimmer band
//                 ],
//               ),
//
//               child: Container(
//
//                 child: Image.asset(
//                   AppImages.aapsplashLogo,
//                   height: isLoggedIn ? 20 : 32,
//                   width: 130,
//                 ),
//               ),
//             );
//
//
//           })
//         ],
//       ),
//       // actions: [
//       //   Obx(() {
//       //     return appBarController.isLoggedIn.value
//       //         ? Row(
//       //             children: [
//       //               _buildActionButton(
//       //                   text: "WITHDRAW",
//       //                   onPressed: showWithdrawDialog,
//       //                   backgroundColor: Color(0xff970001),
//       //                   textColor: Colors.white,
//       //                   borderColor: Color(0xffc6dbc6)),
//       //               _buildActionButton(
//       //                 text: "DEPOSIT",
//       //                 onPressed: () {
//       //                   Get.to(() => UpdatebalanceScreens());
//       //                 },
//       //                 backgroundColor: Color(0xff07820d),
//       //                 textColor: Colors.white,
//       //                 borderColor: Colors.white,
//       //               ),
//       //
//       //             ],
//       //           )
//       //         : Row(
//       //             children: [
//       //               _buildActionButton(
//       //                 text: "Log In",
//       //                 onPressed: showLoginDialog,
//       //                 backgroundColor: AppColors.getotp,
//       //                 textColor: Colors.black,
//       //                 borderColor: Colors.white,
//       //               ),
//       //               _buildActionButton(
//       //                 text: "Sign Up",
//       //                 onPressed: () {
//       //                   showRegistrationDialog();
//       //                   // tabController.changeTab(0);
//       //                 },
//       //                 backgroundColor: Colors.white,
//       //                 textColor: Colors.black,
//       //               ),
//       //             ],
//       //           );
//       //   }),
//       // ],
//
//       actions: [
//         Obx(() {
//           return appBarController.isLoggedIn.value
//               ? Row(
//             children: [
//               _buildActionButton(
//                 text: "WITHDRAW",
//                 onPressed: showWithdrawDialog,
//                 backgroundColor: const Color(0xff970001),
//                 textColor: Colors.white,
//                 borderColor: const Color(0xffc6dbc6),
//               ),
//               _buildActionButton(
//                 text: "DEPOSIT",
//                 onPressed: () {
//                   Get.to(() => UpdatebalanceScreens());
//                 },
//                 backgroundColor: const Color(0xff07820d),
//                 textColor: Colors.white,
//                 borderColor: Colors.white,
//               ),
//               _buildActionButton(
//                 text: "LOGOUT",
//                 onPressed: () {
//                   _showLogoutDialogs(Get.context!, Get.find<AuthControllersss>());
//                   appBarController.logout(); // Also update AppBar state
//                 },
//                 backgroundColor: Colors.black,
//                 textColor: Colors.white,
//                 borderColor: Colors.red,
//               ),
//             ],
//           )
//               : Row(
//             children: [
//               _buildActionButton(
//                 text: "Log In",
//                 onPressed: showLoginDialog,
//                 backgroundColor: AppColors.getotp,
//                 textColor: Colors.black,
//                 borderColor: Colors.white,
//               ),
//               _buildActionButton(
//                 text: "Sign Up",
//                 onPressed: showRegistrationDialog,
//                 backgroundColor: Colors.white,
//                 textColor: Colors.black,
//               ),
//             ],
//           );
//         }),
//       ],
//
//     );
//   }
//
//   /// ✅ Creates Action Buttons for the AppBar
//   Widget _buildActionButton({
//     required String text,
//     required VoidCallback onPressed,
//     required Color backgroundColor,
//     required Color textColor,
//     IconData? icon, // Optional icon
//     Color? borderColor,
//     double? width,
//     double? height,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6),
//       child: ReusableButton(
//         text: text,
//         isShimmer: true,
//         shimmerDuration: const Duration(seconds: 3),
//         onPressed: onPressed,
//         width: width ?? 100,
//         height: height ?? 30,
//         borderRadius: 5,
//         fontSize: 15,
//         backgroundColor: backgroundColor,
//         textColor: textColor,
//         borderColor: borderColor ?? Colors.transparent,
//         borderWidth: borderColor != null ? 1 : 0,
//         icon: icon,
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
//
// void _showLogoutDialogs(BuildContext context, AuthControllersss authController) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Confirm Logout"),
//         content: Text("Are you sure you want to logout?"),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context); // Close dialog
//             },
//             child: Text("No"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               Navigator.pop(context);
//
//               Get.back(); // Close drawer
//               authController.logout(); // Logout user
//             },
//             child: Text("Yes"),
//           ),
//         ],
//       );
//     },
//   );
// }
//
//
// // IconButton(
// // icon: const Icon(Icons.menu, color: Colors.white),
// // onPressed: () {
// // scaffoldKey.currentState!.openEndDrawer();
// // },
// // ),

class AppBarController extends GetxController {
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      isLoggedIn.value = Get
          .find<AuthControllersss>()
          .isLoggedIn
          .value;
    } catch (e) {
      logPrint("Error finding AuthControllersss: $e");
    }
  }

  void login() {
    isLoggedIn.value = true;
    Get.find<AuthControllersss>().setLoggedIn(true);
  }

  void logout() {
    isLoggedIn.value = false;
    Get.find<AuthControllersss>().setLoggedIn(false);
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final RegisterController userController = Get.put(RegisterController());
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomAppBar({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppBarController appBarController = Get.put(AppBarController());

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.getotp,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
      ),
      elevation: 8,
      shadowColor: Colors.black54,
      title: Column(
        children: [
          Obx(() {
            return appBarController.isLoggedIn.value
                ? Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ReusableButton(
                onPressed: () async {},
                isShimmer: true,
                shimmerDuration: const Duration(seconds: 3),
                text:
                "र${(double.tryParse(
                    userController.userProfile.value?.balance.toString() ??
                        '0.0') ?? 0.0) + (double.tryParse(
                    userController.userProfile.value?.bonus.toString() ??
                        '0.0') ?? 0.0)}",
                textColor: Colors.white,
                fontSize: 14,
                backgroundColor: Color(0xff07820d),
                borderColor: Colors.black,
                borderWidth: 1,
                borderRadius: 12,
                width: 1300,
                height: 20,
                alignment: Alignment.centerLeft,
              ),
            )
                : const SizedBox(height: 0);
          }),
          const SizedBox(height: 3),
          Obx(() {
            final isLoggedIn = appBarController.isLoggedIn.value;
            return Image.asset(
              AppImages.aapsplashLogo,
              height: isLoggedIn ? 0 : 65,
              width: 100,
            );
          }),

        ],
      ),
      actions: [
        Obx(() {
          return appBarController.isLoggedIn.value
              ? Row(
            children: [
              _buildActionButton(
                text: "WITHDRAW",
                onPressed: showWithdrawDialog,
                backgroundColor: const Color(0xff970001),
                textColor: Colors.white,
                borderColor: const Color(0xffc6dbc6),
              ),
              _buildActionButton(
                text: "DEPOSIT",
                onPressed: () {
                  Get.to(() => UpdatebalanceScreens());
                },
                backgroundColor: const Color(0xff07820d),
                textColor: Colors.white,
                borderColor: Colors.white,
              ),
              // ✅ Logout Icon only (no text)
              // IconButton(
              //   icon: const Icon(Icons.power_settings_new, color: Colors.white),
              //   tooltip: "Logout",
              //   onPressed: () {
              //     _showLogoutDialogs(context);
              //   },
              // ),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  scaffoldKey.currentState!.openEndDrawer();
                },
              ),

            ],
          )
              : Row(
            children: [
              _buildActionButton(
                text: "Log In",
                onPressed: showLoginDialog,
                backgroundColor: AppColors.getotp,
                textColor: Colors.black,
                borderColor: Colors.white,
              ),
              _buildActionButton(
                text: "Sign Up",
                onPressed: showRegistrationDialog,
                backgroundColor: Colors.white,
                textColor: Colors.black,
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    IconData? icon,
    Color? borderColor,
    double? width,
    double? height,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ReusableButton(
        text: text,
        isShimmer: true,
        shimmerDuration: const Duration(seconds: 3),
        onPressed: onPressed,
        width: width ?? 100,
        height: height ?? 30,
        borderRadius: 5,
        fontSize: 15,
        backgroundColor: backgroundColor,
        textColor: textColor,
        borderColor: borderColor ?? Colors.transparent,
        borderWidth: borderColor != null ? 1 : 0,
        icon: icon,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

void _showLogoutDialogs(BuildContext context) {
  final authController = Get.find<AuthControllersss>();
  final appBarController = Get.find<AppBarController>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              Get.back(); // Close drawer if open
              authController.logout(); // Your actual logout logic
              appBarController.logout(); // Update UI state
            },
            child: const Text("Yes"),
          ),
        ],
      );
    },
  );
}
