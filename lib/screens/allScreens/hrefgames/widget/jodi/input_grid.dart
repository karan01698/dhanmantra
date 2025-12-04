import 'package:flutter/material.dart';
import 'input_widget.dart';

class InputGrid extends StatelessWidget {
  final List<TextEditingController> controllers;

  const InputGrid({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // Important!
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 100,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final number = (index + 1).toString().padLeft(2, '0');
        return GameInputBox(
          label: number,
          controller: controllers[index],
        );
      },
    );
  }
}
