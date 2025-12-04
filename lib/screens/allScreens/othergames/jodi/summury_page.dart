import 'package:flutter/material.dart';
import 'package:sattagames/screens/allScreens/othergames/jodi/summury_card.dart';


class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final TextEditingController jodiController = TextEditingController(text: "0");
  final TextEditingController amountController = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SummaryBox(
              totalJodiController: jodiController,
              totalAmountController: amountController,
            ),
          ),
        ),
      ),
    );
  }
}
