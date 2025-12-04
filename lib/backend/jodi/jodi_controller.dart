import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class JodiController extends GetxController {
  final isLoading = false.obs;

  Future<void> insertJodi({
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
      logPrint('✅ API Sent for $betNumber = $amount → ${response.statusCode}');
    } catch (e) {
      logPrint('❌ Error for $betNumber = $amount → $e');
    }
  }
}
