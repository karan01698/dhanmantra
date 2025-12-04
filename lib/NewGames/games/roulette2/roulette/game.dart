import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "images/1bg.png",
            ),
            fit: BoxFit.fill),
      ),
      child: Center(
        child: Image.asset("images/table1.png"),
      ),
    );
  }
}
