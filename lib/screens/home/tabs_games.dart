// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../constants/colors.dart';
// import '../../constants/images.dart';
// class GameCategoriesController extends GetxController {
//   var visibleImages = <String>[].obs;
//
//   final List<String> gameImages = [
//     AppImages.baccarat,
//     AppImages.thaiHiLo,
//     AppImages.rummy,
//     AppImages.dragonTiger,
//     AppImages.aviator,
//     AppImages.dealNoDeal,
//     AppImages.hilo,
//     AppImages.AmarAkhbar,
//     AppImages.teenPatti,
//     AppImages.teenPatti2020,
//     AppImages.horseRiding,
//     AppImages.blackJack,
//     AppImages.sicbo,
//     AppImages.sevenupDown,
//     AppImages.joker,
//     AppImages.roulette,
//     AppImages.muflis,
//     AppImages.poker,
//     AppImages.craps,
//     AppImages.rouletteLighting,
//     AppImages.stromLighting,
//     AppImages.shareMarket,
//     AppImages.sexyBaccarat,
//     AppImages.coinFlip,
//   ];
//
//   @override
//   void onInit() {
//     super.onInit();
//     visibleImages.assignAll(gameImages);
//   }
// }
//
// class GameCategoriesWidget extends StatelessWidget {
//   final GameCategoriesController controller = Get.put(GameCategoriesController());
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         int crossAxisCount = constraints.maxWidth ~/ 120; // Adjust image size dynamically
//
//         return Container(
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Obx(() {
//             return GridView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: crossAxisCount,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 1, // Square aspect ratio
//               ),
//               itemCount: controller.visibleImages.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () => _showComingSoonDialog(context),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(6),
//                     child: Image.asset(
//                       controller.visibleImages[index],
//                       fit: BoxFit.cover,
//                       width: 100,
//                       height: 100,
//                     ),
//                   ),
//                 );
//               },
//             );
//           }),
//         );
//       },
//     );
//   }
//
//   void _showComingSoonDialog(BuildContext context) {
//     Get.dialog(
//       Dialog(
//         backgroundColor: Colors.transparent,
//         child: Stack(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                 child: Container(
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.white.withOpacity(0.3)),
//                   ),
//                   width: 300,
//                   height: 200,
//                   child: Center(
//                     child: Text(
//                       "Coming Soon...",
//                       style: GoogleFonts.baloo2(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               right: 10,
//               top: 10,
//               child: GestureDetector(
//                 onTap: () => Get.back(),
//                 child: CircleAvatar(
//                   backgroundColor: Colors.black.withOpacity(0.5),
//                   radius: 15,
//                   child: Icon(Icons.close, color: Colors.white, size: 18),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../NewGames/backend/apis/methods.dart';
import '../../NewGames/games/color-pred/color_pred.dart';
import '../../NewGames/games/roulette2/roulette/home/roulette/text.dart';
import '../../constants/images.dart';
import '../../widgets/primaryButton.dart';
import '../drawer/custom_drawer.dart';

class GameCategoriesController extends GetxController {
  var visibleImages = <String>[].obs;
  final AuthControllersss authController = Get.put(AuthControllersss());
  final List<String> gameImages = [

    AppImages.wheel,
    AppImages.mines,
    AppImages.plinko,
    AppImages.aviator,


  ];
  void handleGameTap(Function action) {
    if (authController.isLoggedIn.value) {
      action(); // Run the game action
    } else {
      Get.snackbar(
        "Access Denied",
        "Please log in to continue.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    visibleImages.assignAll(gameImages);
  }
}

class GameCategoriesWidget extends StatefulWidget {
  final String email;

  const GameCategoriesWidget({super.key, required this.email});

  @override
  State<GameCategoriesWidget> createState() => _GameCategoriesWidgetState();
}

class _GameCategoriesWidgetState extends State<GameCategoriesWidget> {
  final GameCategoriesController controller =
      Get.put(GameCategoriesController());


  @override
  Widget build(BuildContext context) {

    void showLoader() {
      showDialog(
        context: context,
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

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount =
            constraints.maxWidth ~/ 120; // Adjust image size dynamically

        return Padding(
          padding: const EdgeInsets.only(
            top: 3,
            left: 3.0,
            right: 3,
          ),
          child: Container(
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  padding: const EdgeInsets.all(15),
                  children: [
                    InkWell(
                      onTap: () {
                        controller.handleGameTap(() async {
                          showLoader();
                          final user = await AppServices.getProfile();
                          final userBalance = await AppServices.getWallet();
                          if (!context.mounted) return;
                          Navigator.pop(context);
                          if (context.mounted) {
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
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 16.0,
                          bottom: 10,
                        ),
                        child: GestureDetector(
                          child: const GameCard(
                            imgName:
                                "https://r2.erweima.ai/imgcompressed/compressed_3d5c4402a3f81b12a1c1dad477d6763d.webp",
                            gameName: "Color Prediction",
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  ],
                ),
                const SizedBox(height: 12),

              ],
            ),
          ),
        );
      },
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  width: 300,
                  height: 200,
                  child: Center(
                    child: Text(
                      "Coming Soon...",
                      style: GoogleFonts.baloo2(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  radius: 15,
                  child: Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String gameName;
  final String imgName;

  const GameCard({super.key, required this.imgName, required this.gameName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(2, 4), // Slight shadow for depth
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        // child: CachedNetworkIe(
        //   imageUrl: imgName,
        //   fit: _getBoxFit(),
        //   placeholder: (context, url) => _buildShimmerPlaceholder(),
        //   errorWidget: (context, url, error) => _buildErrorWidget(),
        // ),
        child: Image.network(
          imgName,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  BoxFit _getBoxFit() {
    return (gameName.contains("Fortune") || gameName.contains("Teen"))
        ? BoxFit.fill
        : BoxFit.cover;
  }

  Widget _buildShimmerPlaceholder() {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.5),
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.broken_image, size: 50, color: Colors.grey),
          SizedBox(height: 5),
          Text("Image not available", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class GamesCard extends StatelessWidget {
  final String gameName;
  final String imgName;
  final double? height; // Height for the image
  final double? heightofcontainer; // Height of the entire card
  final double? width; // Width for the image
  final double? widthofcontainer; // Width of the entire card

  const GamesCard({
    super.key,
    required this.imgName,
    required this.gameName,
    this.width,
    this.height,
    this.heightofcontainer,
    this.widthofcontainer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.9),
            blurRadius: 8,
            offset: const Offset(2, 4), // Slight shadow for depth
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imgName,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Center(child: Icon(Icons.broken_image, size: 50)),
        ),
      ),
    );
  }
}

void _showComingSoonDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black, // Dark overlay
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Coming Soon!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "This game is not available yet. Stay tuned for exciting updates!",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    primaryButton(
                      context: context,
                      text: "Okay",
                      textStyle: TextStyle(color: Colors.black),
                      // Correctly defined TextStyle
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
