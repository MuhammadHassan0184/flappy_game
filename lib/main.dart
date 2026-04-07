import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/my_game.dart';
import 'game/game_over_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final game = MyGame();

    return MaterialApp(
      title: 'Flappy Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: GameWidget(
          game: game,

          // ✅ Register overlays here
          overlayBuilderMap: {
            'gameOver': (context, game) =>
                GameOverMenu(game: game as MyGame),
          },
        ),
      ),
    );
  }
}