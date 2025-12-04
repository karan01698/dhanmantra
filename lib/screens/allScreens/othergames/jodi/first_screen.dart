import 'package:flutter/material.dart';

import 'package:sattagames/screens/allScreens/othergames/jodi/selected_tableItem.dart';


class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String selectedTab = "Jodi";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SelectableTabItem(
          title: "Jodi",
          isSelected: selectedTab == "Jodi",
          onTap: () => setState(() => selectedTab = "Jodi"),
        ),
        SelectableTabItem(
          title: "Crossing",
          isSelected: selectedTab == "Crossing",
          onTap: () => setState(() => selectedTab = "Crossing"),
        ),
        SelectableTabItem(
          title: "Haruf",
          isSelected: selectedTab == "Haruf",
          onTap: () => setState(() => selectedTab = "Haruf"),
        ),
      ],
    );
  }
}