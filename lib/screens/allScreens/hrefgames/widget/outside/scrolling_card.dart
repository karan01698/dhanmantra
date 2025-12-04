import 'package:flutter/material.dart';

class GameCardSc extends StatelessWidget {
  final String title;
  final String timing;
  final String imagePath; // Path to your asset image (hexagonal)
  final VoidCallback? onPlayPressed;

  const GameCardSc({
    super.key,
    required this.title,
    required this.timing,
    required this.imagePath,
    this.onPlayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF1e1e1e),
          border: Border.all(color: Colors.grey.shade600),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Left hexagonal image
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Center title and timing
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Play Timing $timing',
                    style: const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Right play button
            InkWell(
              onTap: onPlayPressed,
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.play_arrow, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
