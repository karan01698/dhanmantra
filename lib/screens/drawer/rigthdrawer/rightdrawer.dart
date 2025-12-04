// import 'package:sattagames/screens/drawer/addmoney/widthdraw.dart';
// import 'package:sattagames/screens/drawer/rigthdrawer/profitandloss.dart';
// import 'package:sattagames/screens/drawer/transactionscreen/transcationsscreen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// // Import all screens
// import '../../../backend/authenticanapi/bethistoryapi/bethistorymodal.dart';
// import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
// import '../../../constants/colors.dart';
// import '../../allScreens/allscreens.dart';
// import '../../profile/profilescreen.dart';
// import '../addmoney/addbalance.dart';
// import '../addmoney/updatebalance.dart';
// import '../custom_drawer.dart';
// // import 'dart:html' as html;
//
//
// class CustomDrawerss extends StatelessWidget {
//   // final TabControllerssX tabController = Get.find<TabControllerssX>();
//   final RegisterController userController = Get.put(RegisterController());
//   final AuthControllersss authController = Get.find<AuthControllersss>();
//
//
//   final Uri _downloadUrl = Uri.parse('https://dhanmantragame.com/Download');
//
//   // Future<void> _downloadAPK() async {
//   //   if (kIsWeb) {
//   //     // For Flutter Web: open in a new browser tab
//   //     html.window.open(_downloadUrl.toString(), '_blank');
//   //   } else {
//   //     // For mobile/desktop platforms
//   //     if (!await launchUrl(_downloadUrl, mode: LaunchMode.externalApplication)) {
//   //       throw 'Could not launch $_downloadUrl';
//   //     }
//   //   }
//   // }
//   //
//   Future<void> _downloadAPK() async {
//     if (!await launchUrl(_downloadUrl, mode: LaunchMode.externalApplication)) {
//       throw 'Could not launch $_downloadUrl';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: AppColors.backgroundColor,
//
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           _buildUserHeader(),
//           _buildBalanceInfo(),
//           // Updated to show user balance dynamically
//
//           _buildDrawerItem(Icons.home_filled, "Home", onTap: () {
//             // tabController.changeTab(0);
//             Navigator.pop(context);
//           }),
//           _buildDrawerItem(Icons.person, "Profile",
//               onTap: () => showUpdateDialog()),
//           // _buildSectionHeader("Download"),
//           // _buildDrawerItem(
//           //     Icons.download,
//           //     "Download APK",
//           //     onTap: _downloadAPK
//           // ),
//           // _buildSectionHeader("Statements"),
//           // _buildDrawerItem(Icons.swap_horiz, "Add Balance",
//           //     onTap: () => Get.to(UpdatebalanceScreens())),
//
//           // _buildDrawerItem(Icons.swap_horiz, "Account Statement",
//           //
//           //     onTap: () => Get.to(newUpdatebalanceScreens())),
//           // _buildDrawerItem(Icons.swap_horiz, "Profit and Loss",
//           //
//           //     onTap: () => Get.to(ProfitLossScreen())),
//           // _buildDrawerItem(Icons.swap_horiz, "Bet History",
//           //     onTap: () => Get.to(Transcationsscreenss())),
//           _buildDrawerItem(Icons.swap_horiz, "Bet History",
//               onTap: () => Get.to( BettHistoryScreen())),
//           //
//           _buildDrawerItem(Icons.swap_horiz, "Transactions",
//               onTap: () => Get.to(ALLTransactionScreen())),
//           _buildDrawerItem(Icons.swap_horiz, "Terms & Conditions",
//               onTap: () => Get.to(ALLTransactionScreen())),
//           _buildDrawerItem(Icons.swap_horiz, "Privacy Policy",
//               onTap: () => Get.to(ALLTransactionScreen())),
//
//           _buildDrawerItem(Icons.swap_horiz, "About Us",
//               onTap: () => Get.to(ALLTransactionScreen())),
//           //     onTap: () => Get.to(ALLTransactionScreen())),
//           // _buildDrawerItem(Icons.swap_horiz, "Withdraw",
//           //     onTap: () => showWithdrawDialog()),
//           _buildDrawerItem(
//             Icons.person,
//             "Log Out",
//             onTap: () {
//               // tabController.changeTab(0);
//               _showLogoutDialog(context, authController);
//             },
//           ),
//
//           SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// User Header with Dynamic Name & Email
//   Widget _buildUserHeader() {
//     return StreamBuilder(
//       stream: Stream.periodic(Duration(seconds: 1)).asyncMap((_) async {
//         await userController.loadUserProfile();
//         return userController.userProfile.value;
//       }).distinct(),
//       builder: (context, snapshot) {
//         final user = userController.userProfile.value;
//         if (user != null && user.RDate != null) {
//           // Store dealer in SharedPreferences
//           SharedPreferences.getInstance().then((prefs) {
//             prefs.setString('dealer', user.RDate!);
//             logPrint("dkdkdkdk ${user.RDate}");
//           });
//         }
//
//         if (user == null) {
//           return UserAccountsDrawerHeader(
//             decoration: BoxDecoration(color: Colors.black),
//             accountEmail: Text(
//               "Welcome User",
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//             accountName: Text(
//               "Welcome User",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold),
//             ),
//             // currentAccountPicture: Center(
//             //   child: CircleAvatar(
//             //     backgroundColor: Colors.red.shade900,
//             //     child: Icon(Icons.person, color: Colors.white, size: 40),
//             //   ),
//             // ),
//           );
//         }
// SizedBox (height: 80);
//         return SizedBox(
//           height: 112,
//           child: UserAccountsDrawerHeader(
//
//             decoration: BoxDecoration(color: Colors.black),
//             accountEmail: Align(
//               alignment: Alignment.topLeft,
//               child: Text(
//
//                 user.email ?? "No Email",
//                 style: TextStyle(
//                     color: AppColors.getotp,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//
//                     decorationColor: Colors.black,
//                     decorationThickness: 2.5
//                   // Adds underline
//                 ),
//               ),
//
//             ),
//
//
//             accountName: Text(
//               user.name ?? "No Name",
//               style: TextStyle(
//                   color: AppColors.getotp,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold),
//             ),
//             // currentAccountPicture: Center(
//             //   child: CircleAvatar(
//             //     backgroundColor: Colors.red.shade900,
//             //     child: Icon(Icons.person, color: Colors.white, size: 40),
//             //   ),
//             // ),
//           ),
//         );
//       },
//     );
//   }
//
//   /// Drawer Item Widget
//   Widget _buildDrawerItem(IconData icon, String title, {VoidCallback? onTap}) {
//     return ListTile(
//       leading: Icon(icon, color: AppColors.getotp),
//       title: Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
//       onTap: onTap,
//     );
//   }
//
//   /// Section Header Widget
//   Widget _buildSectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: Text(title,
//           style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.white)),
//     );
//   }
//
//   /// **Balance Info Section (Dynamic)**
//   Widget _buildBalanceInfo() {
//     return StreamBuilder(
//       stream: Stream.periodic(Duration(seconds: 1)).asyncMap((_) async {
//         await userController.loadUserProfile();
//         return userController.userProfile.value;
//       }).distinct(),
//       builder: (context, snapshot) {
//         final user = userController.userProfile.value;
//
//         if (user == null) {
//           return _buildCard(
//             title: "Balance Information",
//             items: [
//               _buildInfoTile("Balance", "Loading..", Colors.black),
//               _buildInfoTile("Bonus", "Loading..", Colors.red),
//
//
//             ],
//           );
//         }
//         logPrint("Unserbonus ${user.bonus}");
//         return _buildCard(
//           title: "Balance Information",
//           items: [
//             _buildInfoTile(
//                 "Balance", "₹ ${user.balance ?? 0.00}", Colors.black),
//             _buildInfoTile("Bonus", "₹ ${user.bonus ?? 0.00}", Colors.white),
//
//
//             // _buildInfoTile("Free Cash", "₹ 0.00", Colors.grey.shade600),
//             // _buildInfoTile("Net Exposure", "₹ 0.00", Colors.red),
//           ],
//         );
//       },
//     );
//   }
//
//
//   /// **Reusable Card Widget**
//   Widget _buildCard({required String title, required List<Widget> items}) {
//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.all(10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       // Ensure rounded corners
//       child: Ink(
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(10), // Apply same border radius
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               SizedBox(height: 10),
//               ...items,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// **Reusable Info Tile Widget**
//   Widget _buildInfoTile(String label, String value, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white)),
//           Text(value,
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white)),
//         ],
//       ),
//     );
//   }
// }
//
// void _showLogoutDialog(BuildContext context, AuthControllersss authController) {
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

