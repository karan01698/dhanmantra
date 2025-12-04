import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sattagames/screens/allScreens/rummygame/practise/practise_scree.dart';
import '../../../../utils/responsvie_web_mobile.dart';
import '../Cash/points.dart';
import '../controller.dart';

class GameRummyInnerTabBar extends StatelessWidget {
  final RummyTabController controller = Get.put(RummyTabController());

  final List<String> tabTitles = ['POINTS', 'POOL', ];
  final List<Widget> tabScreens = [ // 👈 Your custom screen
    PractiseScreenPage(),
    PractiseScreenPage(),
    // Center(child: Text("SPIN & GO")),
    // Center(child: Text("DEALS")),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Container(
          color: Colors.grey.shade100,
          padding:
          EdgeInsets.symmetric(vertical: ResponsiveHelpers.h(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(tabTitles.length, (index) {
              bool isSelected = controller.selectedTab.value == index;

              return GestureDetector(
                onTap: () => controller.selectTab(index),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          tabTitles[index],
                          style: TextStyle(
                            fontSize: ResponsiveHelpers.sp(14),
                            color: isSelected
                                ? Colors.red.shade900
                                : Colors.black54,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        if (tabTitles[index] == "SPIN & GO")
                          Container(
                            margin: EdgeInsets.only(
                                left: ResponsiveHelpers.w(6)),
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveHelpers.w(6),
                              vertical: ResponsiveHelpers.h(2),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(
                                  ResponsiveHelpers.r(8)),
                            ),
                            child: Text(
                              '★ NEW',
                              style: TextStyle(
                                fontSize: ResponsiveHelpers.sp(10),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: ResponsiveHelpers.h(4)),
                    Container(
                      height: ResponsiveHelpers.h(2),
                      width: ResponsiveHelpers.w(40),
                      color: isSelected
                          ? Colors.red.shade900
                          : Colors.transparent,
                    ),
                  ],
                ),
              );
            }),
          ),
        )),
        Obx(() => Expanded(
          child: tabScreens[controller.selectedTab.value],
        )),
      ],
    );
  }
}
