import 'dart:math';
import 'package:flame/components.dart';
import 'pipe.dart';

class PipePair extends PositionComponent {
  final double gap = 250;
  final double speed = 200;

  late Pipe topPipe;
  late Pipe bottomPipe;

  double moveSpeed = 40;
  double direction = 1;

  final double difficulty;
  

  PipePair({
    required Vector2 position,
    required double screenHeight,
    required this.difficulty,
  }) {
    this.position = position;

    final random = Random();

    int type = random.nextInt(3); // 0,1,2

    if (type == 0) {
      // 🟢 NORMAL (both pipes)
      double gapY = random.nextDouble() * (screenHeight - gap - 100) + 50;

      double topHeight = gapY;
      double bottomHeight = screenHeight - gapY - gap;

      topPipe = Pipe(position: Vector2(0, 0), height: topHeight);

      bottomPipe = Pipe(position: Vector2(0, gapY + gap), height: bottomHeight);

      add(topPipe);
      add(bottomPipe);
    } else if (type == 1) {
      // 🔺 GAP AT TOP (only bottom pipe)
      double height = random.nextDouble() * (screenHeight - 200) + 100;

      bottomPipe = Pipe(
        position: Vector2(0, screenHeight - height),
        height: height,
      );

      add(bottomPipe);
    } else {
      // 🔻 GAP AT BOTTOM (only top pipe)
      double height = random.nextDouble() * (screenHeight - 200) + 100;

      topPipe = Pipe(position: Vector2(0, 0), height: height);

      add(topPipe);
    }
  }

  // PipePair({required Vector2 position, required double screenHeight}) {
  //   this.position = position;

  //   double gapY = Random().nextDouble() * (screenHeight - gap - 100) + 50;

  //   double topHeight = gapY;
  //   double bottomHeight = screenHeight - gapY - gap;

  //   topPipe = Pipe(position: Vector2(0, 0), height: topHeight);

  //   bottomPipe = Pipe(position: Vector2(0, gapY + gap), height: bottomHeight);

  //   add(topPipe);
  //   add(bottomPipe);
  // }
  @override
  void update(double dt) {
    super.update(dt);

    // 👉 Move left
    position.x -= speed * dt;

    // 👉 Swing up & down
    position.y += direction * moveSpeed * dt;

    // Reverse direction (limit movement)
    if (position.y > 40 || position.y < -40) {
      direction *= -1;
    }

    if (position.x < -100) {
      removeFromParent();
    }
  }
  // @override
  // void update(double dt) {
  //   super.update(dt);

  //   // Move whole pair
  //   position.x -= speed * dt;

  //   if (position.x < -100) {
  //     removeFromParent();
  //   }
  // }
}
