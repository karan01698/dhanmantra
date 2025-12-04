import 'package:flutter/material.dart';

class MinesRuleWidget extends StatelessWidget {
  const MinesRuleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Container(
          // height: 550,
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
                "Reveal a Cell:",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                "Click on a cell to reveal it. If it contains a bomb, you lose the game.If it’s safe, the cell will show a number indicating how many bombs are in the adjacent cells (including diagonals).Number Indication:",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'The number on a cell tells how many bombs are around it (0-8).If the revealed cell is a 0, it will automatically reveal all surrounding cells until numbered cells are found.Flagging:',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'You can mark cells you suspect contain bombs by placing a flag on them. Flags are used for tracking potential bomb locations but don\'t prevent accidental clicks.Winning:',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'You win the game when all non-bomb cells are revealed. Losing:',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const Text(
                'You lose instantly if you reveal a cell with a bomb.',
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
