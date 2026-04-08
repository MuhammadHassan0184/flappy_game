import 'dart:async';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'bird.dart';
import 'game_over_menu.dart';
import 'pipe.dart';
import 'pipe_pair.dart';

// ignore: deprecated_member_use
class MyGame extends FlameGame with TapDetector {
  late Bird bird;
  late Timer pipeTimer;
  late TextComponent scoreText;

  bool isGameOver = false;
  int score = 0;

  double difficulty = 0;

  MyGame() {
    overlays.addEntry('gameOver', (context, game) => GameOverMenu(game: this));
  }

  @override
  Future<void> onLoad() async {
    bird = Bird();
    add(bird);

    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(20, 20),
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
    add(scoreText);

    pipeTimer = Timer(2, repeat: true, onTick: spawnPipe);
    pipeTimer.start();
  }

  void spawnPipe() {
    // add(PipePair(position: Vector2(size.x, 0), screenHeight: size.y));
    add(PipePair(
  position: Vector2(size.x, 0),
  screenHeight: size.y,
  difficulty: difficulty,
));
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isGameOver) {
      pipeTimer.update(dt);
    difficulty += dt * 3; // increases slowly

      final birdRect = bird.getRect();

      for (final component in children) {
        if (component is PipePair) {
          for (final child in component.children) {
            if (child is Pipe) {
              final pipeRect = child.getRect();

              if (birdRect.overlaps(pipeRect)) {
                gameOver();
                return;
              }

              if (!child.scored && pipeRect.right < birdRect.left) {
                child.scored = true;
                addScore();
              }
            }
          }
        }
      }
    }

    scoreText.text = 'Score: $score';
  }

  void addScore() {
    score++;
  }

  void gameOver() {
    isGameOver = true;
    pipeTimer.stop();
    pauseEngine();

    overlays.add('gameOver');
  }

  @override
  void onTap() {
    if (isGameOver) {
      restartGame();
    } else {
      bird.jump();
    }
  }

  void restartGame() {
    isGameOver = false;
    score = 0;

    bird.reset();

    children.whereType<PipePair>().toList().forEach((pair) {
      pair.removeFromParent();
    });

    resumeEngine();

    overlays.remove('gameOver');

    pipeTimer.stop();
    pipeTimer = Timer(2, repeat: true, onTick: spawnPipe);
    pipeTimer.start();
  }

  @override
  Color backgroundColor() => Colors.blue;
}
