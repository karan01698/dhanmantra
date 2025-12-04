import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WithdrawalHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> transactions = [
    {
      'date': '2025-01-15',
      'amount': '\₹150.00',
      'status': 'Completed',
    },
    {
      'date': '2025-01-10',
      'amount': '\₹200.00',
      'status': 'Pending',
    },
    {
      'date': '2025-01-05',
      'amount': '\₹300.00',
      'status': 'Failed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set AppBar background color here
      appBar: AppBar(
        title: Text(
          'Withdrawal History',
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

      body: transactions.isEmpty
          ? Center(
        child: Text(
          'No transactions found',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            elevation: 3,
            color: Colors.grey[600],
            child: ListTile(
              leading: Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
              ),
              title: Text('Amount: ${transaction['amount']}'),
              subtitle: Text('Date: ${transaction['date']}'),
              trailing: Text(
                transaction['status']!,
                style: TextStyle(
                  color: transaction['status'] == 'Completed'
                      ? Colors.green
                      : transaction['status'] == 'Pending'
                      ? Colors.orange
                      : Colors.red,
                ),
              ),
            ),
          );
        },
      ),

    );
  }
}
