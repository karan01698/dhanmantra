import 'package:animated_background/animated_background.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BackgroundController extends GetxController {
  Rx<Color> baseColor = Colors.purpleAccent.obs;
  Rx<Color> highlightColor = Colors.deepPurple.obs;
}

class GameBackgroundWidget extends StatefulWidget {
  final Widget child; // This lets you inject content

  const GameBackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  _GameBackgroundWidgetState createState() => _GameBackgroundWidgetState();
}

class _GameBackgroundWidgetState extends State<GameBackgroundWidget>
    with TickerProviderStateMixin {
  final backgroundController = Get.put(BackgroundController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        // Particle animation
        AnimatedBackground(
          vsync: this,
          behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
              baseColor: backgroundController.baseColor.value,
              spawnOpacity: 0.0,
              opacityChangeRate: 0.25,
              minOpacity: 0.1,
              maxOpacity: 0.4,
              spawnMinSpeed: 30.0,
              spawnMaxSpeed: 80.0,
              spawnMinRadius: 2.0,
              spawnMaxRadius: 8.0,
              particleCount: 100,
            ),
          ),
          child: Container(),
        ),

        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                backgroundController.baseColor.value.withOpacity(0.4),
                backgroundController.highlightColor.value.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // Foreground content
        widget.child,
      ],
    ));
  }
}
