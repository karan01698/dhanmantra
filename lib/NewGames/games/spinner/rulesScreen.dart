import 'package:flutter/material.dart';

class ActivityRulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Rules', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildRuleCard(
                '01',
                'The event is effective from now on. The discount can only be used once per address, per email address, per phone number and for the same payment method (debit/credit card/bank account) and IP address.',
                'If a member applies repeatedly, the company reserves the right to cancel or withdraw member bonuses.',
              ),
              _buildRuleCard(
                '02',
                'All offers are specially designed for players.',
                'If any group or individual is found to be dishonestly withdrawing bonuses or threatening or abusing company offers, the company reserves the right to freeze or cancel the account and account balance of that group or individual.',
              ),
              _buildRuleCard(
                '03',
                'The platform reserves the right of final outcome of this event;',
                'and the right to modify or terminate the campaign without prior notice; these terms apply to all offers.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleCard(String number, String title, String description) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(description, style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
