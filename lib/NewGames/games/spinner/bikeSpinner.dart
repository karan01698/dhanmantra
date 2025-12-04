import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sattagames/NewGames//games/spinner/rulesScreen.dart';
import 'dart:math';
import '../fortunewheel/fortunewheel.dart';
import '../fortunewheel/lastresults.dart';
import 'EventDescription.dart';
import 'descriptions.dart';


  class BikeSpinner extends StatefulWidget {
  const BikeSpinner({super.key});

  @override
  State<BikeSpinner> createState() => _BikeSpinnerState();
}

class _BikeSpinnerState extends State<BikeSpinner> {
  final selected = BehaviorSubject<int>();
  String rewardMessage = '';

  void showRewardDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.black,
          title: Text(
            "Congratulations!",
            style: GoogleFonts.baloo2(fontSize: 22, color: Colors.white),
          ),
          content: Text(
            message,
            style: GoogleFonts.baloo2(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK", style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        );
      },
    );
  }

  final List<dynamic> items = [
    Column(
      children: [
        Transform.translate(
          offset: Offset(40, 30), // Move image 10 pixels to the right
          child: Transform.rotate(
            angle: pi / 2, // Rotate 45 degrees
            child: ClipOval(
              child: Image.asset(
                'images/Royale.png',
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(2, 5), // Move image 10 pixels to the right
          child: Transform.rotate(
            angle: pi / 2, // Rotate 45 degrees
            child: Text("I Phone", style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    ),
    Row(
      children: [
        const SizedBox(width: 45),
        Transform.rotate(
          angle: 0.15, // Angle in radians (e.g., 0.5 rad ≈ 28.65 degrees)
          child: Text(
            "Good Luck",
            style: GoogleFonts.baloo2(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        // ClipOval(
        //   child: Image.asset(
        //     'images/coin1.png',
        //     height: 60,
        //     width: 60,
        //     fit: BoxFit.cover,
        //   ),
        // ),
      ],
    ),
    Column(
      children: [
        Transform.translate(
          offset: Offset(40, 30), // Move image 10 pixels to the right
          child: Transform.rotate(
            angle: pi / 2, // Rotate 45 degrees
            child: ClipOval(
              child: Image.asset(
                'images/Royale.png',
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(2, 5), // Move image 10 pixels to the right
          child: Transform.rotate(
            angle: pi / 2, // Rotate 45 degrees
            child: Text("I Phone", style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    ),
    Column(
      children: [
        Transform.translate(
          offset: Offset(40, 30), // Move image 10 pixels to the right
          child: Transform.rotate(
            angle: pi / 2, // Rotate 45 degrees
            child: ClipOval(
              child: Image.asset(
                'images/Royale.png',
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(2, 5), // Move image 10 pixels to the right
          child: Transform.rotate(
            angle: pi / 2, // Rotate 45 degrees
            child: Text("I Phone", style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    ),
    Row(
      children: [
        const SizedBox(width: 45),
        Transform.rotate(
          angle: 0.15, // Angle in radians (e.g., 0.5 rad ≈ 28.65 degrees)
          child: Text(
            "Good Luck",
            style: GoogleFonts.baloo2(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        // ClipOval(
        //   child: Image.asset(
        //     'images/coin1.png',
        //     height: 60,
        //     width: 60,
        //     fit: BoxFit.cover,
        //   ),
        // ),
      ],
    ),
    Column(
      children: [
        Transform.translate(
          offset: Offset(40, 30), // Move image 10 pixels to the right
          child: Transform.rotate(
            angle: pi / 2, // Rotate 45 degrees
            child: ClipOval(
              child: Image.asset(
                'images/Royale.png',
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(2, 5), // Move image 10 pixels to the right
          child: Transform.rotate(
            angle: pi / 2, // Rotate 45 degrees
            child: Text("I Phone", style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    ),
    Column(
      children: [
        Transform.translate(
          offset: Offset(40, 30), // Move image 10 pixels to the right
          child: Transform.rotate(
            angle: pi / 2, // Rotate 45 degrees
            child: ClipOval(
              child: Image.asset(
                'images/Royale.png',
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(2, 5), // Move image 10 pixels to the right
          child: Transform.rotate(
            angle: pi / 2, // Rotate 45 degrees
            child: Text("I Phone", style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    ),
    Row(
      children: [
        const SizedBox(width: 45),
        Transform.rotate(
          angle: 0.15, // Angle in radians (e.g., 0.5 rad ≈ 28.65 degrees)
          child: Text(
            "Good Luck",
            style: GoogleFonts.baloo2(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        // ClipOval(
        //   child: Image.asset(
        //     'images/coin1.png',
        //     height: 60,
        //     width: 60,
        //     fit: BoxFit.cover,
        //   ),
        // ),
      ],
    ),
  ];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  Color _getSegmentColor(int index) {
    final colors = [
      kGoldenColor,
      kGoldenColor,
      kGoldenColor,
      kGoldenColor,
      kGoldenColor,
      kGoldenColor,
      kGoldenColor,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   // White theme
      //   title: Text(
      //     'Wheel Sipn',
      //     style: TextStyle(color: Colors.white), // Black text for contrast
      //   ),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.white), // Back button
      //     onPressed: () {
      //       Navigator.pop(context); // Go back to the previous screen
      //     },
      //   ),
      //   elevation: 0,
      //   // Optional: Remove shadow for a cleaner look
      //   iconTheme: IconThemeData(
      //     color: Colors.white,
      //   ), // Ensure icons match the theme
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 220,
                width: 520,
                alignment: Alignment.center,
                child: Image.asset("images/cricket.jpg"),
              ),
              SizedBox(height: 25),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRechargeCard(),
                  SizedBox(height: 20),
                  _buildSpinsCard(),
                ],
              ),
              // Wheel and Center Image
              Stack(
                alignment: Alignment.center, // Align all children at the center
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(10, 15),
                    // X and Y offsets to shift the image
                    child: ClipOval(
                      child: Image.asset(
                        "images/circlerings.png",
                        height: 380,
                        width: 380,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 292,
                    child: FortuneWheel(
                      selected: selected.stream,
                      animateFirst: false,
                      indicators: [],
                      items: [
                        for (var item in items)
                          FortuneItem(
                            child:
                            item is int
                                ? Text(
                              item.toString(),
                              style: GoogleFonts.baloo2(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            )
                                : item,
                            style: FortuneItemStyle(
                              color: _getSegmentColor(items.indexOf(item)),
                              borderColor: Colors.black,
                              borderWidth: 2,
                            ),
                          ),
                      ],
                      onAnimationEnd: () {
                        setState(() {
                          final selectedIndex = selected.value;
                          final selectedItem = items[selectedIndex];

                          // rewardMessage = "You won ${items[selectedIndex]}!";
                          showRewardDialog(rewardMessage);
                          // if (selectedItem is Column) {
                          //   final columnChildren = selectedItem.children;
                          //   if (columnChildren.isNotEmpty &&
                          //       columnChildren.last is Text) {
                          //     rewardMessage =
                          //         "You just won ${(columnChildren.last as Text).data} Coins!";
                          //   }
                          // } else if (selectedItem is int) {
                          //   rewardMessage =
                          //       "You just won $selectedItem Points!";
                          // } else {
                          //   rewardMessage = "You just won an awesome prize!";
                          // }
                        });
                      },
                    ),
                  ),
                  Positioned(
                    child: ClipOval(
                      child: Image.asset(
                        'images/button.png',
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Spin Button
              GestureDetector(
                onTap: () {
                  selected.add(1);
                },
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade800,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "SPIN",
                      style: GoogleFonts.baloo2(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top Buttons
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EventButton(
                          icon: Icons.description,
                          label: "Event Description",
                          onTap: () {
                            Navigator.push(
                              context, // ✅ Context is now accessible here
                              MaterialPageRoute(
                                builder: (context) => EventDescriptionScreen(),
                              ),
                            );
                          },
                        ),
                        EventButton(
                          icon: Icons.details,
                          label: "Event Details",
                          onTap: () {
                            Navigator.push(
                              context, // ✅ Context is now accessible here
                              MaterialPageRoute(
                                builder: (context) => ActivityDetailsScreen(),
                              ),
                            );
                          },
                        ),
                        EventButton(
                          icon: Icons.rule,
                          label: "Activity Rules",
                          onTap: () {
                            Navigator.push(
                              context, // ✅ Context is now accessible here
                              MaterialPageRoute(
                                builder: (context) => ActivityRulesScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // History Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.history, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          "History",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // History Table
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Spin Time",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Reward Type",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Prize",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // No Data Placeholder
                  Container(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.document_scanner,
                          size: 50,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "No data",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Reward Message
              if (rewardMessage.isNotEmpty)
                Text(
                  rewardMessage,
                  style: GoogleFonts.baloo2(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRechargeCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FF), // Light background
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Recharge",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          BalanceWidget(),
        ],
      ),
    );
  }

  Widget _buildSpinsCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FF), // Light background
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Number of spins",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            "0/3",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class EventButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap; // Corrected type

  EventButton({
    required this.icon,
    required this.label,
    this.onTap,
  }); // Make onTap optional

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.white),
          SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
