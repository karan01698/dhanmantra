import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:sattagames/screens/allScreens/hrefgames/pages/outside/outside_pages.dart';
import 'package:sattagames/screens/allScreens/hrefgames/pages/outside/outside_sliding.dart';
 // list of game cards

class LiveGameScreen extends StatelessWidget {
  const LiveGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(height: 15),
          const SlidingCardRow(), // Your existing horizontal icon row widget
      

      
          // 🔸 Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Live Game',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),


      Flexible(
        child: ScrollRow(),),
          // 🔹 Vertical Game Cards
      // Your existing vertical list of cards
        ],
      ),
    );
  }
}
