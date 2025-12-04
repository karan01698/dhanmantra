import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContestentWalletCotroller extends GetxController {
  var isLoading = false.obs;
  var balance = ''.obs;

  Future<void> fetchBalance(String phone) async {
    isLoading.value = true;
    const url = 'https://dhanmantragame.com/APIs/WebService1.asmx/ShowProfile';
    const token = 'BETLAJDNDNDBARKXTER';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'token': token, 'Phone': phone},
      );

      if (response.statusCode == 200) {
        try {
          // Attempt direct JSON decoding
          final jsonData = jsonDecode(response.body);
          balance.value = jsonData['Balance'] ?? '0';
        } catch (e) {
          // If response is XML, extract JSON string using RegExp
          final match = RegExp(r'\{.*\}').firstMatch(response.body);
          if (match != null) {
            final jsonData = jsonDecode(match.group(0)!);
            balance.value = jsonData['Balance'] ?? '0';
          } else {
            balance.value = '0';
          }
        }
      } else {
        balance.value = '0';
      }
    } catch (e) {
      balance.value = '0';
      Get.snackbar("Error", "Failed to fetch balance: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
