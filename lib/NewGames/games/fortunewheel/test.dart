import 'package:flutter/material.dart';

final List<String> coinPaths = [
  'images/fortune-wheel/coins/10.png',
  'images/fortune-wheel/coins/50.png',
  'images/fortune-wheel/coins/100.png',
  'images/fortune-wheel/coins/500.png',
  'images/fortune-wheel/coins/1000.png',
  'images/fortune-wheel/coins/5000.png',
];

class Coin extends StatelessWidget {
  final double top;
  final double left;
  final String coinPath;

  const Coin({
    super.key,
    required this.top,
    required this.left,
    required this.coinPath,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Image.asset(
        coinPath,
        width: 30,
        height: 30,
      ), // Adjust size as needed
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'Your Card',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
