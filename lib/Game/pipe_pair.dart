import 'dart:math';
import 'package:flame/components.dart';
import 'pipe.dart';

class PipePair extends PositionComponent {
  final double gap = 180;
  final double speed = 200;

  late Pipe topPipe;
  late Pipe bottomPipe;

  PipePair({required Vector2 position, required double screenHeight}) {
  this.position = position;

  double gapY = Random().nextDouble() * (screenHeight - gap - 100) + 50;

  double topHeight = gapY;
  double bottomHeight = screenHeight - gapY - gap;

  topPipe = Pipe(
    position: Vector2(0, 0),
    height: topHeight,
  );

  bottomPipe = Pipe(
    position: Vector2(0, gapY + gap),
    height: bottomHeight,
  );

  add(topPipe);
  add(bottomPipe);
}

  @override
  void update(double dt) {
    super.update(dt);

    // Move whole pair
    position.x -= speed * dt;

    if (position.x < -100) {
      removeFromParent();
    }
  }
}