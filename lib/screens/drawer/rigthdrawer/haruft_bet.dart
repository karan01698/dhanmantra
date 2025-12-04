import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../main.dart';

// MODEL
class BetHistoryModel {
  final int id;
  final String betNumber;
  final String gameName;
  final double amount;
  final String name;
  final String phone;
  final DateTime date;

  BetHistoryModel({
    required this.id,
    required this.betNumber,
    required this.gameName,
    required this.amount,
    required this.name,
    required this.phone,
    required this.date,
  });

  factory BetHistoryModel.fromJson(Map<String, dynamic> json) {
    return BetHistoryModel(
      id: json['ID'],
      betNumber: json['BetNumber'],
      gameName: json['GameName'],
      amount: (json['Amount'] as num).toDouble(),
      name: json['Name'],
      phone: json['Phone'],
      date: DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['Date'].replaceAll(RegExp(r'[^0-9]'), '')),
      ),
    );
  }
}

// CONTROLLER
class HaurfBetHistoryController extends GetxController {
  var betList = <BetHistoryModel>[].obs;
  var isLoading = true.obs;

  final String token = "ADFHNSAMALOUAAKL";


  @override
  void onInit() {
    super.onInit();
    fetchBets();
  }

  void fetchBets() async {
    try {
      String? phone = await RegistrationController
          .getPhoneNumber();
      isLoading(true);
      final response = await http.post(
        Uri.parse(
          'https://dhanmantragame.com/APIs/WebService1.asmx/Showharuf',
        ),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'token=$token&Phone=$phone',
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        betList.value =
            jsonData.map((e) => BetHistoryModel.fromJson(e)).toList();
      } else {
        logPrint("Error: ${response.statusCode}");
      }
    } catch (e) {
      logPrint("Exception: $e");
    } finally {
      isLoading(false);
    }
  }
}

// UI (WITHOUT Scaffold)
class HaurfShowBetHistoryScreen extends StatelessWidget {
  final HaurfBetHistoryController controller =
  Get.put(HaurfBetHistoryController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.betList.isEmpty) {
        return const Center(child: Text("No data found"));
      }

      return ListView.builder(
        itemCount: controller.betList.length,
        itemBuilder: (context, index) {
          final BetHistoryModel item = controller.betList[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Game: ${item.gameName}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Number: ${item.betNumber}"),
                  Text("Amount: ₹${item.amount}"),
                  Text("Name: ${item.name}"),
                  Text("Phone: ${item.phone}"),
                  Text("Date: ${DateFormat('dd-MM-yyyy hh:mm a').format(item.date)}"),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
