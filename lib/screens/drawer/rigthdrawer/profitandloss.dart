import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfitLossController extends GetxController {
  var revenue = 0.0.obs;
  var expense = 0.0.obs;

  double get profitLoss => revenue.value - expense.value;

  void updateRevenue(double value) {
    revenue.value = value;
  }

  void updateExpense(double value) {
    expense.value = value;
  }
}



class ProfitLossScreen extends StatelessWidget {
  final ProfitLossController controller = Get.put(ProfitLossController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Profit & Loss", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 30),

            // Two Cards in One Row
            Obx(() {
              double profitLoss = controller.profitLoss;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Loss Card (Left Side)
                  buildCard(
                    title: "Loss",
                    amount: profitLoss < 0 ? "\$${profitLoss.abs().toStringAsFixed(2)}" : "\$0.00",
                    color: Colors.red,
                  ),
                  // Profit Card (Right Side)
                  buildCard(
                    title: "Profit",
                    amount: profitLoss > 0 ? "\$${profitLoss.toStringAsFixed(2)}" : "\$0.00",
                    color: Colors.green,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  // Input Field Widget
  Widget buildInputField({required String label, required IconData icon, required Function(String) onChanged}) {
    return TextField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[900],
        labelText: label,
        labelStyle: TextStyle(color: Colors.yellow),
        prefixIcon: Icon(icon, color: Colors.yellow),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.yellow),
        ),
      ),
    );
  }

  // Card Widget for Profit & Loss
  Widget buildCard({required String title, required String amount, required Color color}) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
          ),
          SizedBox(height: 10),
          Text(
            amount,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}

