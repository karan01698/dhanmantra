import 'package:flutter/material.dart';

import 'package:sattagames/screens/allScreens/hrefgames/pages/haruf/first_page.dart';
import 'package:sattagames/screens/allScreens/hrefgames/pages/haruf/second_page.dart';

class HarufCombinePage extends StatefulWidget {
  final String gameName;
  const HarufCombinePage({super.key, required this.gameName});

  @override
  State<HarufCombinePage> createState() => _HarufCombinePageState();
}

class _HarufCombinePageState extends State<HarufCombinePage> {
  Map<String, String> _inputData = {};

  void _updateInputData(Map<String, String> newData) {
    setState(() {
      _inputData = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GameInputWidget(
                onChanged: _updateInputData,
              ),
              const SizedBox(height: 20),
             GameSummaryWidget(
               inputs: _inputData,
               gameName: widget.gameName,
             ),
            ],
          ),
        ),
      ),
    );
  }

}
