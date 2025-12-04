import 'package:flutter/material.dart';

import '../../text.dart';

class WinningCard extends StatelessWidget {
  const WinningCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  image: DecorationImage(
                    image: AssetImage("images/allin.png"),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.white),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            height: 80,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.01),
                ],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 40,
                    ),

                    const CustomText6(
                      text: "109.2L",
                      weight: FontWeight.w900,
                      size: 20,
                    ),
                    CustomText6(
                      text: "WINNINGS",
                      weight: FontWeight.w900,
                      size: 20,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    // CustomText6(
                    //   text: "UID : 000097359128S",
                    //   weight: FontWeight.w400,
                    //   size: 12,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
