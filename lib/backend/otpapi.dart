

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../authenticationsScreens/loginforgotregcontroller.dart';
import '../main.dart';

Future<void> sendSms(String phone, String otp) async {
  RegistrationController controller = Get.put(RegistrationController());
  String apiUrl = "https://dhanmantragame.com/APIs/WebService1.asmx/SendSMS";
  controller.isOtpLoading.value = true;
  logPrint(otp);

  Map<String, String> queryParams = {
   "phone":phone,
    "otp":otp,
  };

  Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Get.snackbar(
        "Success",
        "OTP sent successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP, // Show at the top
        duration: Duration(seconds: 3),
      );
      logPrint("SMS Sent Successfully: ${response.body}");
    } else {
      Get.snackbar(
        "Error",
        "Failed to send OTP. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
      logPrint("Failed to send SMS: ${response.statusCode}");
    }
  } catch (e) {
    Get.snackbar(
      "Error",
      "Unable to send OTP. Check your internet connection.",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
    );
    logPrint("Error: $e");
  }finally {
    controller.isOtpLoading.value = false; // Stop loading
  }
}


// import 'package:http/http.dart' as http;
//
// Future<void> sendSms(String phone, String otp) async {
//   // Proxy backend URL
//   String proxyUrl = "http://localhost:3000/send-sms";
//
//   Map<String, String> queryParams = {
//     'username': 'Duesdemo',
//     'apikey': '56AD4-D6950',
//     'apirequest': 'Text',
//     'sender': 'ROHIPA',
//     'mobile': phone,
//     'message': "Dear Customer, Your OTP is $otp. Regards Rohi",
//     'route': "OTP",
//     'TemplateID': '1707165538475778811',
//     'format': 'JSON',
//   };
//
//   Uri uri = Uri.parse(proxyUrl).replace(queryParameters: queryParams);
//
//   try {
//     final response = await http.get(uri);
//
//     if (response.statusCode == 200) {
//       logPrint("✅ SMS Sent Successfully: ${response.body}");
//     } else {
//       logPrint("❌ Failed to send SMS: ${response.statusCode}");
//     }
//   } catch (e) {
//     logPrint("⚠ Error: $e");
//   }
// }
