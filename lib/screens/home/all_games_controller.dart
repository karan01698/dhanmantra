// popular_games_controller.dart
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../constants/images.dart';

class PopularGamesController extends GetxController {
  var showAll = false.obs;
  var visibleImages = <String>[].obs;
  final PageController pageController = PageController();

  final List<String> allGameImages = [
    // AppImages.baccarat,
    // AppImages.thaiHiLo,
    // AppImages.rummy,
    // AppImages.dragonTiger,
    // AppImages.aviator,
    // AppImages.royalFishing,
    // AppImages.ludo,
    // AppImages.thaiHiLo,
    // AppImages.aztecSpins,
    // AppImages.dealNoDeal,
    // AppImages.aviator,
    // AppImages.royalFishing,
  ];

  @override
  void onInit() {
    super.onInit();
    visibleImages.assignAll(allGameImages.take(12)); // Initially show 6 images
  }

  void toggleShowAll() {
    showAll.value = !showAll.value;
    if (showAll.value) {
      visibleImages.assignAll(allGameImages); // Show all images
    } else {
      visibleImages.assignAll(allGameImages.take(6)); // Collapse back to first 6 images
    }
  }

  void scrollRight() {
    if (!showAll.value) {
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void scrollLeft() {
    if (!showAll.value) {
      pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }
}
