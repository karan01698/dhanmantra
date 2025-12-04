import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
// UPIINTENT
void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: UpiPaymentScreen(),
  ));
}

// GetX Controller for managing payment state
class UpiController extends GetxController {
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

    if (name.isEmpty || upiID.isEmpty || amount.isEmpty) {
      Get.snackbar("Error", "Please enter all details", snackPosition: SnackPosition.BOTTOM);
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
      Get.snackbar("Error", "No UPI app found!", snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Show confirmation dialog before launching UPI
  void showPaymentDialog() {
    if (nameController.text.isEmpty || upiController.text.isEmpty || amountController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all details", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Get.defaultDialog(
      title: "Confirm Payment",
      middleText: "Do you want to pay ₹${amountController.text} to ${nameController.text}?",
      textConfirm: "Yes",
      textCancel: "No",
      onConfirm: () {
        launchUPI();
        Get.back();
      },
    );
  }
}

// UI for UPI Payment
class UpiPaymentScreen extends StatelessWidget {
  final UpiController controller = Get.put(UpiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UPI Payment with GetX")),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: "Enter Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.upiController,
              decoration: InputDecoration(labelText: "Enter UPI ID"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.amountController,
              decoration: InputDecoration(labelText: "Enter Amount"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
