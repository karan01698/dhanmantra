import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DepositHistoryScreen extends StatelessWidget {
  // Dummy data for deposit history
  final List<Map<String, String>> depositHistory = [
    {
      "date": "2025-01-15",
      "amount": "\$500.00",
      "status": "Completed",
    },
    {
      "date": "2025-01-10",
      "amount": "\$200.00",
      "status": "Pending",
    },
    {
      "date": "2025-01-05",
      "amount": "\$350.00",
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set AppBar background color here
      appBar: AppBar(
        title: Text(
          'Deposit History',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.black, // Set AppBar background color here
        iconTheme: IconThemeData(
          color: Colors.white, // Set icon color to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: depositHistory.length,
          itemBuilder: (context, index) {
            final deposit = depositHistory[index];
            return Card(
              elevation: 2,
              color: Colors.grey[600],
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: ListTile(
                leading: Icon(
                  deposit["status"] == "Completed"
                      ? Icons.check_circle
                      : Icons.access_time,
                  color: deposit["status"] == "Completed"
                      ? Colors.green
                      : Colors.orange,
                ),
                title: Text(
                  "Amount: ${deposit["amount"]}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Date: ${deposit["date"]}"),
                trailing: Text(
                  deposit["status"]!,
                  style: TextStyle(
                    color: deposit["status"] == "Completed"
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
