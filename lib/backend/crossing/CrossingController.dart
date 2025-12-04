import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';


class InsertCrossingController extends GetxController {
  final isLoading = false.obs;
  final message = ''.obs;

  Future<void> insertCrossing({
    required String token,
    required String betNumber,
    required String gameName,
    required String amount,
    required String name,
    required String phone,
  }) async {
    final url = Uri.parse("https://dhanmantragame.com/APIs/WebService1.asmx/InsertHaruf");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'token': token,
          'BetNumber': betNumber,
          'gameName' : gameName,
          'Amount': amount,
          'Name': name,
          'Phone': phone,
        },
      );

      logPrint('🔵 [Crossing] Response (${response.statusCode}): ${response.body}');
    } catch (e) {
      logPrint('❌ [Crossing] Exception: $e');
    }
  }
}
