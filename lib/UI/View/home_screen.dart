import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../Utils/ball.dart';
import '../../Utils/buttons.dart';
import '../../Utils/missile.dart';
import '../../Utils/player.dart';

/**
 * Created by Parth Sheth.
 * Created on 14/06/23 at 2:45 pm
 */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum direction { LEFT, RIGHT }

class _HomeScreenState extends State<HomeScreen> {
  ///Player Coordinates
  static double playerX = 0;
  double playerY = 1;

  ///Missiles Coordinates and Size
  double missileX = playerX;
  double missileY = 1;
  double missileHeight = 10;

  bool isMidShot = false;

  ///Ball Coordinates and Size
  double ballX = 0.5;
  double ballY = 0.0;

  ///Player Score
  double playerScore = 0.0;

  var ballDirection = direction.LEFT;
  bool isBallVisible = true;

  void moveLeft() {
    setState(() {
      if (playerX - 0.1 < -1) {
      } else {
        playerX -= 0.1;
      }
      if (!isMidShot) {
        missileX = playerX;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + 0.1 > 1) {
      } else {
        playerX += 0.1;
      }
      if (!isMidShot) {
        missileX = playerX;
      }
    });
  }

  void fireMissile() {
    if (isMidShot == false) {
      Timer.periodic(const Duration(milliseconds: 20), (timer) {
        setState(() {
          // isMidShot = true;
          missileHeight += 10.0;
        });

        ///stop missile when missile reaches top
        if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
          resetMissile();
          timer.cancel();
        }

        ///check if missile has hit the ball
        if (ballY > heightToOrdinates(missileHeight) &&
            (ballX - missileX).abs() < 0.05) {
          setState(() {
            ballX = 5;
            playerScore += 1.0;
            timer.cancel();
          });
          resetMissile();
        }
      });
    }
  }

  void resetMissile() {
    setState(() {
      missileX = playerX;
      missileHeight = 0.0;
    });
  }

  /*int playerDies() {
    if ((ballX - playerX).abs() < 0.05 && ballY > 0.95) {
        playerHealth = playerHealth -1;
      print('Health minus');
    }
    return playerHealth;
  }*/

  void startGame() {
    double time = 0;
    double height = 0;
    double velocity = 60;

    ///For the bounce effect
    isMidShot = false;

    ///Set Score to zero
    playerScore = 0;

    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      ///To make ball bounce
      height = -5 * time * time + velocity * time;

      ///if the ball reaches the ground, reset jump
      if (height < 0) {
        time = 0;
      }
      time += 0.1;
      setState(() {
        isBallVisible = true;
        ballY = heightToOrdinates(height);
      });

      ///If the ball hits the left wall, then change direction right
      if (ballX - 0.005 < -1) {
        ballDirection = direction.RIGHT;
      }

      ///If the ball hits the right wall, then change direction left
      else if (ballX + 0.005 > 1) {
        ballDirection = direction.LEFT;
      }

      ///if the direction of ball is same as the right direction
      if (ballDirection == direction.RIGHT) {
        setState(() {
          ballX += 0.005;
        });
      }

      ///if the direction of ball is same as the left direction
      else if (ballDirection == direction.LEFT) {
        setState(() {
          ballX -= 0.005;
        });
      }
      if ((ballX - playerX).abs() < 0.05 && ballY > 0.95) {
        // playerHealth.removeLast();
        timer.cancel();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(
                  child: Column(
                    children: [
                      const Text('You are dead'),
                      Text('Your Score ${playerScore.toInt()}')
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(onPressed: () {
                    setState(() {
                      ballX = 0.5;
                      ballY = 0.0;
                    });
                    Navigator.of(context).pop();
                  }, child: const Text('Reset Game')),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isBallVisible = false;
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'))
                ],
              );
            });
        print('Dead');
        print('Health minus');
      }
    });
  }

  ///Converts height to a coordinate
  double heightToOrdinates(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double correctedHeight = 1 - 2 * height / totalHeight;
    return correctedHeight;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          fireMissile();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.pink[200],
                child: Center(
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text('Player Score ${playerScore.toInt()}')),
                        ],
                      ),
                      Visibility(
                          visible: isBallVisible,
                          child: Ball(ballX: ballX, ballY: ballY)),
                      Missile(
                        missileHeight: missileHeight,
                        missileX: missileX,
                        missileY: missileY,
                      ),
                      Player(playerX: playerX, playerY: playerY),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButtons(icon: Icons.play_arrow, function: startGame),
                  CustomButtons(icon: Icons.arrow_back, function: moveLeft),
                  CustomButtons(icon: Icons.arrow_upward, function: fireMissile),
                  CustomButtons(icon: Icons.arrow_forward, function: moveRight),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
