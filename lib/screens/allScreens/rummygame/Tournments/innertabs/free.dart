import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../NewGames/backend/apis/methods.dart';

import '../../../../../main.dart';
import '../../../../../utils/responsvie_web_mobile.dart';

import '../../../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../../../drawer/addmoney/updatebalance.dart';
import '../../../othergames/jodi/tabs.dart';
import '../../Rummybackend/gettournament/GetPrizeModel.dart';
import '../../Rummybackend/gettournament/getprizedistribution.dart';
import '../../Rummybackend/gettournament/tournament_model.dart';
import '../../Rummybackend/insertjoincontestent/balance_fetch_contestent.dart';
import '../../Rummybackend/insertjoincontestent/insertjoincontestent.dart';

class JumboJackpotScreen extends StatelessWidget {
   JumboJackpotScreen({super.key});

  final TournamentModel tournament = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final RegisterController userController = Get.put(RegisterController());
    final TabControllerX controller2 = Get.put(TabControllerX());
    return Scaffold(
      backgroundColor: const Color(0xffeeeff1),
      appBar: AppBar(
        title: Text(tournament.title),
        backgroundColor: Colors.red[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  double balance = (double.tryParse(
                      userController.userProfile.value?.balance.toString() ?? '0.0') ??
                      0.0) +
                      (double.tryParse(
                          userController.userProfile.value?.bonus.toString() ?? '0.0') ??
                          0.0);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.amber, width: 1.5),
                          ),
                          child: Text(
                            "₹${balance.toStringAsFixed(2)}",
                            style: GoogleFonts.baloo2(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );

                }),
                // 🌟 Neumorphic Wrapper
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(
                        ResponsiveHelpers.r(12)),
                  ),
                  child: Column(
                    children: [
                      TournamentCard(tournament: tournament),
                      TournamentBottomCard(tournament: tournament),
                      PrizesAndTicketScreen(),

                    ],
                  ),
                ),
                SizedBox(height: ResponsiveHelpers.h(20)),
              ],
            ),
      )
    );
  }
}

