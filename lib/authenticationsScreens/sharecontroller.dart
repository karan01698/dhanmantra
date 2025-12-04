// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart'; // Import share_plus package
// import 'dart:math'; // For generating random codes
//
// class Shares extends StatefulWidget {
//   @override
//   _SharesState createState() => _SharesState();
// }
//
// class _SharesState extends State<Shares> {
//   // Track the selected index for bottom navigation
//   int _selectedIndex = 0;
//
//   // Function to generate a random referral code
//   String generateRandomReferralCode() {
//     final _random = Random();
//     const _characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
//     return List.generate(6, (index) => _characters[_random.nextInt(_characters.length)]).join();
//   }
//
//   // Function to generate the referral link
//   String generateReferralLink(String code) {
//     return 'https://yourapp.com/referral?code=$code';  // Replace with your actual referral link
//   }
//
//   // Function to trigger share functionality
//   void shareReferralCode(String referralLink) {
//     Share.share(referralLink);  // Share the referral link using share_plus
//   }
//
//   // Function to show bottom navigation
//   void openBottomNavigation() {
//     setState(() {
//       _selectedIndex = 1;  // Change index to show bottom navigation options
//     });
//   }
//
//   // Bottom navigation bar items
//   void onTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Share Your Referral'),
//       ),
//       body: Center(
//         child: Text('Click the FAB to generate a referral code!'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           String randomCode = generateRandomReferralCode();  // Generate random code
//           String referralLink = generateReferralLink(randomCode);  // Create referral URL
//           shareReferralCode(referralLink);  // Trigger share functionality
//           openBottomNavigation();  // Open bottom navigation
//         },
//         child: Icon(Icons.share), // Share icon inside the FAB
//         tooltip: 'Share Referral Code',
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,  // Set current selected index
//         onTap: onTap,  // Handle bottom navigation item taps
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.share),
//             label: 'Share',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
// }

//
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../backend/shareapi.dart';
import '../main.dart';
//
// class ShareControllerss extends GetxController {
//   RxInt selectedIndex = 0.obs;
//   RxString referralCode = ''.obs;
//   void changeTab(int index) {
//     selectedIndex.value = index;
//   }
//
//   String generateRandomReferralCode() {
//     final _random = Random();
//     const _characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
//     return List.generate(6, (index) => _characters[_random.nextInt(_characters.length)]).join();
//   }
//
//   // String generateReferralLink(String code) {
//   //   final link = 'https://abjbook.com/';
//   //   return 'Hey! I’m using this awesome app and thought you’d love it too. Use my referral code **$code** to get a bonus when you sign up! Tap here to join: $link';
//   // }
//
//   void shareReferralCode() {
//     String code = generateRandomReferralCode();
//     referralCode.value = code;
//     // String link = generateReferralLink(code);
//     // Share.share(link);
//     // changeTab(1);
//   }
// }



///what'sapp
// class ShareController extends GetxController {
//   final RegisterController userController = Get.put(RegisterController());
//   RxInt selectedIndex = 0.obs;
//   RxString referralCode = ''.obs;
//   void changeTab(int index) {
//     selectedIndex.value = index;
//   }
//
//   // String generateRandomReferralCode() {
//   //   final _random = Random();
//   //   const _characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
//   //   return List.generate(6, (index) => _characters[_random.nextInt(_characters.length)]).join();
//   // }
//
//   String generateReferralLink(String code) {
//     final link = 'https://abjbook.com/';
//     return 'Hey! I’m using this awesome app and thought you’d love it too. Use my referral code **$code** to get a bonus when you sign up! Tap here to join: $link';
//   }
//
//   void shareReferralCode() {
//     String code = userController.userProfile.value?.promoCode ?? 0.0
//     referralCode.value = code;
//     String link = generateReferralLink(code);
//     Share.share(link);
//     changeTab(1);
//   }
// }

class ShareController extends GetxController {
  final RegisterController userController = Get.put(RegisterController());
  RxInt selectedIndex = 0.obs;
  RxString referralCode = ''.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // String generateRandomReferralCode() {
  //   final _random = Random();
  //   const _characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  //   return List.generate(6, (index) => _characters[_random.nextInt(_characters.length)]).join();
  // }

