// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bird.dart';
import 'game_over_menu.dart';
import 'pipe.dart';
import 'pipe_pair.dart';

class MyGame extends FlameGame with TapCallbacks {
  late Bird bird;
  late Timer pipeTimer;
  late TextComponent scoreText;

  bool isGameOver = false;
  int score = 0;

  double difficulty = 0;
  int bestScore = 0;
  bool isNewBest = false;

  String getMedal() {
  if (score >= 20) {
    return "gold";
  } else if (score >= 10) {
    return "silver";
  } else if (score >= 5) {
    return "bronze";
  } else {
    return "none";
  }
}

  MyGame() {
    overlays.addEntry('gameOver', (context, game) => GameOverMenu(game: this));
    // overlays.addEntry('home', (context, game) => HomeMenu(game: this));
    // overlays.addEntry('pause', (context, game) => PauseMenu(game: this));
  }

  Future<void> loadBestScore() async {
  final prefs = await SharedPreferences.getInstance();
  bestScore = prefs.getInt('bestScore') ?? 0;
}

  @override
  Future<void> onLoad() async {
    await loadBestScore(); // ✅ load saved score

    bird = Bird();
    add(bird);

    // ⏸️ Pause Button UI
    final pauseButton = TextComponent(
      text: 'II',
      position: Vector2(size.x - 40, 20),
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 28),
      ),
    )..anchor = Anchor.topRight;

    add(pauseButton);

    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(20, 20),
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
    add(scoreText);

    pipeTimer = Timer(2, repeat: true, onTick: spawnPipe);

    // Start from Home screen
    pauseEngine();
    overlays.add('home');
  }

  void spawnPipe() {
    add(
      PipePair(
        position: Vector2(size.x, 0),
        screenHeight: size.y,
        difficulty: difficulty,
      ),
    );
  }

  // ▶️ START GAME
  void startGame() {
    overlays.remove('home');
    resumeEngine();
    pipeTimer.start();
  }

  // ⏸️ PAUSE GAME
  void pauseGame() {
    pauseEngine();
    overlays.add('pause');
  }

  // ▶️ RESUME GAME
  void resumeGame() {
    overlays.remove('pause');
    resumeEngine();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isGameOver) {
      pipeTimer.update(dt);
      difficulty += dt * 3;

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

  void gameOver() async {
  isGameOver = true;
  pipeTimer.stop();
  pauseEngine();

  if (score > bestScore) {
    bestScore = score;
    isNewBest = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bestScore', bestScore);
  } else {
    isNewBest = false;
  }

  overlays.add('gameOver');
}

  // ✅ ✅ SINGLE TAP HANDLER (FIXED)
  @override
  void onTapDown(TapDownEvent event) {
    final pos = event.localPosition;

    // 🚫 Ignore home screen taps
    if (overlays.isActive('home')) return;

    // ⏸️ Pause button click (top-right)
    if (pos.x > size.x - 80 && pos.y < 80) {
      if (!overlays.isActive('pause') && !isGameOver) {
        pauseGame();
      }
      return;
    }

    // ▶️ Resume if paused
    if (overlays.isActive('pause')) {
      resumeGame();
      return;
    }

    // 🔁 Restart if game over
    if (isGameOver) {
      restartGame();
      return;
    }

    // 🐦 Normal jump
    bird.jump();
  }

  void restartGame() {
    overlays.remove('gameOver');
    overlays.remove('pause');

    isGameOver = false;
    score = 0;

    bird.reset();

    children.whereType<PipePair>().toList().forEach((pair) {
      pair.removeFromParent();
    });

    resumeEngine();

    pipeTimer.stop();
    pipeTimer = Timer(2, repeat: true, onTick: spawnPipe);
    pipeTimer.start();
  }

  @override
  Color backgroundColor() => Colors.blue;
}

