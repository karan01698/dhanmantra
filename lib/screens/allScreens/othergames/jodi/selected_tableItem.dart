import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';

class SelectableTabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableTabItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final RegisterController userController = Get.put(RegisterController());
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(colors: [Color(0xFFFFF3B0), Color(0xFFFFC940)])
              : null,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [


            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                decoration: isSelected ? TextDecoration.none : TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
