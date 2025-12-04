import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../backend/money_star_apis.dart';
import '../../models/get_transactions.dart';
import '../../text.dart';

class Bottom extends StatelessWidget {
  final String phone;
  const Bottom({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () async {
              MoneyStarMethods moneyStarMethods = MoneyStarMethods();
              final transactions =
                  await moneyStarMethods.getTransactions(phone, "");
              showTransactionsDialog(context, transactions);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow.shade600,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              height: 100,
              width: MediaQuery.of(context).size.width * 0.2,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Icon(
                  //       Icons.star,
                  //       color: Colors.black,
                  //     ),
                  //     SizedBox(
                  //       width: 6,
                  //     ),
                  //     CustomText6(
                  //       text: "TOTAL WINNINGS",
                  //       color: Colors.black,
                  //     ),
                  //     SizedBox(
                  //       width: 6,
                  //     ),
                  //     Icon(
                  //       Icons.star,
                  //       color: Colors.black,
                  //     ),
                  //   ],
                  // ),

                  CustomText6(
                    color: Colors.black,
                    text: "Transaction History",
                    size: 28,
                    weight: FontWeight.w900,
                  ),
                ],
              ),
            ),
          ),
          // color: Colors.white,
        ),

        // TextButton(
        //   onPressed: () {},
        //   child: Container(
        //     color: Colors.yellow.shade600,
        //     child: const Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        //       child: CustomText6(
        //         text: "Transaction History",
        //         color: Colors.black,
        //       ),
        //     ),
        //   ),
        // ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow.shade600,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            height: 100,
            width: MediaQuery.of(context).size.width * 0.2,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    CustomText6(
                      text: "TOTAL WINNINGS",
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.black,
                    ),
                  ],
                ),
                ChangingNumberWidget(),
              ],
            ),
          ),
          // color: Colors.white,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {
              showWithdrawDialoge(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow.shade600,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              height: 100,
              width: MediaQuery.of(context).size.width * 0.2,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomText6(
                    color: Colors.black,
                    text: "Withdrawal",
                    size: 28,
                    weight: FontWeight.w900,
                  ),
                ],
              ),
            ),
          ),
          // color: Colors.white,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {
              showWithdrawDialoge(context, isAddPoints: true);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow.shade600,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              height: 100,
              width: MediaQuery.of(context).size.width * 0.2,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Icon(
                  //       Icons.star,
                  //       color: Colors.black,
                  //     ),
                  //     SizedBox(
                  //       width: 6,
                  //     ),
                  //     CustomText6(
                  //       text: "TOTAL WINNINGS",
                  //       color: Colors.black,
                  //     ),
                  //     SizedBox(
                  //       width: 6,
                  //     ),
                  //     Icon(
                  //       Icons.star,
                  //       color: Colors.black,
                  //     ),
                  //   ],
                  // ),

                  CustomText6(
                    color: Colors.black,
                    text: "Add Points",
                    size: 28,
                    weight: FontWeight.w900,
                  ),
                ],
              ),
            ),
          ),
          // color: Colors.white,
        ),
      ],
    );
  }

  showWithdrawDialoge(BuildContext context, {bool isAddPoints = false}) {
    TextEditingController pointsController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: const RoundedRectangleBorder(),
                content: SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      CustomText6(
                        text: isAddPoints
                            ? "Add Points"
                            : "Add Withdrawal Request",
                        weight: FontWeight.w500,
                      ),
                      const Spacer(),
                      const CustomText6(
                        text: "",
                        weight: FontWeight.w100,
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width * 0.14,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: TextFormField(
                          controller: pointsController,
                          // cursorHeight: 14,
                          cursorColor: Colors.black54,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018),
                          // controller: loginIdController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Enter Points",
                              focusColor: Colors.black,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  gapPadding: 0),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  gapPadding: 0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  gapPadding: 0),
                              fillColor: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          MoneyStarMethods moneyStarMethods =
                              MoneyStarMethods();
                          moneyStarMethods.addTransactions(
                              amount: pointsController.text,
                              status: isAddPoints ? "Add" : "Withdraw",
                              phone: phone);
                          Navigator.pop(context);
                          //  showBankDialoge(context);
                        },
                        child: Container(
                          height: 20,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.grey[900]);
          });
        });
  }

  void showTransactionsDialog(
      BuildContext context, List<GetTransactions> transactions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 600,
          width: 400,
          child: Dialog(
            backgroundColor: Colors.black,
            child: Container(
              height: 600,
              width: 400,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[900],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Transactions',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Divider(
                    color: Colors.grey,
                    height: 1.0,
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: 400.0, // Adjust height as needed
                    child: ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (BuildContext context, int index) {
                        GetTransactions transaction = transactions[index];
                        return Card(
                          elevation: 2.0,
                          color: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Transaction ID: ${transaction.tid}',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Amount: ${transaction.amount}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Date: ${transaction.date}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Status: ${transaction.status}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // FlatButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: Text(
                  //     'Close',
                  //     style: TextStyle(
                  //       fontSize: 18.0,
                  //       color: Colors.blue,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChangingNumberWidget extends StatefulWidget {
  const ChangingNumberWidget({super.key});

  @override
  _ChangingNumberWidgetState createState() => _ChangingNumberWidgetState();
}

class _ChangingNumberWidgetState extends State<ChangingNumberWidget> {
  late Timer _timer;
  String _randomNumber = "100865";

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _startTimer();
  }

  @override
  void dispose() {
    // Dispose of the timer when the widget is removed from the tree
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Create a timer that updates the number every second
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      // Generate a random number in the range 1000000 to 2000000
      setState(() {
        _randomNumber = (1000000 + Random().nextInt(1000000)).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomText6(
      color: Colors.black,
      text: _randomNumber, // Display the generated random number
      size: 28,
      weight: FontWeight.w900,
    );
  }
}
