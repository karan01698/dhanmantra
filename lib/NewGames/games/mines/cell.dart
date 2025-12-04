import 'package:flutter/material.dart';
import 'package:sattagames/NewGames/games/mines/mines.dart';
import '../fortunewheel/lastresults.dart';


class MinesCell extends StatefulWidget {
  final Cell cell;
  final VoidCallback onTap;

  const MinesCell({super.key, required this.cell, required this.onTap});

  @override
  _MinesCellState createState() => _MinesCellState();
}

class _MinesCellState extends State<MinesCell>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  // void playSound(String path) async {
  //   await player.setAudioSource(AudioSource.asset(path));
  //   await player.play();
  // }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
    if (widget.cell.isDiamond) {
      // _playSound('images/mines/sounds/diamond.wav');
    } else if (widget.cell.isBomb) {
      // Handle bomb sound if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isClicked = widget.cell.isRevealed;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double scale = 1 - _controller.value * 0.05;
        return Transform.scale(
          scale: scale,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: kGoldenColor,
                borderRadius: BorderRadius.circular(12),
                border: isClicked
                    ? Border.all(color: Colors.grey[300]!, width: 1)
                    : null,
              ),
              child: Center(
                child: widget.cell.isRevealed
                    ? widget.cell.isBomb
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "images/mines/images/bomb.png",
                            ),
                          )
                        : widget.cell.isDiamond
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "images/mines/images/diamond.png",
                                ),
                              )
                            : const Text(
                                'Empty',
                              ) // Should be "Empty" if no bomb/diamond
                    : CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        radius: 8,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    // player.dispose();
    super.dispose();
  }
}
