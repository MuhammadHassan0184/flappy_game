import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Bird extends PositionComponent {
  double velocity = 0;
  final double gravity = 500;

  @override
  Future<void> onLoad() async {
    size = Vector2(50, 50);
    position = Vector2(100, 200);
  }

  @override
  void update(double dt) {
    velocity += gravity * dt;
    position.y += velocity * dt;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.yellow;
    canvas.drawRect(size.toRect(), paint);
  }

  void jump() {
    velocity = -250;
  }

  Rect getRect() {
    return Rect.fromLTWH(
      absolutePosition.x,
      absolutePosition.y,
      size.x,
      size.y,
    );
  }

  void reset() {
    position = Vector2(100, 200);
    velocity = 0;
  }
}