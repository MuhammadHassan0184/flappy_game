// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'my_game.dart';

class HomeMenu extends StatelessWidget {
  final MyGame game;

  const HomeMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blur background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(color: Colors.white.withOpacity(0.6)),
        ),

        // // Top Icons (Sound + Info)
        // Positioned(
        //   top: 40,
        //   right: 20,
        //   child: Row(
        //     children: [
        //       IconButton(
        //         onPressed: () {},
        //         icon: const Icon(Icons.volume_up, color: Colors.black87),
        //       ),
        //       IconButton(
        //         onPressed: () {},
        //         icon: const Icon(Icons.info_outline, color: Colors.black87),
        //       ),
        //     ],
        //   ),
        // ),

        // Main Card
        Center(
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bird Icon
                Text("🐦", style: TextStyle(fontSize: 50)),

                SizedBox(height: 10),

                // Title
                Text(
                  "FLAPPY GAME",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "Tap to fly and avoid pipes!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),

                SizedBox(height: 25),

                // Play Button with Icon
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                    label: Text(
                      "PLAY",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () {
                      game.startGame();
                    },
                  ),
                ),

                SizedBox(height: 12),

                // How to Play Button
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.4),
                      builder: (_) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Top Icon
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.sports_esports,
                                  color: Colors.blueAccent,
                                  size: 30,
                                ),
                              ),

                              SizedBox(height: 15),

                              // Title
                              Text(
                                "How to Play",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),

                              SizedBox(height: 10),

                              // Instructions
                              Text(
                                "• Tap to fly 🐦\n"
                                "• Avoid pipes 🚧\n"
                                "• Score high ⭐",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  height: 1.5,
                                ),
                              ),

                              SizedBox(height: 20),

                              // Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    elevation: 2,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "Got it!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.help_outline, size: 18, color: Colors.black,),
                  label: Text("How to Play", style: TextStyle(color: Colors.black),),
                ),

                SizedBox(height: 10),

                // Decorative Stars Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
