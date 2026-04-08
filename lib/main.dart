import 'package:flappy_game/game/home_menu.dart';
import 'package:flappy_game/game/pause_menu.dart';
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
    return MaterialApp(
      title: 'Flappy Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: SafeArea(
          child: GameWidget(
            game: MyGame(),
            overlayBuilderMap: {
              'home': (context, game) => HomeMenu(game: game as MyGame),
              'pause': (context, game) => PauseMenu(game: game as MyGame),
              'gameOver': (context, game) => GameOverMenu(game: game as MyGame),
            },
          ),
        ),
      ),
    );
  }
}
