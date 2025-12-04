import 'package:flutter/material.dart';
import 'lastresults.dart';

class CoinSelection extends StatefulWidget {
  final Function(int)
  onCoinSelected; // Callback function to return the selected coin amount

  const CoinSelection({super.key, required this.onCoinSelected}); // Constructor

  @override
  _CoinSelectionState createState() => _CoinSelectionState();
}

class _CoinSelectionState extends State<CoinSelection> {
  int _selectedCoinIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        String imageName;
        int coinAmount;

        switch (index) {
          case 0:
            imageName = "10.png";
            coinAmount = 10;
            break;
          case 1:
            imageName = "50.png";
            coinAmount = 50;
            break;
          case 2:
            imageName = "100.png";
            coinAmount = 100;
            break;
          case 3:
            imageName = "500.png";
            coinAmount = 500;
            break;
          case 4:
            imageName = "1000.png";
            coinAmount = 1000;
            break;
          case 5:
            imageName = "5000.png";
            coinAmount = 5000;
            break;
          default:
            imageName = "10.png";
            coinAmount = 10;
        }

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedCoinIndex = index;
            });
            widget.onCoinSelected(
              coinAmount,
            ); // Call the callback with the selected coin amount
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(_selectedCoinIndex == index ? 8 : 0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    _selectedCoinIndex == index
                        ? kGoldenColor
                        : Colors.transparent,
                width: 3,
              ),
              boxShadow:
                  _selectedCoinIndex == index
                      ? [
                        BoxShadow(
                          color: kGoldenColor.withOpacity(0.7),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ]
                      : [],
            ),
            child: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset("images/fortune-wheel/coins/$imageName"),
            ),
          ),
        );
      }),
    );
  }
}
