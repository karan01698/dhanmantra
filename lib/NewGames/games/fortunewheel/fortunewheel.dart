import 'dart:math';
import 'package:sattagames/NewGames//games/fortunewheel/test.dart';
import 'package:sattagames/NewGames/games/fortunewheel/wheel/wheel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../../main.dart';
import '../../../screens/drawer/addmoney/updatebalance.dart';
import '../../backend/apis/methods.dart';
import '../../backend/models/userbalance.dart';
import '../color-pred/bottomsheet.dart';
import '../color-pred/color_pred.dart';
import 'coinsselector.dart';
import 'lastresults.dart';

List<String> fortuneWheelBets = [];

class Fortunewheel extends StatefulWidget {
  final String email;

  const Fortunewheel({super.key, required this.email});

  @override
  _FortunewheelState createState() => _FortunewheelState();
}

class _FortunewheelState extends State<Fortunewheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final bool _isHelpVisible = false;

  int selectedCoinAmount = 10;

  // Lists to store positions and paths for coins
  final List<Offset> _coinPositionsBlue = [];
  final List<String> _coinPathsBlue = [];
  final List<Offset> _coinPositionsRed = [];
  final List<String> _coinPathsRed = [];
  final List<Offset> _coinPositionsYellow = [];
  final List<String> _coinPathsYellow = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    // Initialize coin positions and paths
    _generateCoinData();
  }

  // Method to generate coin positions and paths only once
  void _generateCoinData() {
    for (int i = 0; i < 25; i++) {
      _coinPositionsBlue.add(Offset(Random().nextDouble() * 150, i.toDouble()));
      _coinPathsBlue.add(coinPaths[Random().nextInt(coinPaths.length)]);
    }

    for (int i = 0; i < 5; i++) {
      _coinPositionsRed.add(Offset(Random().nextDouble() * 150, i.toDouble()));
      _coinPathsRed.add(coinPaths[Random().nextInt(coinPaths.length)]);
    }

    for (int i = 0; i < 30; i++) {
      _coinPositionsYellow.add(
        Offset(Random().nextDouble() * 150, i.toDouble()),
      );
      _coinPathsYellow.add(coinPaths[Random().nextInt(coinPaths.length)]);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/svg/arrow-left.svg",
                color: kGoldenColor,
              ),
            ),
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  "images/fortune-wheel/title.png",
                  height: 20,
                  color: kGoldenColor,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.help, color: kGoldenColor, size: 28),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const RuleWidget();
                  },
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Divider(color: Color(0xffe9d270), thickness: 2), // Red divider
                const FortuneWheelWidget(),
                const SizedBox(height: 8),

                GradientBorderContainer(),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildCoinContainer(
                          "blue",
                          _coinPositionsBlue,
                          _coinPathsBlue,
                        ),
                      ),
                      Expanded(
                        child: _buildCoinContainer(
                          "red",
                          _coinPositionsRed,
                          _coinPathsRed,
                        ),
                      ),
                      Expanded(
                        child: _buildCoinContainer(
                          "yellow",
                          _coinPositionsYellow,
                          _coinPathsYellow,
                        ),
                      ),
                    ],
                  ),
                ),
                const BalanceWidget(),
                CoinSelection(
                  onCoinSelected: (amount) {
                    setState(() {
                      selectedCoinAmount = amount;
                    });
                    if (kDebugMode) {
                      logPrint("Selected Coin Amount: $amount");
                    }
                  },
                ),
                const SizedBox(height: 2),
              ],
            ),
            if (_isHelpVisible) const RuleWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildCoinContainer(
    String color,
    List<Offset> positions,
    List<String> paths,
  ) {
    return InkWell(
      onTap: () async {
        final wallet = await AppServices.getWallet();
        final currentBalance = num.parse(wallet[0].balance);

        if (currentBalance >= selectedCoinAmount) {
          final updatedBalance =  selectedCoinAmount;
          await AppServices.updateWalletBalance(
            widget.email,
            updatedBalance.toString(), "SUB",
          );
          await AppServices.insertWheelBet(
            context,
            roundId: TimerUtils.getCompletionTimeForWheel(20),
            color: color,
            amount: selectedCoinAmount.toString(),
            xValue: color == "red" ? '9' : '2',
          );
          String? phone = await RegistrationController
              .getPhoneNumber();
          final UpdaBalanceControllersss datecontroller =
          Get.put(UpdaBalanceControllersss());
          datecontroller.setCurrentDate();
          final controller = Get.put(InsertBetController());
          await controller.insertBet(
            token: "ADFHNSAMALOUAAKL",
            date: datecontroller.selectedDate.value, // dynamic date
            gamename: "Wheel",
            phone: phone!, // pass this from parent or user state
            amount: selectedCoinAmount.toString(),
            winloose: '', bet: '', type: '',
          );
          fortuneWheelBets.add(color);

          // Show Dialog instead of Toast
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Bet Placed"),
                content: Text("Bet Placed Successfully on $color"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        } else {
          // Show Insufficient Balance Dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Insufficient Balance"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/fortune-wheel/$color.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Stack(
            children: List.generate(positions.length, (index) {
              return Coin(
                top: positions[index].dy,
                left: positions[index].dx,
                coinPath: paths[index],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({super.key});

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  Stream<List<UserBalance>> walletStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 2));
      final chatMessages = await AppServices.getWallet();
      yield chatMessages;
    }
  }

  @override
  Widget build(BuildContext context) {
    final RegisterController userController = Get.put(RegisterController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30),
        ),
        child: StreamBuilder(
          stream: walletStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              // Ensure data is not null and list is not empty
              return SizedBox(
                // width: 150,x/
                child: Text(
                  // '₹${num.parse(snapshot.data![0].balance).toStringAsFixed(2)}',
                  "र${(double.tryParse(userController.userProfile.value?.balance.toString() ?? '0.0') ?? 0.0) + (double.tryParse(userController.userProfile.value?.bonus.toString() ?? '0.0') ?? 0.0)}",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              );
            }

            // Returning a default value when there's no data
            return SizedBox(
              // width: 150,
              child: Text(
                '₹0',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RuleWidget extends StatelessWidget {
  const RuleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0D3770), Color(0xFF3075C0)],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.shade800, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'RULE',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Divider(color: Colors.blueAccent, thickness: 2),
              const SizedBox(height: 8),
              const Text(
                '1. Players can select the color of the turntable.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                '2. Winnings',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                '- Blue and yellow winning odds are 2x. For ₹100 play amount win ₹200.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                '- Red winning odds 9x. For ₹100 play amount win ₹900.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                '3. Playing amount ₹10 to ₹1,00,000',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                        context); // This will close the dialog or screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const CustomButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomButtonClipper(),
      child: Material(
        color: Colors.orange.shade600,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

class CustomButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double radius = 35.0; // Radius for the rounded corners
    final double pentagonRadius =
        36.0; // Adjust this value for the pentagon size

    // Calculate center and angles for the pentagon
    final double cx = size.width / 3;
    final double cy = size.height / 3;
    final double angle = 2 * pi / 5;

    // Define the pentagon points
    List<Offset> pentagonPoints = List.generate(5, (i) {
      final double x = cx + pentagonRadius * cos(i * angle - pi / 3);
      final double y = cy + pentagonRadius * sin(i * angle - pi / 3);
      return Offset(x, y);
    });

    // Move to the top-left corner and draw the rounded corner
    path.moveTo(radius, 6);
    path.arcToPoint(
      Offset(6, radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // Draw the left side of the pentagon
    /* path.lineTo(pentagonPoints[3].dx, pentagonPoints[3].dy);
    path.lineTo(pentagonPoints[4].dx, pentagonPoints[2].dy);
*/ // Draw the bottom side of the pentagon
    path.lineTo(pentagonPoints[2].dx, pentagonPoints[3].dy);
    path.lineTo(pentagonPoints[4].dx, pentagonPoints[1].dy);

    // Draw the right side of the pentagon and the rounded corner
    path.lineTo(size.width - radius, size.height);
    path.arcToPoint(
      Offset(size.width, size.height - radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // Close the path by connecting to the starting point
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