import 'package:sattagames/screens/drawer/addmoney/widthdraw.dart';
import 'package:sattagames/screens/drawer/rigthdrawer/policy_pages.dart';
import 'package:sattagames/screens/drawer/rigthdrawer/profitandloss.dart';
import 'package:sattagames/screens/drawer/transactionscreen/transcationsscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../backend/authenticanapi/bethistoryapi/bethistorymodal.dart';
import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../../constants/colors.dart';
import '../../allScreens/allscreens.dart';
import '../../profile/profilescreen.dart';
import '../addmoney/addbalance.dart';
import '../addmoney/updatebalance.dart';
import '../custom_drawer.dart';
import 'haruft_bet.dart';

class CustomDrawerss extends StatelessWidget {
  final RegisterController userController = Get.put(RegisterController());
  final AuthControllersss authController = Get.find<AuthControllersss>();

  final Uri _downloadUrl = Uri.parse('https://dhanmantragame.com/Download');

  Future<void> _downloadAPK() async {
    if (!await launchUrl(_downloadUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_downloadUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildUserHeader(),
          _buildBalanceInfo(),
          _buildDrawerItem(Icons.home_filled, "Home", onTap: () {
            Navigator.pop(context);
          }),
          _buildDrawerItem(Icons.person, "Profile", onTap: () => showUpdateDialog()),

          _buildDrawerItem(Icons.swap_horiz, "Bet History",
              onTap: () => Get.to(BettHistoryScreen())),
          _buildDrawerItem(Icons.money_outlined, "Transactions",
              onTap: () => Get.to(ALLTransactionScreen())),
          _buildDrawerItem(Icons.restore_page_outlined, "Terms & Conditions",
              onTap: () => Get.to(() => CmsPageScreen(
                pageName: 'Term  Conditions',
                title: 'Terms & Conditions',
              ))),
          _buildDrawerItem(Icons.privacy_tip_outlined, "Privacy Policy",
              onTap: () => Get.to(() => CmsPageScreen(
                pageName: 'Privacy Policy',
                title: 'Privacy Policy',
              ))),
          _buildDrawerItem(Icons.info_outline, "About Us",
              onTap: () => Get.to(() => CmsPageScreen(
                pageName: 'AboutUs',
                title: 'About Us',
              ))),
          // _buildDrawerItem(Icons.swap_horiz, "Hauraf",
          //     onTap: () =>Get.to( HaurfShowBetHistoryScreen())),
          _buildDrawerItem(
            Icons.logout,
            "Log Out",
            onTap: () {
              _showLogoutDialog(context, authController);
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  /// User Header with Dynamic Name & Email
  Widget _buildUserHeader() {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)).asyncMap((_) async {
        await userController.loadUserProfile();
        return userController.userProfile.value;
      }).distinct(),
      builder: (context, snapshot) {
        final user = userController.userProfile.value;
        if (user != null && user.RDate != null) {
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString('dealer', user.RDate!);
          });
        }

        if (user == null) {
          return UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            accountEmail: Text(
              "Welcome User",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            accountName: Text(
              "Welcome User",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          );
        }

        return SizedBox(
height: 130,
          child: UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black),

            accountEmail: Text(
              user.email ?? "No Email",
              style: TextStyle(
                color: AppColors.getotp,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountName: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                user.name ?? "No Name",
                style: TextStyle(
                  color: AppColors.getotp,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Drawer Item Widget
  Widget _buildDrawerItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.getotp),
      title: Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
      onTap: onTap,
    );
  }

  /// Section Header Widget
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  /// Balance Info Section
  Widget _buildBalanceInfo() {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)).asyncMap((_) async {
        await userController.loadUserProfile();
        return userController.userProfile.value;
      }).distinct(),
      builder: (context, snapshot) {
        final user = userController.userProfile.value;

        if (user == null) {
          return _buildCard(
            title: "Balance Information",
            items: [
              _buildInfoTile("Balance", "Loading..", Colors.black),
              _buildInfoTile("Bonus", "Loading..", Colors.red),
            ],
          );
        }

        return _buildCard(
          title: "Balance Information",
          items: [
            _buildInfoTile("Balance", "₹ ${user.balance ?? 0.00}", Colors.black),
            _buildInfoTile("Bonus", "₹ ${user.bonus ?? 0.00}", Colors.white),
          ],
        );
      },
    );
  }

  /// Card UI Wrapper
  Widget _buildCard({required String title, required List<Widget> items}) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              ...items,
            ],
          ),
        ),
      ),
    );
  }

  /// Info Tile for Balance
  Widget _buildInfoTile(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
          Text(value,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
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
              Navigator.pop(context);
            },
            child: Text("No"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              Get.back();
              authController.logout();
            },
            child: Text("Yes"),
          ),
        ],
      );
    },
  );
}
