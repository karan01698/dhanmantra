import 'package:sattagames/NewGames/games/color-pred/tab.dart';
import 'package:sattagames/NewGames/games/color-pred/timer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../backend/apis/methods.dart';
import '../../backend/models/user.dart';
import '../../backend/models/userbalance.dart';
import 'bottomsheet.dart';
import 'package:intl/intl.dart';
import 'historytab.dart';
import 'item.dart';

class TimerUtils {
  static int calculateRemainingTime(durationInSeconds) {
    final now = DateTime.now();

    // Get the total number of seconds passed since the start of the hour
    final totalSecondsPassed = now.minute * 60 + now.second;

    // Calculate how many seconds have passed in the current lap
    final secondsPassedInCurrentLap = totalSecondsPassed % durationInSeconds;

    // Calculate the remaining time by subtracting from the total duration
    return durationInSeconds - secondsPassedInCurrentLap;
  }

  // Method to calculate the completion time as a formatted string
  static String getCompletionTime(int durationInSeconds) {
    final now = DateTime.now(); // Current time
    final completionTime = now.add(
      Duration(seconds: calculateRemainingTime(durationInSeconds)),
    ); // Add remaining time
    final DateFormat formatter = DateFormat(
      'yyyy-MM-dd HH:mm',
    ); // Exclude seconds and milliseconds
    return formatter.format(completionTime);
  }

  static String getCompletionTimeForWheel(int durationInSeconds) {
    final now = DateTime.now(); // Current time
    final completionTime = now.add(
      Duration(seconds: calculateRemainingTime(durationInSeconds)),
    ); // Add remaining time
    final DateFormat formatter = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ); // Exclude seconds and milliseconds
    return formatter.format(completionTime);
  }
}

class ColorPrediction extends StatefulWidget {
  // final User user;
  final UserBalance userBalance;

  @override
  const ColorPrediction({
    super.key,
    // required this.user,
    required this.userBalance,
  });

  State<ColorPrediction> createState() => _ColorPredictionState();
}

class _ColorPredictionState extends State<ColorPrediction> {
  late Future<List<int>> futureListInt;
  late Stream<List<int>> resultStream;
  String type = '1min';

  Stream<List<int>> fetchResultsStream() async* {
    while (true) {
      await Future.delayed(Duration.zero); // Simulating data update
      yield await AppServices.getPredResult(getTextForIndex());
    }
  }

  void placeBet(String label, String type) async {
    final balance = await AppServices.getWallet();
    final mobile = await AppServices.getMobile();
    showBettingBottomSheet(
      context,
      TimerUtils.getCompletionTime(getDurationInSeconds()),
      label,
      type,
      getTextForIndex(),
      num.parse(balance[0].balance).toInt(),
      mobile,
    );

  }

  int getDurationInSeconds() {
    switch (selectedValue) {
      case 0:
        return 60; // 30 seconds
      case 1:
        return 5 * 60; // 5 minutes in seconds
      case 2:
        return 3 * 60; // 3 minutes in seconds
      case 3:
        return 1 * 60; // 1 minute in seconds
      default:
        return 30; // Default to 30 seconds if something unexpected happens
    }
  }

  String getTextForIndex() {
    switch (selectedValue) {
      case 0:
        return "1min";
      case 1:
        return "5min";
      case 2:
        return "3min";
      default:
        return "";
    }
  }

  int selectedValue = 0;
  final List<Color> colors = [
    Colors.green.shade700,
    Colors.red,
    Colors.green.shade700,
    Colors.red,
    Colors.green.shade700,
    Colors.red,
    Colors.green.shade700,
    Colors.red,
    Colors.green.shade700,
    Colors.deepOrange.shade700,
  ];

  Stream<List<UserBalance>> walletStream() async* {
    while (true) {
      await Future.delayed(Duration.zero);
      final chatMessages = await AppServices.getWallet();

      yield chatMessages;
    }
  }

