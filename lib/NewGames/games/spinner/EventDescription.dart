import 'package:flutter/material.dart';

class EventDescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Matches the background color
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Event Description",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRedBanner("Activity time", "From now on"),
              SizedBox(height: 10),
              buildRedBanner("Validity period", "Official website notification shall prevail"),
              SizedBox(height: 10),
              buildWhiteCard(
                "Members whose single deposit amount or accumulated deposit amount reaches the set amount can participate in the lottery.",
              ),
              SizedBox(height: 10),
              buildRedBanner("Conditions of participation", ""),
              SizedBox(height: 10),
              buildWhiteCard(
                "Members who meet the requirements of Vip0, Vip1, Vip2, Vip3, Vip4, Vip5, Vip6, Vip7, Vip8, Vip9, Vip10 can participate in the bigwheel event. Need to bind a bank card.\n\n"
                    "Hundreds of millions of cash and many other prizes are up for grabs. Get ready for endless surprises and grand prizes every day!\n\n"
                    "Need to bind Bank account\n\n"
                    "With hundreds of millions in cash and many other prizes up for grabs, get ready for endless surprises and big prizes every day!",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRedBanner(String title, String subtitle) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.play_arrow, color: Colors.black),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (subtitle.isNotEmpty) ...[
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildWhiteCard(String text) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }
}

