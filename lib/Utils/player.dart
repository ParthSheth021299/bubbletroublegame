import 'package:flutter/material.dart';

/**
 * Created by Parth Sheth.
 * Created on 14/06/23 at 3:20 pm
 */

class Player extends StatelessWidget {
  final playerX;
  final playerY;
  const Player({super.key, this.playerX, this.playerY});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(playerX,playerY),
      child: Container(
        color: Colors.transparent,
        width: 50,
        height: 50,
        child: Image.asset('assets/image/png/player_avatar.png',),
      ),
    );
  }
}
