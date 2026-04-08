import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Pipe extends PositionComponent {
  bool scored = false;

  Pipe({required Vector2 position, required double height}) {
    this.position = position;
    size = Vector2(60, height);
  }

  @override
  void render(Canvas canvas) {
    final rect = size.toRect();

    // Main pipe gradient
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
      ).createShader(rect);

    // Shadow
    final shadowPaint = Paint()..color = Colors.black.withOpacity(0.2);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.shift(const Offset(2, 4)),
        const Radius.circular(6),
      ),
      shadowPaint,
    );

    // Pipe body
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(6)),
      paint,
    );

    // Pipe cap (top/bottom style illusion)
    final capHeight = 12.0;
    final capRect = Rect.fromLTWH(
      rect.left - 4,
      rect.top - capHeight / 2,
      rect.width + 8,
      capHeight,
    );

    final capPaint = Paint()..color = const Color(0xFF1E8449);

    canvas.drawRRect(
      RRect.fromRectAndRadius(capRect, const Radius.circular(4)),
      capPaint,
    );
  }

  Rect getRect() {
    return Rect.fromLTWH(
      absolutePosition.x,
      absolutePosition.y,
      size.x,
      size.y,
    );
  }
}
