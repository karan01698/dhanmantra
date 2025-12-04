import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../screens/drawer/addmoney/updatebalance.dart';
import '../../../widgets/primaryButton.dart';
import '../../backend/apis/methods.dart';
import '../color-pred/bottomsheet.dart';
import '../fortunewheel/fortunewheel.dart';
import '../fortunewheel/lastresults.dart';

import '../roulette2/roulette/home/roulette/text.dart';
import 'cell.dart';
import 'field.dart';

class MinesGameScreen extends StatefulWidget {
  final int min;
  final int max;
  final String email;
  const MinesGameScreen(
      {super.key, required this.email, required this.min, required this.max});

  @override
  _MinesGameScreenState createState() => _MinesGameScreenState();
}

class _MinesGameScreenState extends State<MinesGameScreen> {
  final int rows = 5;
  final int columns = 5;
  late int numDiamonds;
  int numBombs = 5;
  late List<List<Cell>> board;
  bool gameOver = false;
  int diamondsFound = 0;
  Timer? autoBetTimer;
  final TextEditingController _betController =
  TextEditingController(text: "10.0");
  bool isCashOutAvailable = false;
  bool isBetActive = false;
  late int guaranteedDiamonds;
  int openedCells = 0;

  @override
  void initState() {
    super.initState();
    Random random = Random();
    guaranteedDiamonds =
        widget.min + random.nextInt(widget.max - widget.min + 1);
    _initializeBoard();
  }

  void _initializeBoard() {
    setState(() {
      numDiamonds = rows * columns - numBombs;
      board =
          List.generate(rows, (row) => List.generate(columns, (col) => Cell()));
      openedCells = 0;
      diamondsFound = 0;
      isCashOutAvailable = false;
      isBetActive = false;
      autoBetTimer?.cancel();
      gameOver = false;
    });
  }

  void _resetGame() {
    setState(() {
      _initializeBoard();
      gameOver = false;
      isBetActive = false;
      isCashOutAvailable = false;
    });
  }

