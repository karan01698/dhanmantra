// import 'package:sattagames/backend/authenticanapi/controllerapi/registerapicontroller.dart';
// import 'package:sattagames/backend/sliderapi.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../constants/images.dart';
// import 'autopay.dart';
//
// void main() {
//   runApp(GetMaterialApp(home: PaymentScreen()));
// }
//
// class PaymentController extends GetxController {
//   var selectedIndex = (-1).obs; // Initially, no option is selected
//
//   final List<Map<String, String>> paymentOptions = [
//     {'title': 'UPI', 'image': AppImages.ups, 'details': 'UPI Payment Details'},
//     {'title': 'UPI', 'image': AppImages.ups, 'details': 'Auto Payment'},
//     {'title': 'UPI', 'image': AppImages.ups, 'details': 'Auto Payment'},
//     {'title': 'AUTO PAY', 'image': AppImages.ups, 'details': 'Auto Payment'},
//   ];
//
//   // final List<Map<String, String>> belowpaymentOptions = [
//   //   {'title': 'UPI', 'image': AppImages.qrcode, 'details': 'UPI Payment Details'},
//   //   {'title': 'Auto pay', 'image': AppImages.ups, 'details': 'Auto Payment'},
//   //   {'title': 'Auto pay', 'image': AppImages.ups, 'details': 'Auto Payment'},
//   //   {'title': 'Auto pay', 'image': AppImages.ups, 'details': 'Auto Payment'},
//   // ];
//
//   void updateIndex(int index) {
//     selectedIndex.value = index;
//   }
//
//   void validateAndProceed() {
//     if (selectedIndex.value == -1) {
//       Get.snackbar("Error", "Please select a payment method",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white);
//     } else {
//       Get.snackbar("Success",
//           "Proceeding with ${paymentOptions[selectedIndex.value]['title']}",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white);
//     }
//   }
// }
//
// class PaymentScreen extends StatelessWidget {
//   final PaymentController controller = Get.put(PaymentController());
//   final RegisterController controllerss = Get.put(RegisterController());
//   final UpiController upiController = Get.put(UpiController());
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;
//
//     return SingleChildScrollView(
//       physics: NeverScrollableScrollPhysics(),
//       child: Padding(
//         padding: EdgeInsets.all(5.0),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(12),
//               width: screenWidth,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text("Payment Options",
//                       style:
//                           TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 10),
//                   SizedBox(
//                     height: 90,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: controller.paymentOptions.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () => controller.updateIndex(index),
//                           child: Obx(() => AnimatedContainer(
//                                 duration: Duration(milliseconds: 200),
//                                 margin: EdgeInsets.symmetric(horizontal: 2),
//                                 padding: EdgeInsets.all(12),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(
//                                       color: controller.selectedIndex.value ==
//                                               index
//                                           ? Colors.blue
//                                           : Colors.transparent,
//                                       width: 2),
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [
//                                     if (controller.selectedIndex.value == index)
//                                       BoxShadow(
//                                         color: Colors.blue.withOpacity(0.4),
//                                         blurRadius: 8,
//                                         spreadRadius: 2,
//                                         offset: Offset(0, 4),
//                                       )
//                                   ],
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     AnimatedScale(
//                                       scale: controller.selectedIndex.value ==
//                                               index
//                                           ? 1.1
//                                           : 1.0,
//                                       duration: Duration(milliseconds: 200),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 width: 1, color: Colors.black)),
//                                         child: Image.asset(
//                                           controller.paymentOptions[index]
//                                               ['image']!,
//                                           width: 50,
//                                           height: 30,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Row(
//                                       children: [
//                                         Text(
//                                             controller.paymentOptions[index]
//                                                 ['title']!,
//                                             style: TextStyle(fontSize: 16)),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//
//                                       ],
//                                     ),
//
//                                   ],
//                                 ),
//                               )),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               width: screenWidth,
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
//               ),
//               child: Obx(() {
//                 if (controllerss.qrList.isEmpty) {
//                   return Center(child: Text("No Data Available"));
//                 }
//
//                 if (controller.selectedIndex.value == -1) {
//                   controller.updateIndex(0);
//                 }
//
//                 // ✅ Ensure selectedIndex is within range
//                 final index = controller.selectedIndex.value;
//                 final isValidIndex =
//                     index >= 0 && index < controllerss.qrList.length;
//
//                 // ✅ Use API data if available, otherwise use fallback image
//                 final imageUrl = isValidIndex
//                     ? controllerss.qrList[index].qr1
//                     : AppImages.noDataFound;
//                 final idText = isValidIndex
//                     ? "UPI: ${controllerss.qrList[index].upi}"
//                     : "Invalid Data";
//
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // ✅ Show network image if valid, else show local image
//                     imageUrl.startsWith('http')
//                         ? Image.network(imageUrl,
//                             width: screenWidth * 0.6,
//                             height: screenHeight * 0.3,
//                             fit: BoxFit.cover)
//                         : Image.asset(imageUrl,
//                             width: screenWidth * 0.6,
//                             height: screenHeight * 0.3),
//
//                     SizedBox(height: 20),
//
//                   ],
//                 );
//               }),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:math';

import 'package:sattagames/screens/drawer/addmoney/updatebalance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../backend/shareapi.dart';
import '../../../constants/images.dart';
import '../../../main.dart';
import '../transactionscreen/transcationsscreen.dart';
import 'autopay.dart';
import 'package:sattagames/backend/authenticanapi/controllerapi/registerapicontroller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/images.dart';
import 'autopay.dart';
import 'package:sattagames/backend/authenticanapi/controllerapi/registerapicontroller.dart';


class PaymentController extends GetxController {
  var selectedIndex = (-1).obs; // Initially, no option is selected

  final List<Map<String, String>> paymentOptions = [
    {'title': 'UPI', 'image': AppImages.ups, 'details': 'UPI Payment Details'},

  ];

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  var nameController = TextEditingController();
  var upiController = TextEditingController();
  var amountController = TextEditingController();

  // Generate a unique Transaction ID
  String generateTransactionID() {
    return "TXN${Random().nextInt(1000000)}";
  }

  // Generate a unique Order ID
  String generateOrderID() {
    return "ORDER${Random().nextInt(1000000)}";
  }

  // Function to initiate UPI payment
  void launchUPI() async {
    String name = nameController.text.trim();
    String upiID = upiController.text.trim();
    String amount = amountController.text.trim();

    if ( amount.isEmpty) {
      Get.snackbar("Error", "Please enter all details",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    String transactionID = generateTransactionID();
    String orderID = generateOrderID();

    String upiUri = Uri.encodeFull(
        "upi://pay?pa=$upiID&pn=$name&mc=1234&tid=$transactionID&tr=$orderID&tn=Payment&am=$amount&cu=INR");

    final Uri uri = Uri.parse(upiUri);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar("Error", "No UPI app found!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Show confirmation dialog before launching UPI
  void showPaymentDialog() {
    if (nameController.text.isEmpty ||
        upiController.text.isEmpty ||
        amountController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all details",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Get.defaultDialog(
      title: "Confirm Payment",
      middleText:
      "Do you want to pay ₹${amountController.text} to ${nameController.text}?",
      textConfirm: "Yes",
      textCancel: "No",
      onConfirm: () {
        launchUPI();
        Get.back();
      },
    );
  }
}



class PaymentScreen extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());
  final RegisterController controllerss = Get.put(RegisterController());

  void _openWhatsApp() async {
    try {
      // Place your WhatsApp logic here
    } catch (e) {
      Get.snackbar("Error", "Could not open WhatsApp: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    controller.updateIndex(0); // Auto select UPI

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            // WhatsApp Help Button
            Container(
              padding: EdgeInsets.all(12),
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _openWhatsApp,
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.callIcons),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text('Send Your Payment Slip Screenshot',
                            style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Payment Option",
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                   Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                              child: Image.asset(
                                controller.paymentOptions[0]['image']!,
                                width: 50,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              controller.paymentOptions[0]['title']!,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),

            // Show QR Image from API
            Container(
              width: screenWidth,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Obx(() {
                if (controllerss.qrList.isEmpty) {
                  return Center(child: Text("No QR Data Available"));
                }

                final imageUrl =
                    'https://dhanmantragame.com/Images/${controllerss.qrList[0].qr1}';

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      imageUrl,
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.3,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Text("Image not available"),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}


void _openWhatsApps() async {
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




class HelpButton extends StatefulWidget {
  @override
  _HelpButtonState createState() => _HelpButtonState();
}

class _HelpButtonState extends State<HelpButton> {
  bool _isHovered = false;



  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _openWhatsApps,
            borderRadius: borderRadius,
            splashColor: Colors.greenAccent.withOpacity(0.3),
            hoverColor: Colors.white.withOpacity(0.1),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                border: Border.all(color: Colors.white, width: 1.5),
                borderRadius: borderRadius,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.support_agent, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Need help? Tap here to contact us!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



