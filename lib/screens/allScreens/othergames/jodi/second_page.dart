import 'package:flutter/material.dart';


import 'input_widget.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final List<TextEditingController> controllers = List.generate(
    30,
        (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Optional: Some header or title here
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Enter Values",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            // 👇 This Expanded widget allows GridView to take the remaining space
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 30,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                    childAspectRatio: 4/7,
                  ),
                  itemBuilder: (context, index) {
                    final number = (index + 1).toString().padLeft(2, '0');
                    return GameInputBox(
                      label: number,
                      controller: controllers[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
