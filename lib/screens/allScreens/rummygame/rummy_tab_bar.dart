import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sattagames/constants/colors.dart';
import 'package:sattagames/screens/allScreens/rummygame/practise/rummy_inner_tab_bar.dart';
import '../../../utils/responsvie_web_mobile.dart';
import '../../drawer/addmoney/updatebalance.dart';
import 'Tournments/tournment_card.dart';
import 'controller.dart';
import 'leaderboard/leaderboard.dart';

class RummyTabsScreen extends StatelessWidget {
  final RummyTabControllerss controller = Get.put(RummyTabControllerss());

  final List<String> tabLabels = ["Cash", "Points", "Pool", "Deals"];

  final List<Widget> tabContents = [
    SizedBox.shrink(), // CASH (handled separately)
    // GameRummyInnerTabBar(),

    TournmentCard(),
    TournmentCard(),
    TournmentCard(),
    // LeaderboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Always default to PRACTICE tab on screen entry
    controller.changeTab(1);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (_, __) => Scaffold(
        body: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ),
            ),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(tabLabels.length, (index) {
                bool isSelected = controller.selectedIndex.value == index;

                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      // Navigate to CASH screen and reset tab to PRACTICE when coming back
                      Get.to(() => UpdatebalanceScreens())?.then((_) {
                        controller.changeTab(1);
                      });
                    } else {
                      controller.changeTab(index);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelpers.w(12),
                      vertical: ResponsiveHelpers.h(10),
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.getotp : Colors.white,
                      borderRadius: BorderRadius.circular(ResponsiveHelpers.r(10)),
                      boxShadow: isSelected
                          ? [BoxShadow(color: Colors.black12, blurRadius: ResponsiveHelpers.r(4))]
                          : [],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _getIcon(index),
                          size: ResponsiveHelpers.w(22),
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        SizedBox(height: ResponsiveHelpers.h(4)),
                        Text(
                          tabLabels[index],
                          style: TextStyle(
                            fontSize: ResponsiveHelpers.sp(12),
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            )),
            SizedBox(height: ResponsiveHelpers.h(20)),

            // Show tab content only if not CASH
            Expanded(
              child: Obx(() {
                final currentIndex = controller.selectedIndex.value;
                if (currentIndex == 0) return const SizedBox(); // CASH tab never shows here
                return tabContents[currentIndex];
              }),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.currency_rupee;
      case 1:
        return Icons.sports_soccer;
      case 2:
        return Icons.emoji_events;
      case 3:
        return Icons.military_tech;
      default:
        return Icons.circle;
    }
  }
}


class RummyTabControllerss extends GetxController {
  var selectedIndex = 1.obs; // Start with PRACTICE

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