class TournamentCard extends StatelessWidget {
  final TournamentModel tournament;
  const TournamentCard({super.key,required this.tournament});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelpers.r(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top and Side Padding Section (Above Green Line)
          Padding(
            padding: EdgeInsets.only(
              top: ResponsiveHelpers.h(12),
              left: ResponsiveHelpers.w(12),
              right: ResponsiveHelpers.w(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.emoji_events, color: Colors.amber, size: ResponsiveHelpers.w(24)),
                        SizedBox(width: ResponsiveHelpers.w(6)),
                        Text(
                          "${tournament.prizePool} ",
                          style: TextStyle(
                            fontSize: ResponsiveHelpers.sp(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.trending_up, color: Colors.green, size: ResponsiveHelpers.w(18)),
                      ],
                    ),
                    Text(
                      "Entry: ${tournament.entryFee}",
                      style: TextStyle(
                        fontSize: ResponsiveHelpers.sp(14),
                        color: Colors.grey[700],
                      ),
                    )
                  ],
                ),
                SizedBox(height: ResponsiveHelpers.h(4)),
                Text(
                  "First Prize : ${tournament.firstPrizeDescription}",
                  style: TextStyle(
                    fontSize: ResponsiveHelpers.sp(12),
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: ResponsiveHelpers.h(8)),
                Divider(height: 1, color: Colors.grey.shade300),
                SizedBox(height: ResponsiveHelpers.h(10)),
                Row(
                  children: [
                    _prizeItem("Prize Distribution", "₹1.20 Lakh + 72 ⚡"),
                  ],
                ),
                SizedBox(height: ResponsiveHelpers.h(8)),
              ],
            ),
          ),

          // ✅ Green Progress Bar (No Padding Needed)
          LinearProgressIndicator(
            value: 56060 / 95000,
            minHeight: ResponsiveHelpers.h(6),
            color: Colors.green,
            backgroundColor: Colors.grey[300],
            borderRadius: BorderRadius.circular(50),
          ),

          // 🟡 Yellow Section (No Padding Touchup)
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9E5),
               borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(ResponsiveHelpers.r(10)),
              bottomRight: Radius.circular(ResponsiveHelpers.r(10)),
            ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ],
            ),

            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelpers.w(12),
              vertical: ResponsiveHelpers.h(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomItem("Winners", tournament.totalWinners, Colors.green),
                _bottomItem("Seats", "${tournament.joinedSeats}/${tournament.totalSeats}", Colors.black),
                _bottomItem("Format", "Points", Colors.black),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Tournament Starts in",
                      style: TextStyle(
                        fontSize: ResponsiveHelpers.sp(10),
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      tournament.startTime,
                      style: TextStyle(
                        fontSize: ResponsiveHelpers.sp(16),
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _prizeItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveHelpers.sp(8),
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: ResponsiveHelpers.h(4)),
        Text(
          value,
          style: TextStyle(
            fontSize: ResponsiveHelpers.sp(13),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _bottomItem(String title, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveHelpers.sp(8),
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: ResponsiveHelpers.h(2)),
        Text(
          value,
          style: TextStyle(
            fontSize: ResponsiveHelpers.sp(10),
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
final ContestentWalletCotroller walletController = Get.put(ContestentWalletCotroller());

class TournamentBottomCard extends StatelessWidget {
  final TournamentModel tournament;
  const TournamentBottomCard({super.key,required this.tournament});

  void _showInsufficientBalanceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1D1D1D),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 60),
              const SizedBox(height: 16),
              const Text("Insufficient Balance", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 12),
              const Text("You don't have enough balance to place this bet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // close the dialog
                  Get.to(() => UpdatebalanceScreens()); // navigate to new screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1D1D1D),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.greenAccent, size: 60),
              const SizedBox(height: 16),
              const Text("Success", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 12),
              const Text("Your have been successfully Join!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("OK", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitJoin(BuildContext context, int totalAmount) async {
    final InsertJoinContestent controller = Get.put(InsertJoinContestent());
    String? phone = await RegistrationController.getPhoneNumber();

    if (phone == null || phone.isEmpty) {
      Get.snackbar("Error", "Phone number not found.");
      return;
    }
    await walletController.fetchBalance(phone);
    final RegisterController userController = Get.put(RegisterController());

    final double currentBalance = (double.tryParse(
        userController.userProfile.value?.balance.toString() ?? '0.0') ??
        0.0) +
        (double.tryParse(
            userController.userProfile.value?.bonus.toString() ?? '0.0') ??
            0.0);

    controller.isLoading.value = true;
    const String token = "BETLAJDNDNDBARKXTER";

    if(currentBalance<totalAmount){
      _showInsufficientBalanceDialog(context);
      return;
    }
    
    try {
      await controller.InsertJoinContest(
        token: token,
        TournamentId: tournament.tournamentID,
        title: tournament.title,
        StartTime: tournament.startTime,
        Entryfee: tournament.entryFee,
        Prizepool: tournament.prizePool,
        TotalSeats: tournament.totalSeats,
        JoinedSeats: tournament.joinedSeats,
        DurationInMinute: tournament.durationInMins,
        TotalWinner: tournament.totalWinners,
        FirstPrizeDescription: tournament.firstPrizeDescription,
        Phone: phone,
      );
      logPrint("Successfully joined");
      await AppServices.updateWalletBalance("", totalAmount.toString(), 'SUB');
      controller.isLoading.value = false;
      _showSuccessDialog(context);
    } catch (e) {
      logPrint('❌ Failed to join: $e');
    } finally {
      controller.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int totalAmount = int.tryParse(tournament.prizePool) ?? 0;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(ResponsiveHelpers.r(12)),
          bottomRight: Radius.circular(ResponsiveHelpers.r(12)),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(ResponsiveHelpers.r(12)),
          bottomRight: Radius.circular(ResponsiveHelpers.r(12)),
        ),
        child: Column(
          children: [
            SizedBox(width:380),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelpers.r(16),
                vertical: ResponsiveHelpers.r(14),
              ),
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: ResponsiveHelpers.r(25),
                    runSpacing: ResponsiveHelpers.r(5),
                    children: [
                      _buildItem(Icons.access_time, 'Estimated Duration',tournament.durationInMins),
                      _buildItem(Icons.currency_rupee, 'Rebuy', 'Available'),
                      _buildItem(Icons.stacked_line_chart, 'Starting Chips Stack', '1200'),
                      _buildItem(Icons.trending_up, 'Extra Prize Pool', '2% of Total Rebuy', valueColor: Colors.red),
                    ],
                  ),
                  SizedBox(height: ResponsiveHelpers.r(16)),

                  // Join Now button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:()=> _submitJoin(context,totalAmount),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveHelpers.r(14),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ResponsiveHelpers.r(8)),
                        ),
                      ),
                      child: Text(
                        'Join Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveHelpers.r(16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: ResponsiveHelpers.r(10)),

                  // Winnings info
                  Text(
                    "Winnings will be transferred to deposit balance",
                    style: TextStyle(
                      fontSize: ResponsiveHelpers.r(12),
                      color: Colors.grey.shade700,
                    ),
                  ),

                  SizedBox(height: ResponsiveHelpers.r(8)),

                  // Registration End Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today_outlined, size: ResponsiveHelpers.r(14), color: Colors.grey),
                      SizedBox(width: ResponsiveHelpers.r(6)),
                      Text(
                        "Registration Ends: ",
                        style: TextStyle(
                          fontSize: ResponsiveHelpers.r(12),
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Text(
                        "04:29 PM, Today",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveHelpers.r(12),
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildItem(IconData icon, String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: ResponsiveHelpers.r(28), // Fixed width to align text start
          child: Icon(icon, size: ResponsiveHelpers.r(18), color: Colors.grey.shade700),
        ),
        SizedBox(width: ResponsiveHelpers.r(4)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: ResponsiveHelpers.r(11),
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveHelpers.r(12),
                color: valueColor ?? Colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }}


class PrizesAndTicketScreen extends StatelessWidget {
  const PrizesAndTicketScreen({super.key});

  Widget _buildPrizeRow(
      String rank,
      String amount,
      String note,
      IconData icon,
      Color color,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelpers.h(6),
        horizontal: ResponsiveHelpers.w(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            radius: ResponsiveHelpers.r(20),
            child: Icon(
              icon,
              size: ResponsiveHelpers.r(20),
              color: color,
            ),
          ),
          SizedBox(width: ResponsiveHelpers.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rank,
                  style: TextStyle(
                    fontSize: ResponsiveHelpers.r(14),
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                if (note.isNotEmpty)
                  Text(
                    note,
                    style: TextStyle(
                      fontSize: ResponsiveHelpers.r(12),
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: ResponsiveHelpers.r(14),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPrizeCard() {
    return FutureBuilder<List<PrizeDistributionModel>>(
      future: GetPrizeDistribuition.fetchprizedistribution(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("❌ Error loading prizes: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No prize data available."));
        }

        final getprizes = snapshot.data!;

        return Container(
          margin: EdgeInsets.all(ResponsiveHelpers.r(12)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ResponsiveHelpers.r(12)),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelpers.w(12),
                  vertical: ResponsiveHelpers.h(8),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ResponsiveHelpers.r(12)),
                    topRight: Radius.circular(ResponsiveHelpers.r(12)),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.emoji_events, color: Colors.orange),
                    SizedBox(width: ResponsiveHelpers.w(8)),
                    Text(
                      "Prizes (${getprizes.length})",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveHelpers.r(14),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),

              // Column Headings
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelpers.w(12),
                  vertical: ResponsiveHelpers.h(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Rank", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Prizes", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Divider(),

              // Dynamic prize list
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ResponsiveHelpers.w(12)),
                child: Column(
                  children: getprizes.map((prize) {
                    final rank = (prize.rank).trim();

                    IconData icon = Icons.emoji_events_outlined;
                    Color color = Colors.blueGrey;


                    return _buildPrizeRow(
                      rank,
                      "₹${prize.amount}",
                      "", // No `note` in your model
                      icon,
                      color,
                    );
                  }).toList(),
                ),
              ),

              Divider(),
              Padding(
                padding: EdgeInsets.only(bottom: ResponsiveHelpers.h(12)),
                child: Text(
                  "More",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // 👈 Key part for auto height
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPrizeCard(),
        SizedBox(height: ResponsiveHelpers.h(12)),
      ],
    );
  }
}
