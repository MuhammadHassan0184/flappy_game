import 'dart:math';
import 'package:flame/components.dart';
import 'pipe.dart';

class PipePair extends PositionComponent {
  final double gap = 150;
  final double speed = 200;

  late Pipe topPipe;
  late Pipe bottomPipe;

  PipePair({required Vector2 position, required double screenHeight}) {
    this.position = position;

    double gapY = Random().nextDouble() * (screenHeight - gap - 200) + 100;

    topPipe = Pipe(
      position: Vector2(0, gapY - 200),
      height: 200,
    );

    bottomPipe = Pipe(
      position: Vector2(0, gapY + gap),
      height: 200,
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