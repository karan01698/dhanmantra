import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../../../backend/crossing/crossing_controller_wallet.dart';

class CrossingFirstPage extends StatefulWidget {
  final TextEditingController firstController;
  final TextEditingController secondController;
  final TextEditingController amountController;
  final VoidCallback onAdd;

  const CrossingFirstPage({
    super.key,
    required this.firstController,
    required this.secondController,
    required this.amountController,
    required this.onAdd,
  });

  @override
  State<CrossingFirstPage> createState() => _CrossingFirstPageState();
}

class _CrossingFirstPageState extends State<CrossingFirstPage> {
  final CrossingControllerWallet crossingControllerWallet = Get.put(CrossingControllerWallet());

  @override
  void initState() {
    super.initState();

    // Fetch balance from phone number
    RegistrationController.getPhoneNumber().then((phone) {
      if (phone != null && phone.isNotEmpty) {
        crossingControllerWallet.fetchBalance(phone);
      }
    });

    // Add listener to firstController after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.firstController.addListener(_syncFirstToSecond);
    });
  }

  // Function to sync text
  void _syncFirstToSecond() {
    final value = widget.firstController.text;
    if (widget.secondController.text != value) {
      widget.secondController.text = value;
    }
  }

  @override
  void dispose() {
    widget.firstController.removeListener(_syncFirstToSecond);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const LabelText(text: 'First Number'),
          InputBox(controller: widget.firstController),
          const SizedBox(height: 15),
          const LabelText(text: 'Second Number'),
          InputBox(controller: widget.secondController, readOnly: true),
          const SizedBox(height: 15),
          const LabelText(text: 'Enter Amount'),
          InputBox(controller: widget.amountController),
          const SizedBox(height: 25),
          GradientButton(
            text: "Add",
            onTap: () {
              FocusScope.of(context).unfocus();
              widget.onAdd();
            },
          ),
        ],
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String text;
  const LabelText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 14),
    );
  }
}

class InputBox extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
  const InputBox({super.key, required this.controller, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GradientButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFF0C2), Color(0xFFFEC84B)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
