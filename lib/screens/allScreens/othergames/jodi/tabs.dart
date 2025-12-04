// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sattagames/screens/allScreens/hrefgames/crossing_combine.dart';
// import 'package:sattagames/screens/allScreens/hrefgames/haruf_combine.dart';
// import 'package:sattagames/widgets/reusable_button.dart';
// import '../../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
// import 'jodi_combine.dart';
//
// // Controller to manage tab state
// class TabControllerX extends GetxController {
//   var selectedIndex = 0.obs;
//   void setIndex(int index) {
//     selectedIndex.value = index;
//   }
// }
//
// // Main Screen with Shimmer Buttons as Tabs
// class CustomTabScreen extends StatelessWidget {
//   final String gameTitle;
//   final String closeTime;
//
//
//
//   CustomTabScreen({super.key, required this.gameTitle, required this.closeTime});
//   final List<String> tabNames = const ['Jodi', 'Crossing', 'Haruf'];
//
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> tabScreens =  [
//       JodiFullPage(gameName: gameTitle),
//       CrossingFullPage(gameName: gameTitle),
//       HarufCombinePage(gameName: gameTitle),
//
//       // CrossingFullPage(gameName: gameTitle, closeTime: closeTime),
//       // HarufCombinePage(gameName: gameTitle, closeTime: closeTime),
//     ];
//     final RegisterController userController = Get.put(RegisterController());
//     final TabControllerX controller = Get.put(TabControllerX());
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 15),
//
//            Align(
//              alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: GestureDetector(
//                   onTap: () => Get.back(),
//                   child: const Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                     size: 18,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Obx(() => Wrap(
//               alignment: WrapAlignment.center,
//               spacing: 3,
//               runSpacing: 6,
//               children: List.generate(tabNames.length, (index) {
//                 bool isSelected = controller.selectedIndex.value == index;
//                 return _buildActionButton(
//                   text: tabNames[index],
//                   onPressed: () => controller.setIndex(index),
//                   backgroundColor:
//                   isSelected ? Colors.yellow : Colors.transparent,
//                   textColor: isSelected ? Colors.black : Colors.white,
//                   borderColor:
//                   isSelected ? Colors.white : Colors.transparent,
//                   width: 100,
//                   height: 35,
//                 );
//               }),
//             ),
//             ),
//             const SizedBox(height: 10),
//             Obx(() {
//               double balance = (double.tryParse(
//                   userController.userProfile.value?.balance.toString() ?? '0.0') ??
//                   0.0) +
//                   (double.tryParse(
//                       userController.userProfile.value?.bonus.toString() ?? '0.0') ??
//                       0.0);
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       gameTitle,
//                       style: GoogleFonts.baloo2(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Container(
//                       width: 100,
//                       height: 35,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.yellow.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: Colors.amber, width: 1.5),
//                       ),
//                       child: Text(
//                         "₹${balance.toStringAsFixed(2)}",
//                         style: GoogleFonts.baloo2(
//                           color: Colors.white,
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//
//             }),
//
//             Expanded(
//               child: Obx(() => tabScreens[controller.selectedIndex.value]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Reusable shimmer button
// Widget _buildActionButton({
//   required String text,
//   required VoidCallback onPressed,
//   required Color backgroundColor,
//   required Color textColor,
//   IconData? icon,
//   Color? borderColor,
//   double? width,
//   double? height,
// }) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 4),
//     child: ReusableButton(
//       text: text,
//       isShimmer: true,
//       shimmerDuration: const Duration(seconds: 3),
//       onPressed: onPressed,
//       width: width ?? 100,
//       height: height ?? 30,
//       borderRadius: 20,
//       fontSize: 15,
//       backgroundColor: backgroundColor,
//       textColor: textColor,
//       borderColor: borderColor ?? Colors.transparent,
//       borderWidth: borderColor != null ? 1 : 0,
//       icon: icon,
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sattagames/screens/allScreens/hrefgames/crossing_combine.dart';
import 'package:sattagames/screens/allScreens/hrefgames/haruf_combine.dart';
import 'package:sattagames/widgets/reusable_button.dart';
import '../../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import 'jodi_combine.dart';
// ====== CustomTabScreen.dart ======
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sattagames/screens/allScreens/hrefgames/crossing_combine.dart';
import 'package:sattagames/screens/allScreens/hrefgames/haruf_combine.dart';
import 'package:sattagames/widgets/reusable_button.dart';
import '../../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import 'jodi_combine.dart';

