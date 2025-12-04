import 'package:sattagames/backend/authenticanapi/controllerapi/registerapicontroller.dart';
import 'package:sattagames/backend/sliderapi.dart';
import 'package:sattagames/screens/home/slider.dart';
import 'package:sattagames/screens/home/tabs_games.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../authenticationsScreens/sharecontroller.dart';
import '../../backend/shareapi.dart';
import '../../constants/backgound/scaffold_background.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../main.dart';
import '../allScreens/allscreens.dart';
import '../allScreens/blinkingtext.dart';
import '../allScreens/marquee.dart';
import '../allScreens/othergames.dart';
import '../crickettab/crickettab.dart';
import '../cutomappbar/custom_app_bar.dart';
import '../drawer/rigthdrawer/rightdrawer.dart';
import 'all_games_controller.dart';
import 'comingsoonimages.dart';
import 'inplay.dart';

class HomeScreen extends StatelessWidget {
  final String email;

  HomeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(1), // ✅ This allows navigation inside Home
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => MainHomeScreen(),
        );
      },
    );
  }
}

// class SportsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: Get.nestedKey(2), // ✅ Unique key for Sports navigation
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute(
//           builder: (context) =>
//               SportsPage(), // Load SportsPage inside Navigator
//         );
//       },
//     );
//   }+
// }

//
class MainHomeScreen extends StatelessWidget {
  final PopularGamesController controller = Get.put(PopularGamesController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ShareController sharecontroller = Get.find<ShareController>();
    final LoginAuthController authController = Get.find<LoginAuthController>();
  MainHomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
      await authController.fetchFreezeStatus();
      authController.showFreezeDialogIfNeeded();

    });
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),
      endDrawer: CustomDrawerss(),
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                MarqueeWidget(
                  text: "🔥 DHANMANTRA IS INDIA'S TRUSTED SITE SINCE LAST 6 YEARS! 🇮🇳✅💰",
                ),
                SizedBox(height: 35, child: IPLBlinkingContainer()),
                const SizedBox(height: 10),
                SizedBox(height: 200, child: SliderScreen()),
                MarqueeWidget(
                  text:
                  "🎉 OUR EXCLUSIVE NEXT-GEN GAME ZONE IS LIVE ON OUR EXCHANGE. THINK BIG, WIN BIGGER! 🚀🔥    "
                      "🏆 OUR LUCKY DRAW WINNERS🏆"
                      "🚗 RAJESH WON A BRAND NEW SUV CAR 🎉🏆"
                      "⌚ ARJUN GOT A SMART WATCH!"
                      "📷 NEHA WON A DIGITAL CAMERA!"
                      "🎧 PRIYA GRABBED STYLISH WIRELESS EARBUDS!"
                      "📱 MUKESH WON A BRAND-NEW IPHONE!"
                      "🎊 CONGRATULATIONS TO ALL WINNERS! 🎉🎉    "
                      "🔥 MORE WINNERS COMING SOON! 🚀🏆    ",
                  fontSize: 18,
                  textColor: Colors.white,
                  velocity: 50.0,
                  blankSpace: 100.0,
                ),
                const SizedBox(height: 10),
                SizedBox(height: 360, child: ResponsiveCardLayout()),
                newGameCategoriesWidget(),
                const SizedBox(height: 100), // Extra space for fixed buttons
              ],
            ),
          ),

          // WhatsApp Button - Bottom Right
          Positioned(
            right: 20,
            bottom: 20,
            child: GestureDetector(
              onTap: _openWhatsApp,
              child: Container(
                width: 60,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.callIcons),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Share Button - Bottom Left
          Positioned(
            left: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: sharecontroller.shareImage,
              backgroundColor: Colors.blue,
              tooltip: 'Share Referral Code',
              child: Icon(Icons.share, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 2, // Adjust size
        height: MediaQuery
            .of(context)
            .size
            .height * 0.7,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5), // Background with opacity
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Opacity(
          opacity: 0.9, // Adjust transparency
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15), // Match container
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.blue.withOpacity(0.3), // Apply color filter
                BlendMode.overlay, // Change blending mode
              ),
              child: Image.asset(
                'assets/alltypesimages.png', // Put image in `assets`
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class SportsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView( // ✅ Added SingleChildScrollView
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.getotp, width: 1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: SizedBox(height: 800, child: CrickettabScreen()),
//
//           ),
//         ),
//       ),
//     );
//   }
// }

class ECricketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://www.pngarts.com/files/8/Airplane-Cartoon-PNG-Transparent-Image.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "E-Games Coming Soon",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class HorseRiding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://www.pngarts.com/files/8/Airplane-Cartoon-PNG-Transparent-Image.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "E-Games Coming Soon",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}


class Baccarat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://www.pngarts.com/files/8/Airplane-Cartoon-PNG-Transparent-Image.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "E-Games Coming Soon",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class CardGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://www.pngarts.com/files/8/Airplane-Cartoon-PNG-Transparent-Image.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "E-Games Coming Soon",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class FishingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://www.pngarts.com/files/8/Airplane-Cartoon-PNG-Transparent-Image.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "E-Games Coming Soon",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
class AuraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 350,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://teenpatti.in.net/wp-content/uploads/2022/04/HOW-TO-PLAY-TEEN-PATTI.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Live Casino Coming Soon",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildUpcomingEvents() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColors.secondaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upcoming Events",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 5),
        ListTile(
          title: Text("New Zealand vs India",
              style: TextStyle(color: Colors.white)),
          subtitle:
          Text("Tomorrow 2:30 PM", style: TextStyle(color: Colors.white70)),
          trailing: Text("2.96 - 1.5",
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        ListTile(
          title: Text("Up Warriorz W vs Gujarat Giants W",
              style: TextStyle(color: Colors.white)),
          subtitle: Text("03-03-2025 7:30 PM",
              style: TextStyle(color: Colors.white70)),
          trailing: Text("2.12 - 1.8",
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ],
    ),
  );
}

class LiveCasinoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Ensures only necessary space is occupied
          children: [
            Container(
              height: 350,
              width: double.infinity, // Ensures image stays centered
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://teenpatti.in.net/wp-content/uploads/2022/04/HOW-TO-PLAY-TEEN-PATTI.png',
                  ),
                  fit: BoxFit.contain, // Keeps image within bounds
                ),
              ),
            ),
            const SizedBox(height: 20), // Adds spacing between image and text
            const Text(
              "Live Casino Coming Soon",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: QRScreen(),
    );
  }
}

class QRScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Code Scanner")),
      body: Obx(() {
        if (controller.qrList.isEmpty) {
          return Center(child: Text("No Data Available"));
        }

        return ListView.builder(
          itemCount: controller.qrList.length,
          itemBuilder: (context, index) {
            var qrData = controller.qrList[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.network(qrData.qr1, height: 200, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text("ID: ${qrData.id}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text("UPI: ${qrData.upi}",
                            style: TextStyle(fontSize: 16, color: Colors.blue)),


                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
void _openWhatsApp() async {
  final ShareControllerapi controller = Get.put(ShareControllerapi());

  // Ensure +91 is added before the number
  String phoneNumber = controller.shareList[0].number;
  if (!phoneNumber.startsWith('+')) {
    phoneNumber = '+91$phoneNumber'; // Prepend +91 if not already present
  }

  String messagess = controller.shareList[0].message;
  // String message = Uri.encodeComponent("Hello, I need some help $messagess.");
  String message = Uri.encodeComponent("Hello, I need some help");
  String url = "https://wa.me/${phoneNumber.replaceAll('+', '')}?text=$message";

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    logPrint("Could not open WhatsApp.");
  }
}