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
    final paint = Paint()..color = Colors.yellow;

    canvas.save();

    canvas.translate(size.x / 2, size.y / 2);
    canvas.rotate(angle);

    canvas.drawRect(
      Rect.fromCenter(center: Offset(0, 0), width: size.x, height: size.y),
      paint,
    );

    canvas.restore();
  }
  //  @override
  // void render(Canvas canvas) {
  //   final paint = Paint()..color = Colors.yellow;
  //   canvas.drawRect(size.toRect(), paint); // ✅ correct
  // }

  // @override
  // void render(Canvas canvas) {
  //   final paint = Paint()..color = Colors.yellow;

  //   canvas.save();

  //   final angle = (velocity / 500).clamp(-1.0, 1.0);

  //   // ✅ USE absolutePosition (VERY IMPORTANT)
  //   canvas.translate(
  //     absolutePosition.x + size.x / 2,
  //     absolutePosition.y + size.y / 2,
  //   );

  //   canvas.rotate(angle);

  //   canvas.drawRect(
  //     Rect.fromCenter(center: Offset(0, 0), width: size.x, height: size.y),
  //     paint,
  //   );

  //   canvas.restore();
  // }
}
