import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class HarufController extends GetxController {
  final isLoading = false.obs;
  final message = ''.obs;

  Future<void> insertHaruf({
    required String token,
    required String betNumber,
    required String gameName,
    required String amount,
    required String name,
    required String phone,
  }) async {
    final url = Uri.parse(
        'https://dhanmantragame.com/APIs/WebService1.asmx/InsertHaruf');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'token': token,
          'BetNumber': betNumber,
          'gameName' : gameName,
          'Amount': amount,
          'Name': name,
          'Phone': phone,
        },
      );

      if (response.statusCode == 200) {
        logPrint("✅ Success for $betNumber - Amount: $amount");
        logPrint("Response: ${response.body}");
      } else {
        logPrint('❌ Failed for $betNumber - Status: ${response.statusCode}');
      }
    } catch (e) {
      logPrint('❌ Exception while posting $betNumber: $e');
    }
  }
}
