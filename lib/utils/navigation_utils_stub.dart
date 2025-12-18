//
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

// lib/utils/navigation_utils.dart
//
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:sattagames/screens/home/home_screen.dart';
//
// // Conditional import — sirf Web pe dart:html load hoga
// import 'navigation_utils_stub.dart' if (dart.library.html) 'navigation_utils_web.dart';
//
// class NavigationUtils {
//   /// Web pe tab close karega, Mobile pe kuch nahi karega (safe hai)
//   static void closeCurrentTab() {
//     closeTabImpl(); // implementation alag file mein hai
//   }
//
//   /// Home pe le jayega sab platform pe
//   static void goToHome() {
//     if (kIsWeb) {
//       // Web pe external site pe bhej do
//       redirectToWebHome();
//     } else {
//       // Mobile/Desktop pe normal navigation
//       Get.offAll(() =>  MainHomeScreen());
//     }
//   }
//
//   // Ye methods alag file se aayenge (niche diya hai)
//   static void closeTabImpl() => throw UnimplementedError();
//   static void redirectToWebHome() => throw UnimplementedError();
