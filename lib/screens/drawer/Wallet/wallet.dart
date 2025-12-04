import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';
import 'WidrallScreen.dart';
import 'WithdrawalHistoryScreen.dart';
import 'deposit.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Wallet',
          style: GoogleFonts.baloo2(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.black,
        elevation: 0,
        iconTheme: IconThemeData(
          color: AppColors.white, // Set the back arrow color to white
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: screenHeight * 0.3, // Responsive height
              padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: AppColors.white,
                    size: screenWidth * 0.12, // Responsive size
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '₹0.00',
                    style: GoogleFonts.baloo2(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.09, // Responsive font size
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Total balance',
                    style: GoogleFonts.baloo2(
                      color: AppColors.white,
                      fontSize: screenWidth * 0.04, // Responsive font size
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     _buildStatColumn('0', 'Total amount', screenWidth),
                  //     _buildStatColumn(
                  //       '0',
                  //       'Total deposit amount',
                  //       screenWidth,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       _buildWalletTile('Main wallet', '₹0.00', screenWidth),
            //       _buildWalletTile('3rd party wallet', '₹0.00', screenWidth),
            //     ],
            //   ),
            // ),
            // SizedBox(height: screenHeight * 0.01),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppColors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       padding: EdgeInsets.symmetric(
            //         horizontal: screenWidth * 0.1,
            //         vertical: screenHeight * 0.015,
            //       ),
            //     ),
            //     child: Text(
            //       'Main wallet transfer',
            //       style: GoogleFonts.baloo2(
            //         color: AppColors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: screenWidth * 0.045,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Container(
                height: screenHeight * 0.11, // Responsive height
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GridView.count(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  crossAxisCount: 3,
                  mainAxisSpacing: screenHeight * 0.02,
                  crossAxisSpacing: 0,
                  children: [
                    _buildIconTile(Icons.download, 'Deposit', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const DepositScreen(), // Ensure Login is a widget
                        ),
                      );
                    }),
                    _buildIconTile(Icons.upload, 'Withdraw', () {
                      // Handle Withdraw tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  WithdrawScreen(), // Ensure Login is a widget
                        ),
                      );
                    }),
                    // _buildIconTile(Icons.history, 'Deposit\nHistory', () {
                    //   Get.to(DepositHistoryScreen());
                    // Handle Deposit History tap
                    // }),
                    _buildIconTile(Icons.history_toggle_off, 'History', () {
                      // Handle Withdrawal History tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  WithdrawalHistoryScreen(), // Ensure Login is a widget
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.22),
            Center(
              child: Text(
                "Unique game Unique Choices",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20, //
                  fontWeight: FontWeight.bold, // Increased font size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletTile(String title, String amount, double screenWidth) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.white,
          radius: screenWidth * 0.1,
          child: Text(
            '0%',
            style: GoogleFonts.baloo2(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04,
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          title,
          style: GoogleFonts.baloo2(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
          ),
        ),
        Text(amount),
      ],
    );
  }

  Widget _buildStatColumn(String value, String label, double screenWidth) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.baloo2(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.baloo2(
            color: AppColors.white,
            fontSize: screenWidth * 0.035,
          ),
        ),
      ],
    );
  }

  Widget _buildIconTile(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 13),
          CircleAvatar(
            backgroundColor: AppColors.white,
            child: Icon(icon, color: AppColors.black),
          ),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.baloo2(color: AppColors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
