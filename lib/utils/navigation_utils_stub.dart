
import 'dart:html' as html;

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sattagames/screens/home/home_screen.dart';

// class NavigationUtils {
//   static void goToHome() {
//     if (kIsWeb) {
//       // ✅ Web par redirect kar do
//       html.window.location.href =
//       "https://satt.anklegaming.live/mainapp/index.html";
//     } else {
//       // ✅ Mobile / Desktop par sirf GetX se navigate kara do
//       Get.offAll(() => MainHomeScreen()); // apne route ka naam lagao
//     }
//   }
// }

// ignore: avoid_web_libraries_in_flutter


class NavigationUtils {
  static void closeCurrentTab() {
    html.window.close();
  }
  static void goToHome() {
    Get.back();
  }
}