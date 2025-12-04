// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../allScreens/allscreens.dart';
//
// import '../cutomappbar/custom_app_bar.dart';
//
// class LogAuthService extends GetxService {
//   var isLoggedIn = false.obs; // ✅ Define observable variable
//
//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false); // ✅ Save logout state
//
//     isLoggedIn.value = false; // ✅ Update state
//     Get.find<AppBarController>().isLoggedIn.value = false; // ✅ Sync AppBar state
//
//     Get.offAll(() => MainHomeScreen()); // ✅ Navigate to home screen after logout
//   }
// }
//
// // ✅ Register LogAuthService in `main.dart` or wherever needed
//