// Controller to manage tab state
// ====== CustomTabScreen.dart ======
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sattagames/screens/allScreens/hrefgames/crossing_combine.dart';
import 'package:sattagames/screens/allScreens/hrefgames/haruf_combine.dart';
import 'package:sattagames/widgets/reusable_button.dart';
import '../../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import 'jodi_combine.dart';

// Controller to manage tab state
class TabControllerX extends GetxController {
  var selectedIndex = 0.obs;
  void setIndex(int index) {
    selectedIndex.value = index;
  }
}

class CustomTabScreen extends StatelessWidget {
  final String gameTitle;
  final String closeTime;
  final String openTime;

  CustomTabScreen({super.key, required this.gameTitle, required this.closeTime, required this.openTime});

  final List<String> tabNames = const ['Jodi', 'Crossing', 'Haruf'];

  // Stream to check close time
  // Stream to check close time
  Stream<bool> _closeTimeStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));

      try {
        DateTime now = DateTime.now();
        DateTime? endTime;
        DateTime? startTime;

        // ✅ parse openTime
        if (openTime.contains(" ")) {
          startTime = DateTime.tryParse(openTime);
        } else if (openTime.contains(":")) {
          final parts = openTime.split(":");
          if (parts.length >= 2) {
            int hour = int.tryParse(parts[0]) ?? 0;
            int minute = int.tryParse(parts[1]) ?? 0;
            startTime = DateTime(now.year, now.month, now.day, hour, minute);
          }
        }

        // ✅ parse closeTime
        if (closeTime.contains(" ")) {
          endTime = DateTime.tryParse(closeTime);
        } else if (closeTime.contains(":")) {
          final parts = closeTime.split(":");
          if (parts.length >= 2) {
            int hour = int.tryParse(parts[0]) ?? 0;
            int minute = int.tryParse(parts[1]) ?? 0;
            endTime = DateTime(now.year, now.month, now.day, hour, minute);
          }
        }

        // ✅ Adjust for next-day close
        if (startTime != null && endTime != null && endTime.isBefore(startTime)) {
          endTime = endTime.add(const Duration(days: 1));
        }

        if (endTime != null) {
          yield now.isAfter(endTime);
        } else {
          yield false;
        }
      } catch (e) {
        yield false;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final List<Widget> tabScreens = [
      JodiFullPage(gameName: gameTitle),
      CrossingFullPage(gameName: gameTitle),
      HarufCombinePage(gameName: gameTitle),
    ];

    final RegisterController userController = Get.put(RegisterController());
    final TabControllerX controller = Get.put(TabControllerX());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Obx(
                      () => Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 3,
                    runSpacing: 6,
                    children: List.generate(tabNames.length, (index) {
                      bool isSelected = controller.selectedIndex.value == index;
                      return _buildActionButton(
                        text: tabNames[index],
                        onPressed: () => controller.setIndex(index),
                        backgroundColor:
                        isSelected ? Colors.yellow : Colors.transparent,
                        textColor: isSelected ? Colors.black : Colors.white,
                        borderColor:
                        isSelected ? Colors.white : Colors.transparent,
                        width: 100,
                        height: 35,
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  double balance = (double.tryParse(
                      userController.userProfile.value?.balance
                          .toString() ??
                          '0.0') ??
                      0.0);
                      // (double.tryParse(userController.userProfile.value?.bonus
                      //     .toString() ??
                      //     '0.0') ??
                      //     0.0);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          gameTitle,
                          style: GoogleFonts.baloo2(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.yellow.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.amber, width: 1.5),
                          ),
                          child: Text(
                            "₹${balance.toStringAsFixed(2)}",
                            style: GoogleFonts.baloo2(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Expanded(
                  child: Obx(() => tabScreens[controller.selectedIndex.value]),
                ),
              ],
            ),

            // 🔴 Game Over Popup Layer
            StreamBuilder<bool>(
              stream: _closeTimeStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return Container(
                    color: Colors.black.withOpacity(0.8),
                    alignment: Alignment.center,
                    child: Container(
                      width: 280,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.lock, color: Colors.red, size: 50),
                          const SizedBox(height: 10),
                          Text(
                            "Game Over",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.baloo2(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Closed Time: $closeTime",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.baloo2(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(100, 40),
                            ),
                            onPressed: () {
                              Get.back(); // back screen पर चला जाएगा
                            },
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable shimmer button
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
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: ReusableButton(
      text: text,
      isShimmer: true,
      shimmerDuration: const Duration(seconds: 3),
      onPressed: onPressed,
      width: width ?? 100,
      height: height ?? 30,
      borderRadius: 20,
      fontSize: 15,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor ?? Colors.transparent,
      borderWidth: borderColor != null ? 1 : 0,
      icon: icon,
    ),
  );
}
