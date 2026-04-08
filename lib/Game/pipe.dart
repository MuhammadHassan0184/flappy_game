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
    final paint = Paint()..color = Colors.green;
    canvas.drawRect(size.toRect(), paint);
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
