import 'package:flutter/material.dart';

import '../roulette2/roulette/home/roulette/text.dart';


class SelectableItems extends StatefulWidget {
  final Function(int) onSelected; // Callback to notify parent of selection

  const SelectableItems({super.key, required this.onSelected});

  @override
  _SelectableItemsState createState() => _SelectableItemsState();
}

class _SelectableItemsState extends State<SelectableItems> {
  int selectedIndex = 0; // Variable to store selected index

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(3, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index; // Set the selected index
                });
                widget.onSelected(index); // Notify parent about the selection
              },
              child: Container(
                decoration: BoxDecoration(
                  color:
                      selectedIndex == index
                          ? Colors
                              .amber // Amber color for selected item
                          : Colors
                              .transparent, // Transparent for unselected items
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://i.postimg.cc/hG1hkFH6/download-watch.png",
                      height: 40,
                    ),
                    CustomText(
                      text: getTextForIndex(index),
                      align: TextAlign.center,
                      size: 12,
                      color: selectedIndex == index ? Colors.black : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Function to get text for each index
  String getTextForIndex(int index) {
    switch (index) {
      case 0:
        return "WIN GO\n1min";
      case 1:
        return "WIN GO\n5min";
      case 2:
        return "WIN GO\n3min";
      default:
        return "";
    }
  }
}
