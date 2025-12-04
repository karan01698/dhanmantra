import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sattagames/widgets/reusable_button.dart';
import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../constants/colors.dart';

class BetHistory {
  final int id;
  final String date;
  final String gameName;
  final String phone;
  final String amount;
  final String winloose;
  final String bet;
  final String type;

  BetHistory({
    required this.id,
    required this.date,
    required this.gameName,
    required this.phone,
    required this.amount,
    required this.bet,
    required this.winloose,
    required this.type,
  });

  factory BetHistory.fromJson(Map<String, dynamic> json) {
    return BetHistory(
      id: json['id'],
      date: json['Date'] ?? '',
      gameName: json['Gamename'] ?? '',
      phone: json['Phone'] ?? '',
      amount: json['amount'] ?? '',
      winloose: json['winloose'] ?? '',
      bet: json['Bet'] ?? '',
      type: json['Type'] ?? '',
    );
  }
}

class BetHistoryController extends GetxController {
  final colorPredictions = <BetHistory>[].obs;
  final sattaMatka = <BetHistory>[].obs;
  final rummy = <BetHistory>[].obs;
  final teenPatti = <BetHistory>[].obs;

  @override
  void onInit() {
    fetchBetHistories();
    super.onInit();
  }

  void fetchBetHistories() async {
    try {
      String? phone = await RegistrationController.getPhoneNumber();
      final response = await http.get(Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/ShowBetHistories?token=ADFHNSAMALOUAAKL&phone=$phone",
      ));

      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        final List<BetHistory> allBets =
        jsonData.map((e) => BetHistory.fromJson(e)).toList();

        colorPredictions.clear();
        sattaMatka.clear();
        rummy.clear();
        teenPatti.clear();

        for (var bet in allBets) {
          final name = bet.gameName.toLowerCase();
          if (name.contains("color")) {
            colorPredictions.add(bet);
          } else if (name.contains("matka")) {
            sattaMatka.add(bet);
          } else if (name.contains("rummy")) {
            rummy.add(bet);
          } else if (name.contains("teen")) {
            teenPatti.add(bet);
          }
        }
      }
    } catch (e) {
      // handle error
    }
  }
}

class BettHistoryScreen extends StatefulWidget {
  @override
  State<BettHistoryScreen> createState() => _BettHistoryScreenState();
}

class _BettHistoryScreenState extends State<BettHistoryScreen> {
  final controller = Get.put(BetHistoryController());
  final selectedTabIndex = 0.obs;
  final tabNames = ['Color Predictions', 'Satta Matka', 'Rummy', 'TeenPatti'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Bet History",
          style: GoogleFonts.baloo2(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.getotp,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Obx(
                  () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: List.generate(tabNames.length, (index) {
                    bool isSelected = selectedTabIndex.value == index;
                    return _buildActionButton(
                      text: tabNames[index],
                      onPressed: () => selectedTabIndex.value = index,
                      backgroundColor: isSelected
                          ? Colors.yellow.withOpacity(0.3)
                          : Colors.transparent,
                      textColor: Colors.white,
                      borderColor: Colors.amber,
                      width: 140,
                      height: 35,
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                switch (selectedTabIndex.value) {
                  case 0:
                    return _buildList(controller.colorPredictions);
                  case 1:
                    return _buildList(controller.sattaMatka);
                  case 2:
                    return _buildList(controller.rummy);
                  case 3:
                    return _buildList(controller.teenPatti);
                  default:
                    return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<BetHistory> list) {
    if (list.isEmpty) {
      return Center(
        child: Text("No Bet History Found", style: TextStyle(color: Colors.white)),
      );
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final bet = list[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.yellow.shade600, width: 1.5),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.yellow.withOpacity(0.2),
            //     offset: Offset(0, 4),
            //     blurRadius: 8,
            //   ),
            // ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(Icons.videogame_asset_rounded, "Game: ${bet.gameName}"),
              SizedBox(height: 10),
              _buildInfoRow(Icons.date_range_rounded, "Date: ${bet.date}"),
              SizedBox(height: 10),
              _buildInfoRow(Icons.attach_money, "Amount: ₹${bet.amount}"),
              SizedBox(height: 10),
              _buildInfoRow(Icons.confirmation_num, "Bet on: ${bet.bet}"),
              if (!bet.gameName.toLowerCase().contains("color")) ...[
                SizedBox(height: 10),
                _buildInfoRow(Icons.play_arrow, "Type: ${bet.type}"),
              ],
              SizedBox(height: 10),
              _buildInfoRow(Icons.info_outline, "Status: ${bet.winloose}"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.yellow.shade700, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.yellow.shade700,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    IconData? icon,
    Color? borderColor,
    double? width,
    double? height,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ReusableButton(
        text: text,
        isShimmer: true,
        shimmerDuration: const Duration(seconds: 3),
        onPressed: onPressed,
        width: width ?? 100,
        height: height ?? 30,
        borderRadius: 20,
        fontSize: 15,
        backgroundColor: backgroundColor,
        textColor: textColor,
        borderColor: borderColor ?? Colors.amber,
        borderWidth: 1.5,
        icon: icon,
      ),
    );
  }
}
