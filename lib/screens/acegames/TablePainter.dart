import 'dart:ui';
import 'package:flutter/material.dart';

class TablePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final tableWidth = size.width * 0.9;
    final tableHeight = size.height * 0.5;
    final tableRect = Rect.fromCenter(center: center, width: tableWidth, height: tableHeight);

    // 🌑 Shadow layer (simulates elevation)
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15);
    canvas.drawOval(tableRect.shift(const Offset(0, 10)), shadowPaint);

    // 🟢 Table fill with gradient
    final tablePaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.green[700]!, Colors.green[900]!],
        center: Alignment.center,
        radius: 0.9,
      ).createShader(tableRect)
      ..style = PaintingStyle.fill;
    canvas.drawOval(tableRect, tablePaint);

    // 🟡 Gradient gold-like border (light and dark yellow)
    final borderGradient = SweepGradient(
      center: FractionalOffset.center,
      colors: [
        Colors.yellow[200]!,
        Colors.amber[600]!,
        Colors.yellow[200]!,
      ],
      tileMode: TileMode.mirror,
    );

    final borderPaint = Paint()
      ..shader = borderGradient.createShader(tableRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;

    canvas.drawOval(tableRect, borderPaint);

    // ✨ Highlight/gloss on top side
    final glossPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.15),
          Colors.transparent,
        ],
      ).createShader(tableRect)
      ..style = PaintingStyle.fill;

    canvas.drawOval(tableRect, glossPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
