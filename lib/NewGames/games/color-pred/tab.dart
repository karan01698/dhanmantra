import 'package:flutter/material.dart';

class SwitchableButtons extends StatelessWidget {
  final VoidCallback onBigTap;
  final VoidCallback onSmallTap;
  final bool isBigSelected;

  const SwitchableButtons({
    super.key,
    required this.onBigTap,
    required this.onSmallTap,
    required this.isBigSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedAlign(
                alignment:
                    isBigSelected
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onBigTap,
                    child: Center(
                      child: Text(
                        'Big',
                        style: TextStyle(
                          color:
                              isBigSelected ? Colors.black : Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onSmallTap,
                    child: Center(
                      child: Text(
                        'Small',
                        style: TextStyle(
                          color:
                              isBigSelected ? Colors.grey[400] : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
