

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sattagames/backend/rummyapi/join_create_api.dart';
import 'package:sattagames/screens/allScreens/othergames/teenpattiess/teenpattiess.dart';
import 'package:sattagames/screens/allScreens/rummygame/controller.dart';
import 'package:sattagames/screens/allScreens/rummygame/rummy_tab_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../NewGames/backend/apis/methods.dart';
import '../../NewGames/games/color-pred/color_pred.dart';
import '../../NewGames/games/roulette2/roulette/home/roulette/text.dart';
import '../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../constants/images.dart';
import '../home/tabs_games.dart';
import 'hrefgames/outsideCombine.dart';
import 'othergames/teenpattiess/rommidapi_dart.dart';
import 'package:sattagames/utils/game_launcher.dart';

import 'othergames/teenpattiess/teenpatiiweb.dart';

class ResponsiveCardLayout extends StatefulWidget {
  @override
  State<ResponsiveCardLayout> createState() => _ResponsiveCardLayoutState();
}

class _ResponsiveCardLayoutState extends State<ResponsiveCardLayout> {
  final GameCategoriesController controller =
      Get.put(GameCategoriesController());

  void showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(Colors.red.shade700),
                ),
                const SizedBox(height: 20),
                const CustomText(text: "Preparing your game"),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final RegisterController userController = Get.put(RegisterController());
    List<Widget> topGameWidgets = [
      GameCards(
        item: CardItem("Rummy", AppImages.rummy, null, Colors.blue,
            onTap: () {

              Get.to(() =>  RummyTabsScreen());
          // controller.handleGameTap(() async {
          //
          //   // Get.to(GameHomeScreen());
          // });
        }),
      ),


      // GameCards(
      //   item: CardItem(
      //     "Rummy",
      //     AppImages.rummy,
      //     null,
      //     Colors.blue,
      //     onTap: () {
      //       Get.defaultDialog(
      //         title: "Coming Soon",
      //         titleStyle: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.white,
      //         ),
      //         middleText: "This game will be available soon!",
      //         middleTextStyle: TextStyle(
      //           fontSize: 16,
      //           color: Colors.white70,
      //         ),
      //         backgroundColor: Colors.black.withOpacity(0.8), // 🔹 Transparent effect
      //         radius: 12,
      //         barrierDismissible: false, // बाहर क्लिक से close न हो
      //         confirm: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.blue,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(8),
      //             ),
      //           ),
      //           onPressed: () {
      //             Get.back(); // 🔹 Box dismiss
      //           },
      //           child: const Text("OK"),
      //         ),
      //       );
      //     },
      //   ),
      // ),

    GameCards(
        item: CardItem(
          "Teen Patti",
          AppImages.teenPatti,
          null,
          Colors.green,
          onTap: () {
            controller.handleGameTap(() async {
              final double balance = double.tryParse(
                  userController.userProfile.value?.balance.toString() ?? '0.0') ??
                  0.0;

              final double bonus = double.tryParse(
                  userController.userProfile.value?.bonus.toString() ?? '0.0') ??
                  0.0;

              final double total = balance + bonus;

              if (total < 10) {
                Get.defaultDialog(
                  title: "Insufficient Balance",
                  middleText: "You don't have sufficient balance to play.",
                  textConfirm: "OK",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.back(); // Close dialog
                  },
                );
              } else {
                if (!kIsWeb &&
                    (defaultTargetPlatform == TargetPlatform.android ||
                        defaultTargetPlatform == TargetPlatform.iOS)) {
                  // ✅ Mobile only: Set to landscape
                  await SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                }

                // ✅ Navigate based on platform
                if (kIsWeb) {

                  // Get.to(() => ResponsiveTeenPattiScreen(), binding: BindingsBuilder(() {
                  //   final RoomPlayerController Roomplayerscontroller =
                  //   Get.put(RoomPlayerController());
                  //   Roomplayerscontroller.initRoomJoin(); // har baar room join karega
                  // }));
                  launchWebGame('https://dhanmantragame.com/teenpatties/index.html');
                  //  Get.to(() => ResponsiveTeenPattiScreen());
                } else {
                  Get.to(() => ResponsiveTeenPattiScreen());
                }
              }
            });
          },
        ),
      ),

      GameCards(
        item: CardItem("Satta Matka", AppImages.sattaMatka, null, Colors.orange,
            onTap: () {
          controller.handleGameTap(() async {
            Get.to(LiveGameScreen());
          });
        }),
      ),
      GameCards(
        item: CardItem(
          "Color Prediction",
          "https://r2.erweima.ai/imgcompressed/compressed_3d5c4402a3f81b12a1c1dad477d6763d.webp",
          null,
          Colors.purple,
          onTap: () {
            controller.handleGameTap(() async {
              showLoader();
              // final user = await AppServices.getProfile();
              final userBalance = await AppServices.getWallet();
              if (!mounted) return;
              Navigator.pop(context);
              if (mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ColorPrediction(
                      // user: user[0],
                      userBalance: userBalance[0],
                    ),
                  ),
                );
              }
            });
          },
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 16.0, right: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double itemWidth = (constraints.maxWidth - 16) / 2;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: topGameWidgets.map((widget) {
                  return SizedBox(
                    width: itemWidth,
                    child: widget,
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CardItem {
  final String title;
  final String? imagePath;
  final IconData? icon;
  final Color color;
  final VoidCallback? onTap;

  CardItem(this.title, this.imagePath, this.icon, this.color, {this.onTap});
}

class GameCards extends StatelessWidget {
  final CardItem item;
  final bool isSetting;

  const GameCards({
    required this.item,
    this.isSetting = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
          image: item.imagePath != null
              ? DecorationImage(
                  image: NetworkImage(item.imagePath!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Stack(
          children: [
            if (item.imagePath != null)
              Container(
                decoration: BoxDecoration(
                  // color: item.color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Text(
            //     item.title,
            //     style: GoogleFonts.baloo2(
            //       color: Colors.white,
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