  // String generateReferralLink(String code) {
  //   final link = 'https://dhanmantragame.com/';
  //   return 'Hey! I’m using this awesome app and thought you’d love it too.Tap here to join and get bonus up to 50% on first deposit: $link';
  // }
  // String generateReferralLink(String code) {
  //   final link = 'https://dhanmantragame.com/?ref=$code';
  //
  //   final point = "https://images.app.goo.gl/fSias3WCcJJuufzF9";
  //   final point1 = "1️⃣ Hey! I’m using this awesome app.";
  //   final point2 = "2️⃣ Thought you’d love it too! 💚";
  //   final point3 = "3️⃣ Tap the link below to join:";
  //   final point4 = "4️⃣ Get up to 50% bonus on your first deposit! 🎉\n$link";
  //
  //   return '$point\n$point1\n$point2\n$point3\n$point4';
  // }
  //
  // void shareReferralCode() {
  //   // Ensure promoCode is fetched as a String, with a fallback if null
  //   String code = userController.userProfile.value?.promoCode ?? '';
  //   referralCode.value = code;
  //
  //   // Generate and share the referral link
  //   String link = generateReferralLink(code);
  //   Share.share(link);
  //
  //   // Change the tab after sharing the code
  //   changeTab(1);
  // }


//   Future<void> shareImage() async {
//     try {
//       // Load asset image
//       final byteData = await rootBundle.load('assets/sharingimages.png');
//
//       // Get temp directory and write to file
//       final tempDir = await getTemporaryDirectory();
//       final file = File('${tempDir.path}/sharingimages.png');
//       await file.writeAsBytes(byteData.buffer.asUint8List());
//
//       // Referral message with image and link
//       const link = 'https://dhanmantragame.com/';
//       const point1 = "1️⃣ Hey! I’m using this awesome app.";
//       const point2 = "2️⃣ Thought you’d love it too! 💚";
//       const point3 = "3️⃣ Tap the link below to join:";
//       final point4 =
//           "4️⃣ Get up to 50% bonus on your first deposit! 🎉\n$link";
//
//       final fullMessage = '$point1\n$point2\n$point3\n$point4';
//
//       // Share image with message
//       await Share.shareXFiles(
//         [XFile(file.path)],
//         text: fullMessage,
//       );
//     } catch (error) {
//       logPrint('Error sharing image: $error');
//     }
//   }
// }
//


//   Future<void> shareImage() async {
//     try {
//
//       const link = 'https://dhanmantragame.com/';
//       const imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScTgBHJddWcIEcxEYahoPIrO6KTb7LhrZM-g&s"; // ✅ Upload your image
//       const point1 = "1️⃣ Hey! I’m using this awesome app.";
//       const point2 = "2️⃣ Thought you’d love it too! 💚";
//       const point3 = "3️⃣ Tap the link below to join:";
//       final point4 = "4️⃣ Get up to 50% bonus on your first deposit! 🎉";
//
//       final fullMessage = '''
// $imageUrl
//
// $point1
// $point2
// $point3
// $link
// $point4
// ''';
//
//       if (kIsWeb) {
//         debuglogPrint("📤 Sharing message (Web): $fullMessage");
//         debuglogPrint("🌐 Image URL: $imageUrl");
//         await Share.share('$imageUrl\n\n$fullMessage');
//
//       } else {
//         final byteData = await rootBundle.load('assets/sharingimages.png');
//         final tempDir = await getTemporaryDirectory();
//         final file = File('${tempDir.path}/sharingimages.png');
//         await file.writeAsBytes(byteData.buffer.asUint8List());
//
//         await Share.shareXFiles(
//           [XFile(file.path)],
//           text: fullMessage,
//         );
//       }
//     } catch (error) {
//       logPrint('Error sharing image: $error');
//     }
//   }
// }


//
// Future<void> shareImage() async {
//   try {
//     final ShareControllerapi controller = Get.put(ShareControllerapi());
//     // String phoneNumber = "9211283318";
//     String logo = controller.shareList[0].logo;
//     String messagess = controller.shareList[0].message;
//     const link = 'https://dhanmantragame.com/';
//     const imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScTgBHJddWcIEcxEYahoPIrO6KTb7LhrZM-g&s"; // ✅ Upload your image
//     const point1 = "1️⃣ Hey! I’m using this awesome app.";
//     const point2 = "2️⃣ Thought you’d love it too! 💚";
//     const point3 = "3️⃣ Tap the link below to join:";
//     final point4 = "4️⃣ Get up to 50% bonus on your first deposit! 🎉";
//
//     final fullMessage = '''
// $imageUrl
//
// $point1
// $point2
// $point3
// $link
// $point4
// ''';
//
//     if (kIsWeb) {
//       debuglogPrint("📤 Sharing message (Web): $fullMessage");
//       debuglogPrint("🌐 Image URL: $imageUrl");
//       await Share.share('$imageUrl\n\n$fullMessage');
//
//     } else {
//       final byteData = await rootBundle.load('assets/sharingimages.png');
//       final tempDir = await getTemporaryDirectory();
//       final file = File('${tempDir.path}/sharingimages.png');
//       await file.writeAsBytes(byteData.buffer.asUint8List());
//
//       await Share.shareXFiles(
//         [XFile(file.path)],
//         text: fullMessage,
//       );
//     }
//   } catch (error) {
//     logPrint('Error sharing image: $error');
//   }
// }
//
//   Future<void> shareImage() async {
//     try {
//       final ShareControllerapi controller = Get.put(ShareControllerapi());
//       String logo = controller.shareList[0].logo;         // Image URL
//       String messagess = controller.shareList[0].message; // Dynamic multiline message
//       const link = 'https://dhanmantragame.com/';
//
//       // Split the message into lines (assuming \n or any line separator)
//       final messageLines = messagess.split('\n');
//
//       // Prepare a list of emojis for points 1 to 4
//       final emojis = ['1️⃣', '2️⃣', '3️⃣', '4️⃣'];
//
//       // Build the message lines with emojis
//       final emojiMessage = List.generate(
//         messageLines.length,
//             (index) => '${emojis[index % emojis.length]} ${messageLines[index]}',
//       ).join('\n');
//
//       final fullMessage = '''
// $logo
//
// $emojiMessage
//
// $link
// ''';
//
//       if (kIsWeb) {
//         debuglogPrint("📤 Sharing message (Web): $fullMessage");
//         debuglogPrint("🌐 Image URL: $logo");
//         await Share.share('$logo\n\n$fullMessage');
//       } else {
//         // final byteData = await rootBundle.load('assets/sharingimages.png');
//         final byteData = await rootBundle.load($logo);
//         final tempDir = await getTemporaryDirectory();
//         // final file = File('${tempDir.path}/sharingimages.png');
//         final file = File('${tempDir.path}/$logo');
//         await file.writeAsBytes(byteData.buffer.asUint8List());
//
//         await Share.shareXFiles(
//           [XFile(file.path)],
//           text: fullMessage,
//         );
//       }
//     } catch (error) {
//       logPrint('Error sharing image: $error');
//     }
//   }
  Future<void> shareImage() async {
    try {
      final ShareControllerapi controller = Get.put(ShareControllerapi());
      String logoUrl = controller.shareList[0].logo;         // Image URL or asset name
      String messageText = controller.shareList[0].message;  // Dynamic multiline message
      const link = 'https://dhanmantragame.com/';

      // Prepare the emoji bullet points
      final emojis = ['1️⃣', '2️⃣', '3️⃣', '4️⃣'];
      final messageLines = messageText.split('.');
      final emojiMessage = List.generate(
        messageLines.length,
            (index) => '${emojis[index % emojis.length]} ${messageLines[index]}',
      ).join('\n');

      final fullMessage = '''
$emojiMessage

$link
''';

      if (kIsWeb) {
        // For web, only text + URL can be shared (no file sharing yet)
        logPrint("📤 Sharing on Web:");
        logPrint("🖼️ Logo: $logoUrl");
        logPrint("📄 Message: $fullMessage");

        await Share.share('$logoUrl\n\n$fullMessage');
      } else {
        // For mobile platforms, load image and share with text
        final tempDir = await getTemporaryDirectory();

        // If 'logoUrl' is a network URL, download it
        File imageFile;
        if (logoUrl.startsWith('http')) {
          final response = await http.get(Uri.parse(logoUrl));
          final filePath = '${tempDir.path}/shared_image.jpg';
          imageFile = File(filePath);
          await imageFile.writeAsBytes(response.bodyBytes);
        } else {
          // Otherwise treat it as a local asset path (e.g., assets/images/logo.png)
          final byteData = await rootBundle.load('assets/sharingimages.png');
          final filePath = '${tempDir.path}/shared_image.png';
          imageFile = File(filePath);
          await imageFile.writeAsBytes(byteData.buffer.asUint8List());
        }

        await Share.shareXFiles(
          [XFile(imageFile.path)],
          text: fullMessage,
        );
      }
    } catch (error) {
      logPrint('❌ Error sharing image: $error');
    }
  }

}