  void _initializeBoardWithRandomPlacement() {
    int placedBombs = 0;
    int placedDiamonds = 0;
    Random random = Random();

    // Clear the board first
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        board[i][j].isBomb = false;
        board[i][j].isDiamond = false;
        board[i][j].isRevealed = false;
      }
    }

    // Place bombs randomly
    while (placedBombs < numBombs) {
      int row = random.nextInt(rows);
      int col = random.nextInt(columns);
      if (!board[row][col].isBomb) {
        board[row][col].isBomb = true;
        placedBombs++;
      }
    }

    // Fill remaining cells with diamonds
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        if (!board[i][j].isBomb) {
          board[i][j].isDiamond = true;
          placedDiamonds++;
        }
      }
    }
    numDiamonds = placedDiamonds;
  }

  void _revealCell(int row, int col) {
    if (board[row][col].isRevealed || gameOver || !isCashOutAvailable) return;

    setState(() {
      openedCells++;

      if (numBombs < 20) {
        if (openedCells <= guaranteedDiamonds) {
          board[row][col].isBomb = false;
          board[row][col].isDiamond = true;
        } else if (openedCells == guaranteedDiamonds + 1) {
          board[row][col].isBomb = true;
          board[row][col].isDiamond = false;
        }
      }

      board[row][col].isRevealed = true;

      if (board[row][col].isBomb) {
        gameOver = true;
        isCashOutAvailable = false;
        isBetActive = false;
        autoBetTimer?.cancel();
        _showGameOverDialog('Game Over! You clicked on a bomb.');
      } else if (board[row][col].isDiamond) {
        diamondsFound++;
        if (diamondsFound == numDiamonds) {
          gameOver = true;
          isBetActive = false;
          _showGameOverDialog('Congratulations! You found all diamonds!');
        }
      }
    });
  }

  void startAutoBet() {
    if (!isBetActive || gameOver) return;

    autoBetTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (gameOver) {
        timer.cancel();
        return;
      }
      _autoClick();
    });
  }

  void _autoClick() {
    if (!isBetActive || gameOver) return;

    Random random = Random();
    int row, col;
    do {
      row = random.nextInt(rows);
      col = random.nextInt(columns);
    } while (board[row][col].isRevealed);

    _revealCell(row, col);
  }

  void _handleBetOrCashOut() async {
    if (isCashOutAvailable) {
      // Cash-out logic
      double cashOutAmount =
      _calculateCashOutAmount(rows * columns, diamondsFound, numBombs);
      autoBetTimer?.cancel();
      final balance = await AppServices.getWallet();

      _showGameOverDialog(
          'You cashed out ₹${cashOutAmount.toStringAsFixed(2)}!',
          showGif: false);
      AppServices.updateWalletBalance(widget.email,
          ( cashOutAmount).toString(),"ADD");
      Fluttertoast.showToast(msg: "Cashed Out Successfully");
      _resetGame();
    } else {
      // Bet placement logic
      final wallet = await AppServices.getWallet();
      final currentBalance = num.parse(wallet[0].balance);
      final betAmount = num.parse(_betController.text);
      final controller = Get.put(InsertBetController());
      String? phone = await RegistrationController
          .getPhoneNumber();
      // ✅ Call your GET API using GetX controller
      final UpdaBalanceControllersss datecontroller =
      Get.put(UpdaBalanceControllersss());
      datecontroller.setCurrentDate();
      await controller.insertBet(
        token: "ADFHNSAMALOUAAKL",
        date: datecontroller.selectedDate.value, // dynamic date
        gamename: "Mines",
        phone: phone!, // pass this from parent or user state
        amount: num.parse(_betController.text).toString(),
        winloose: "", bet: '', type: '',
      );

      if (betAmount < 10) {
        Fluttertoast.showToast(msg: "Minimum bet amount is 10");
        return;
      }

      if (currentBalance >= betAmount) {
        await AppServices.updateWalletBalance(
            widget.email, ( betAmount).toString(),"SUB");
        setState(() {
          isCashOutAvailable = true;
          isBetActive = true;
        });
        Fluttertoast.showToast(msg: "Bet Placed");

        if (numBombs >= 20) {
          _initializeBoardWithRandomPlacement();
        }
      } else {
        Fluttertoast.showToast(msg: "Insufficient Balance");
      }
    }
  }

  double _calculateCashOutAmount(int totalTiles, int openedTiles, int mines) {
    double baseBet = double.tryParse(_betController.text) ?? 0.0;
    if (openedTiles == 0) return baseBet;
    double mineFactor = mines / (totalTiles / openedTiles);
    return baseBet * mineFactor;
  }

  void _showGameOverDialog(String message, {bool showGif = true}) async {
    if (showGif) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Image.network(
            "https://img.clipart-library.com/2/clip-transparent-explosion-gif/clip-transparent-explosion-gif-11.gif"),
      );
    }
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _resetGame();
    });
    if (showGif) {
      Navigator.pop(context);
    }
  }

  void _updateNumBombs(double value) {
    if (!isBetActive) {
      setState(() {
        numBombs = value.toInt();
        _initializeBoard();
      });
    }
  }

  @override
  void dispose() {
    autoBetTimer?.cancel();
    _betController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'Mines Game',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: MinesGrid(
                    rows: rows,
                    columns: columns,
                    board: board,
                    onCellTap: _revealCell,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text: "Your Bet",
                size: 18,
                weight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 8),
            RoundedDarkTextField(
              hintText: "Bet Amount",
              controller: _betController,
              enabled: !isBetActive,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text: "Select Number Of Mines: $numBombs",
                size: 18,
                weight: FontWeight.normal,
              ),
            ),
            Slider(
              activeColor: kGoldenColor,
              value: numBombs.toDouble(),
              min: 4,
              max: 24,
              divisions: rows * columns,
              onChanged: isBetActive ? null : _updateNumBombs,
            ),
            const SizedBox(height: 16),
            const Center(child: BalanceWidget()),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: primaryButton(
                context: context,
                text: isCashOutAvailable
                    ? "Cash Out (₹${_calculateCashOutAmount(25, diamondsFound, numBombs).toStringAsFixed(2)})"
                    : "Bet",
                textStyle: TextStyle(color: Colors.black),
                onTap: _handleBetOrCashOut,
                bgColor: isCashOutAvailable
                    ? Colors.red.shade800
                    : kGoldenColor,
              ),
            ),
            const SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: primaryButton(
            //     context: context,
            //     text: "Auto Bet",
            //     textStyle: TextStyle(color: Colors.black),
            //     onTap: _startAutoBet,
            //     bgColor: Colors.blue.shade800,
            //   ),
            // ),
            // const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class MinesGrid extends StatelessWidget {
  final int rows;
  final int columns;
  final List<List<Cell>> board;
  final void Function(int, int) onCellTap;

  const MinesGrid({
    super.key,
    required this.rows,
    required this.columns,
    required this.board,
    required this.onCellTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
      ),
      itemCount: rows * columns,
      itemBuilder: (context, index) {
        int row = index ~/ columns;
        int col = index % columns;
        return GestureDetector(
          onTap: () => onCellTap(row, col),
          child: MinesCell(
            onTap: () {
              onCellTap(row, col);
            },
            cell: board[row][col],
          ),
        );
      },
    );
  }
}

class Cell {
  bool isBomb = false;
  bool isDiamond = false;
  bool isRevealed = false;
}