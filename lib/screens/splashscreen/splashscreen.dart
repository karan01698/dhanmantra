// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import '../../constants/images.dart';
// import '../home/home_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _horizontalScale;
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//         _playAudio();
//
//         // Navigate after delay
//         Future.delayed(const Duration(seconds: 5), () {
//     _audioPlayer.stop(); // Stop audio before navigating
//     Get.off(() => MainHomeScreen());
//     });
//     );
//     Future<void> _playAudio() async {
//     await _audioPlayer.play(AssetSource('audio/wheel.mp3'));
//     }
//     _horizontalScale = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
//     );
//     @override
//     void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//     }
//     _controller.forward();
//
//     Future.delayed(Duration(seconds: 5), () {
//         Get.off(() => MainHomeScreen());
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           AnimatedBuilder(
//             animation: _horizontalScale,
//             builder: (context, child) {
//               return Align(
//                 alignment: Alignment.centerLeft, // start from left
//                 child: Transform(
//                   alignment: Alignment.centerLeft,
//                   transform: Matrix4.identity()..scale(_horizontalScale.value, 1.0),
//                   child: child,
//                 ),
//               );
//             },
//             child: Image.asset(
//               AppImages.splashLogo,
//               width: 500,
//               height: 300,
//             ),
//           ),
//           SizedBox(height: 20),
//           Lottie.asset('assets/newcircle.json', width: 400, height: 300),
//         ],
//       ),
//     );
//   }
// }


import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../constants/images.dart';
import '../../main.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _horizontalScale;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _horizontalScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );

    _controller.forward();

    _playAudio();

    // Navigate after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      _audioPlayer.stop(); // Stop audio before navigating
      Get.off(() => MainHomeScreen());
    });
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.play(AssetSource('audio/wheel.mp3'));
    } catch (e) {
      logPrint("Error playing audio: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _horizontalScale,
            builder: (context, child) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Transform(
                  alignment: Alignment.centerLeft,
                  transform:
                  Matrix4.identity()..scale(_horizontalScale.value, 1.0),
                  child: child,
                ),
              );
            },
            child: Image.asset(
              AppImages.splashLogo,
              width: 500,
              height:500,
            ),
          ),
          const SizedBox(height: 20),
          // Lottie.asset('assets/newcircle.json', width: 400, height: 300),
        ],
      ),
    );
  }
}
