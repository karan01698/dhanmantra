import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sattagames/constants/colors.dart';

import '../../../../utils/responsvie_web_mobile.dart';
import '../../../drawer/addmoney/updatebalance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class RummyEntryController extends GetxController {
  var selectedPlayer = 6.obs;
  var pointValue = 0.05.obs;

  final double step = 0.05;
  final double min = 0.05;
  final double max = 125.0;

  double get entryFee => pointValue.value * 80;

  void changePlayer(int player) {
    selectedPlayer.value = player;
  }

  void updatePointValue(double value) {
    pointValue.value = (value / step).round() * step;
  }

  void increaseValue() {
    if (pointValue.value + step <= max) {
      pointValue.value += step;
    }
  }

  void decreaseValue() {
    if (pointValue.value - step >= min) {
      pointValue.value -= step;
    }
  }
}


class RummyEntryScreen extends StatelessWidget {
  const RummyEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RummyEntryController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveHelpers.w(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: ResponsiveHelpers.h(10)),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => UpdatebalanceScreens());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.getotp,
                    minimumSize: Size(double.infinity, ResponsiveHelpers.h(45)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ResponsiveHelpers.r(8)),
                    ),
                  ),
                  child: Text(
                    "ADD CASH",
                    style: TextStyle(
                      fontSize: ResponsiveHelpers.sp(16),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBE6),
                    borderRadius: BorderRadius.circular(ResponsiveHelpers.r(8)),
                    border: Border.all(color: Colors.orange.shade100),
                  ),
                  padding: EdgeInsets.all(ResponsiveHelpers.w(10)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: Colors.orange,
                        size: ResponsiveHelpers.sp(30),
                      ),
                      SizedBox(width: ResponsiveHelpers.w(10)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Prize: ₹7.50 Lakh | Starts at 12:30 PM",
                              style: TextStyle(
                                fontSize: ResponsiveHelpers.sp(14),
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Jackpot Afternoon Delight 7.5L GTD",
                              style: TextStyle(
                                fontSize: ResponsiveHelpers.sp(12),
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(ResponsiveHelpers.r(6)),
                          ),
                        ),
                        child: Text(
                          "Join for Free",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ResponsiveHelpers.sp(12),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ResponsiveHelpers.h(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
