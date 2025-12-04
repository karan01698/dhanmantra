import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sattagames/constants/colors.dart';

import '../../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../../backend/rummyapi/join_create_api.dart';
import '../../../../utils/game_launcher_stub.dart';
import '../../../../utils/responsvie_web_mobile.dart';

import '../../othergames/teenpattiess/rommidapi_dart.dart';
import '../../othergames/teenpattiess/teenpattiess.dart';
import '../Cash/points.dart';

class PractiseScreenPage extends StatelessWidget {
  const PractiseScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RummyEntryController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveHelpers.w(20)),
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: ResponsiveHelpers.h(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.circle, color: Colors.green, size: ResponsiveHelpers.sp(12)),
                    SizedBox(width: ResponsiveHelpers.w(5)),
                    Text(
                      "Online: 66990",
                      style: TextStyle(
                        fontSize: ResponsiveHelpers.sp(14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    // Icon(Icons.help_outline, color: Colors.orange),
                  ],
                ),
                SizedBox(height: ResponsiveHelpers.h(30)),
                Text(
                  "Select Players",
                  style: TextStyle(
                    fontSize: ResponsiveHelpers.sp(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: ResponsiveHelpers.h(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => controller.changePlayer(2),
                      child: _playerBox("2", isSelected: controller.selectedPlayer.value == 2),
                    ),
                    SizedBox(width: ResponsiveHelpers.w(10)),
                    GestureDetector(
                      onTap: () => controller.changePlayer(6),
                      child: _playerBox("6", isSelected: controller.selectedPlayer.value == 6),
                    ),
                  ],
                ),

                SizedBox(height: ResponsiveHelpers.h(10)),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => ResponsiveTeenPattiScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.getotp,
                    minimumSize: Size(double.infinity, ResponsiveHelpers.h(45)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ResponsiveHelpers.r(8)),
                    ),
                  ),
                  child: Text(
                    "Play Now",
                    style: TextStyle(
                      fontSize: ResponsiveHelpers.sp(16),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                // Container(
                //   decoration: BoxDecoration(
                //     color: const Color(0xFFFFFBE6),
                //     borderRadius: BorderRadius.circular(ResponsiveHelpers.r(8)),
                //     border: Border.all(color: Colors.orange.shade100),
                //   ),
                //   padding: EdgeInsets.all(ResponsiveHelpers.w(10)),
                //   child: Row(
                //     children: [
                //       Icon(Icons.emoji_events, color: Colors.orange, size: ResponsiveHelpers.sp(30)),
                //       SizedBox(width: ResponsiveHelpers.w(10)),
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "Prize: ₹7.50 Lakh | Starts at 12:30 PM",
                //               style: TextStyle(
                //                 fontSize: ResponsiveHelpers.sp(14),
                //                 fontWeight: FontWeight.w500,
                //                 color: Colors.black,
                //               ),
                //             ),
                //             Text(
                //               "Jackpot Afternoon Delight 7.5L GTD",
                //               style: TextStyle(
                //                 fontSize: ResponsiveHelpers.sp(12),
                //                 color: Colors.grey[700],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       TextButton(
                //         onPressed: () {},
                //         style: TextButton.styleFrom(
                //           backgroundColor: Colors.green,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(ResponsiveHelpers.r(6)),
                //           ),
                //         ),
                //         child: Text(
                //           "Join for Free",
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: ResponsiveHelpers.sp(12),
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: ResponsiveHelpers.h(20)),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget _playerBox(String label, {required bool isSelected}) {
    return Container(
      width: ResponsiveHelpers.w(50),
      height: ResponsiveHelpers.h(40),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Colors.red.shade700 : Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelpers.r(8)),
        border: Border.all(
          color: isSelected ? Colors.red.shade700 : Colors.grey,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: ResponsiveHelpers.sp(16),
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
