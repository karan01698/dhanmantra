// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../../constants/colors.dart';
// //
// // // Import your screens here
// // import '../home/home_screen.dart';
// // import '../profile/profilescreen.dart';
// //
// //
// // class CustomDrawer extends StatelessWidget {
// //   const CustomDrawer({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Drawer(
// //       backgroundColor: Colors.black,
// //       child: ListView(
// //         padding: EdgeInsets.zero,
// //         children: [
// //           SizedBox(height: 50),
// //           _buildDrawerItem(Icons.person, "Profile", () => Get.to(EditProfilePage())),
// //           _buildDrawerItem(Icons.home, "Home", () => Get.back()),
// //           _buildDrawerItem(Icons.sports, "Cricket", () => Get.back()),
// //           _buildDrawerItem(Icons.videogame_asset, "E-Games", () => Get.back()),
// //           _buildDrawerItem(Icons.casino, "Live Casino", () => Get.back() ),
// //           _buildDrawerItem(Icons.money, "Transaction", () => Get.to(LiveCasinoPage())),
// //           _buildDrawerItem(Icons.account_balance_wallet, "Wallet", () => Get.to(LiveCasinoPage())),
// //           _buildDrawerItem(Icons.history, "Wallet History", () => Get.to(LiveCasinoPage())),
// //           _buildDrawerItem(Icons.exit_to_app, "Logout", () {
// //             // Handle logout logic here
// //           }),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
// //     return ListTile(
// //       leading: Icon(icon, color: AppColors.cardColor),
// //       title: Text(title, style: TextStyle(color: AppColors.cardColor)),
// //       onTap: onTap,
// //     );
// //   }
// // }
// //
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../constants/colors.dart';
// import '../allScreens/allscreens.dart';
// import '../home/home_screen.dart';
// import '../profile/profilescreen.dart';
// import 'logout.dart';
//  // Ensure you import your main home screen
//  // Import the GetX controller
//
// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final TabControllerssX tabController = Get.find<TabControllerssX>(); // Get controller
//
//     return Drawer(
//       backgroundColor: Colors.white,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           SizedBox(height: 50),
//           _buildDrawerItem(Icons.person, "Profile", () => Get.to(EditProfilePage())),
//           _buildDrawerItem(Icons.home, "Home", () {
//             tabController.changeTab(0);
//             Navigator.pop(context); // Close the drawer
//           }),
//           _buildDrawerItem(Icons.casino, "Live Casino", () {
//             tabController.changeTab(1);
//             Navigator.pop(context);
//           }),
//           _buildDrawerItem(Icons.sports_cricket, "Cricket", () {
//             tabController.changeTab(2);
//             Navigator.pop(context);
//           }),
//           _buildDrawerItem(Icons.videogame_asset, "E-Games", () {
//             tabController.changeTab(3);
//             Navigator.pop(context);
//           }),
//           _buildDrawerItem(Icons.money, "Transaction", () => Get.to(LiveCasinoPage())),
//           _buildDrawerItem(Icons.exit_to_app, "Logout", () async {
//             await LogAuthService.logout();
//             // Handle logout logic
//           }),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon, color: AppColors.cardColor),
//       title: Text(title, style: TextStyle(color: Colors.black)),
//       onTap: onTap,
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import '../allScreens/allscreens.dart';
import '../cutomappbar/custom_app_bar.dart';

class AuthControllersss extends GetxController {
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLoginState(); // ✅ Load state at startup
  }

  Future<void> _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
    isLoggedIn.value = value;
  }

  Future<void> logout() async {
    // await FirebaseAuth.instance.signOut();
    // await GoogleSignIn().signOut();
    // await GoogleSignIn().disconnect();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // ✅ Save logout state
    await prefs.clear();

    // await prefs.remove('isLoggedIn');
    isLoggedIn.value = false; // ✅ Update state
    Get.find<AppBarController>().isLoggedIn.value =
        false; // ✅ Sync AppBar state
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final TabControllerssX tabController = Get.find<TabControllerssX>();
    final AuthControllersss authController = Get.find<AuthControllersss>();

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 50),
          // _buildDrawerItem(Icons.person, "Profile", () => showUpdateDialog()),
          _buildDrawerItem(Icons.home, "Home", () {
            Navigator.pop(context);
          }),
          _buildDrawerItem(Icons.casino, "Live Casino", () {
            Navigator.pop(context);
          }),
          _buildDrawerItem(Icons.sports_cricket, "Cricket", () {
            Navigator.pop(context);
          }),
          _buildDrawerItem(Icons.videogame_asset, "E-Games", () {
            Navigator.pop(context);
          }),
          // _buildDrawerItem(Icons.money, "Addbet", () => Get.to(DepositAddMoneyScreen())),
          // _buildDrawerItem(Icons.money, "AddBalance", () => Get.to(AddBalanceScreen())),
          // _buildDrawerItem(Icons.money, "Update Balance", () => Get.to(UpdatebalanceScreens())),
          // _buildDrawerItem(Icons.money, "Transactions", () => Get.to(Transcationsscreenss())),

          // Logout button should appear only when the user is logged in
          Obx(() {
            return authController.isLoggedIn.value
                ? _buildDrawerItem(Icons.exit_to_app, "Logout", () async {
                    _showLogoutDialog(context, authController);
                  })
                : SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.cardColor),
      title: Text(title, style: TextStyle(color: Colors.black)),
      onTap: onTap,
    );
  }
}

void _showLogoutDialog(BuildContext context, AuthControllersss authController) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirm Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: Text("No"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              Get.back(); // Close drawer
              authController.logout(); // Logout user
            },
            child: Text("Yes"),
          ),
        ],
      );
    },
  );

}