  @override
  void initState() {
    futureListInt = AppServices.getPredResult(getTextForIndex());
    resultStream = fetchResultsStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RegisterController userController = Get.put(RegisterController());
    return Scaffold(
      backgroundColor: const 	Color(0xFF000000),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF000000),
        title: Text(
          'DHANMANTRA',
          style: GoogleFonts.poppins(fontSize: 24, color: Colors.yellow),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wallet Balance Section
              Material(
                elevation: 6, // Adjust for more/less shadow
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700).withOpacity(0.2), // Light transparent gold
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFFD700), // Golden border
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wallet balance',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      StreamBuilder(
                        stream: walletStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              // '₹${num.parse(snapshot.data![0].balance).toStringAsFixed(2)}',
                              "र${(double.tryParse(userController.userProfile.value?.balance.toString() ?? '0.0') ?? 0.0) + (double.tryParse(userController.userProfile.value?.bonus.toString() ?? '0.0') ?? 0.0)}",
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                            );
                          }
                          return Text(
                            '₹${widget.userBalance.balance}',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ), // Rounded corners for the dialog
                                      ),
                                      backgroundColor: Colors.white,
                                      // White background for the dialog body
                                      titlePadding: EdgeInsets.zero,
                                      // Remove default title padding to customize title bar
                                      title: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: const BoxDecoration(
                                          color:
                                              Colors
                                                  .amber, // Color for the title bar
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(
                                              20.0,
                                            ), // Rounded corners for the top of the dialog
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'How to Play',
                                            style: TextStyle(
                                              color:
                                                  Colors
                                                      .white, // Title text color
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      content: const SizedBox(
                                        height: 300,
                                        child: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text(
                                                '1. 1 minute 1 issue: 45 seconds to order, 15 seconds waiting for the draw. It opens all day. The total number of trades is 1440 issues.',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                '2. If you spend 100 to trade, after deducting a 2 service fee, your contract amount is 98:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                '   - Select green: If the result shows 1, 3, 7, 9 you will get (98 * 2) = 196; If the result shows 5, you will get (98 * 1.5) = 147.',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                '   - Select red: If the result shows 2, 4, 6, 8 you will get (98 * 2) = 196; If the result shows 0, you will get (98 * 1.5) = 147.',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                '   - Select violet: If the result shows 0 or 5, you will get (98 * 4.5) = 441.',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                '   - Select number: If the result is the same as the number you selected, you will get (98 * 9) = 882.',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                '   - Select big: If the result shows 5, 6, 7, 8, 9, you will get (98 * 2) = 196.',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                '   - Select small: If the result shows 0, 1, 2, 3, 4, you will get (98 * 2) = 196.',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Container(
                                          width:
                                              double
                                                  .infinity, // Full-width button
                                          margin: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ), // Add margin to bottom
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                          ),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.amber,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      30.0,
                                                    ), // Rounded corners
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Close',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ), // Button text color
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'How To Play?',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SelectableItems(
                onSelected: (index) {
                  setState(() {
                    type = "${index + 1}min";
                    selectedValue =
                        index; // Update selected value when notified
                  });
                },
              ),
              const SizedBox(height: 20),

              // How to Play Section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFFFD700), // Golden border
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Results',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            StreamBuilder<List<int>>(
                              stream: fetchResultsStream(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(child: Container());
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text('No data available'),
                                  );
                                } else {
                                  final numbers =
                                      snapshot.data!.reversed.toList();
                                  final limitedNumbers =
                                      numbers.length >= 5
                                          ? numbers
                                              .skip(numbers.length - 5)
                                              .toList()
                                          : numbers.toList();

                                  return Row(
                                    children:
                                        limitedNumbers.map((number) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8.0,
                                            ),
                                            child: buildNumberCircle2(
                                              number,
                                              context,
                                              isSmall: true,
                                            ),
                                          );
                                        }).toList(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        TimerWidget(
                          onTimerComplete: () async {
                            final completionTime = TimerUtils.getCompletionTime(
                              getDurationInSeconds(),
                            );
                            final textIndex = getTextForIndex();

                            await AppServices.declareColorPredResult(
                              completionTime,
                              textIndex,
                            );

                            // The stream will automatically update, no need for setState.
                          },
                          key: UniqueKey(),
                          durationInSeconds: getDurationInSeconds(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Color Selection Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildColorButton('Green', Colors.green.shade700, context, 0),
                  buildColorButton('Voilet', Colors.purple, context, 1),
                  buildColorButton('Red', Colors.red, context, 2),
                ],
              ),
              const SizedBox(height: 20),
              // Number Selection Section - First Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return buildNumberCircle(index, context);
                }),
              ),
              const SizedBox(height: 10),
              // Number Selection Section - Second Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return buildNumberCircle(index + 5, context);
                }),
              ),
              // const Spacer(),
              // Bottom Buttons
              SwitchableButtons(
                onBigTap: () {
                  placeBet("Big", "Color");
                },
                onSmallTap: () {
                  placeBet("Small", "Color");
                },
                isBigSelected: true,
              ),

              const SizedBox(height: 20),

              SizedBox(height: 300, child: DamanScreen(type: type)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNumberCircle(
    int index,
    BuildContext context, {
    bool isSmall = false,
  }) {
    // Determine if the number is special (0 or 5) to apply a white gradient
    bool isSpecialNumber = index == 0 || index == 5;

    return GestureDetector(
      onTap: () {
        int remainingTime = TimerUtils.calculateRemainingTime(
          getDurationInSeconds(),
        );

        if (remainingTime > 10) {
          placeBet(index.toString(), "Number");
        } else {
          Fluttertoast.showToast(
            msg: "Betting is disabled in the last 10 seconds!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
      child: Container(
        width: isSmall ? 30 : 60,
        height: isSmall ? 30 : 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors:
                isSpecialNumber
                    ? [colors[index], Colors.purple.shade700]
                    : [colors[index], colors[index].withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: colors[index].withOpacity(0.6),
              offset: const Offset(2, 2),
              blurRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: isSmall ? 20 : 45,
            height: isSmall ? 20 : 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.65),
            ),
            child: Center(
              child: Text(
                '$index',
                style: GoogleFonts.poppins(
                  fontSize: isSmall ? 14 : 24,
                  fontWeight: FontWeight.bold,
                  color: colors[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNumberCircle2(
    int index,
    BuildContext context, {
    bool isSmall = false,
  }) {
    // Determine if the number is special (0 or 5) to apply a white gradient
    bool isSpecialNumber = index == 0 || index == 5;

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: isSmall ? 30 : 60,
        height: isSmall ? 30 : 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors:
                isSpecialNumber
                    ? [colors[index], Colors.purple.shade700]
                    : [colors[index], colors[index].withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: colors[index].withOpacity(0.6),
              offset: const Offset(2, 2),
              blurRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: isSmall ? 20 : 45,
            height: isSmall ? 20 : 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.65),
            ),
            child: Center(
              child: Text(
                '$index',
                style: GoogleFonts.poppins(
                  fontSize: isSmall ? 14 : 24,
                  fontWeight: FontWeight.bold,
                  color: colors[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // placeBet(index.toString(), "Number");
  Widget buildColorButton(
    String label,
    Color color,
    BuildContext context,
    int index,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        // (If using older Flutter versions, else use foregroundColor)
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: () {
        int remainingTime = TimerUtils.calculateRemainingTime(
          getDurationInSeconds(),
        );

        if (remainingTime > 10) {
          placeBet(index.toString(), "Number");
        } else {
          Fluttertoast.showToast(
            msg: "Betting is disabled in the last 10 seconds!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: label == "White" ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

Widget buildBottomButton(String label, BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
    onPressed: () {},
    child: Text(
      label,
      style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
    ),
  );
}

Widget buildBottomTab(String label) {
  return Text(
    label,
    style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[400]),
  );
}
