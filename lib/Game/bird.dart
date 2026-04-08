// ignore_for_file: deprecated_member_use

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Bird extends PositionComponent {
  double velocity = 0;
  final double gravity = 500;

  @override
  Future<void> onLoad() async {
    size = Vector2(50, 50);
    position = Vector2(40, 200);
  }

  @override
  void update(double dt) {
    velocity += gravity * dt;
    position.y += velocity * dt;
  }

  // @override
  // void render(Canvas canvas) {
  //   final paint = Paint()..color = Colors.yellow;
  //   canvas.drawRect(size.toRect(), paint);
  // }

  void jump() {
    velocity = -250;
  }

  Rect getRect() {
    return Rect.fromLTWH(
      absolutePosition.x + 4,
      absolutePosition.y,
      size.x - 8,
      size.y,
    );
  }

  void reset() {
    position = Vector2(40, 200);
    velocity = 0;
  }

  @override
  void render(Canvas canvas) {
    canvas.save();

    // Keep your transform + rotation
    canvas.translate(size.x / 2, size.y / 2);
    canvas.rotate(angle);

    final rect = Rect.fromCenter(
      center: Offset(0, 0),
      width: size.x,
      height: size.y,
    );

    // Shadow
    final shadowPaint = Paint()..color = Colors.black.withOpacity(0.2);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.shift(const Offset(2, 3)),
        const Radius.circular(10),
      ),
      shadowPaint,
    );

    // Wings (behind body)
    final wingPaint = Paint()..color = const Color(0xFFFFA000);

    // Left wing
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(-18, 0), width: 20, height: 12),
      wingPaint,
    );

    // Right wing
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(18, 0), width: 20, height: 12),
      wingPaint,
    );

    // Body gradient
    final bodyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFEB3B), Color(0xFFFFC107)],
      ).createShader(rect);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(10)),
      bodyPaint,
    );

    // Border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.orange.withOpacity(0.7);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(10)),
      borderPaint,
    );

    // Eye
    final eyeWhite = Paint()..color = Colors.white;
    final pupil = Paint()..color = Colors.black;

    canvas.drawCircle(const Offset(8, -5), 4, eyeWhite);
    canvas.drawCircle(const Offset(9, -5), 2, pupil);

    canvas.restore();
  }

  // @override
  // void render(Canvas canvas) {
  //   final paint = Paint()..color = Colors.yellow;

  //   canvas.save();

  //   canvas.translate(size.x / 2, size.y / 2);
  //   canvas.rotate(angle);

  //   canvas.drawRect(
  //     Rect.fromCenter(center: Offset(0, 0), width: size.x, height: size.y),
  //     paint,
  //   );

  //   canvas.restore();
  // }
}
