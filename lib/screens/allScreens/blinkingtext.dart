import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlinkingTextController extends GetxController {
  RxBool isVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    _startBlinking();
  }

  void _startBlinking() {
    Future.delayed(Duration(milliseconds: 500), () {
      isVisible.value = !isVisible.value;
      _startBlinking();
    });
  }
}

class IPLBlinkingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlinkingTextController controller = Get.put(BlinkingTextController());

    return Scaffold(
      backgroundColor: Colors.black, // Background color
      body: Center(
        child: Container(
          width: 400,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xffbb1b1b) // Red background
           // Slightly rounded corners
          ),
          alignment: Alignment.center,
          child: Obx(() => Visibility(
            visible: controller.isVisible.value,
            child: Text(
              "* DHANMANTRA * ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )),
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: IPLBlinkingContainer(),
  ));
}
