import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TablePainter.dart';

class CustomTeenPattiTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 400),
              painter: TablePainter(),
            ),

            // Girl Image in Center
            Positioned(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/girl.png'),
                radius: 40,
              ),
            ),

            // Cards or Players (example)
            Positioned(
              top: 50,
              child: Image.asset('assets/images/card_back.png', width: 50),
            ),
            Positioned(
              left: 50,
              bottom: 50,
              child: Image.asset('assets/images/card_back.png', width: 50),
            ),
            Positioned(
              right: 50,
              bottom: 50,
              child: Image.asset('assets/images/card_back.png', width: 50),
            ),
          ],
        ),
      ),
    );
  }
}
