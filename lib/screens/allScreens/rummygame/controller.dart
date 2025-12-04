import 'package:get/get.dart';

class RummyTabController extends GetxController {
  var selectedIndex = 0.obs;
  var selectedTab = 0.obs;
  //outer tabs
  void changeTab(int index) {
    selectedIndex.value = index;
  }
//innter tabs
  void selectTab(int index) {
    selectedTab.value = index;
  }
}
