import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ExposureController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateExposure({
    required String token,
    required String phone,
    required String bal,
    required String operation,
  }) async {
    isLoading.value = true;

    final url = Uri.parse('https://dhanmantragame.com/APIs/WebService1.asmx/UpdateExposure');

    final response = await http.post(
      url,
      body: {
        "token": token,
        "Phone": phone,
        "bal": bal,
        "operation": operation,
      },
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = ExposureResponse.fromJson(jsonData);
      // Get.defaultDialog(
      //   title: "Success",
      //   middleText: data.message,
      //   textConfirm: "OK",
      //   onConfirm: () => Get.back(),
      // );
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to update exposure",
        textConfirm: "OK",
        onConfirm: () => Get.back(),
      );
    }
  }
}
class ExposureResponse {
  final String message;

  ExposureResponse({required this.message});

  factory ExposureResponse.fromJson(Map<String, dynamic> json) {
    return ExposureResponse(
      message: json['message'] ?? '',
    );
  }
}
