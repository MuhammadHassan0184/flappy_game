// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'my_game.dart';

class GameOverMenu extends StatelessWidget {
  final MyGame game;

  const GameOverMenu({super.key, required this.game});

  Widget _buildMedal(MyGame game) {
    String medal = game.getMedal();

    if (medal == "gold") {
      return const Text("🥇 GOLD", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    } else if (medal == "silver") {
      return const Text("🥈 SILVER", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    } else if (medal == "bronze") {
      return const Text("🥉 BRONZE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    } else {
      return const Text("No Medal", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Light blur background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(color: Colors.white.withOpacity(0.3)),
        ),

        // Center popup
        Center(
          child: Container(
            width: 280,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                const Text(
                  "GAME OVER",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                // Score box
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Score: ${game.score}",
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 10),

                    _buildMedal(game),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Best: ${game.bestScore}",
                            textAlign: TextAlign.center,
                          ),

                          if (game.isNewBest)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                "NEW BEST! 🎉",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Restart button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {
                      game.overlays.remove('gameOver'); // ✅ close popup
                      game.restartGame();
                    },
                    child: const Text(
                      "RESTART",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
