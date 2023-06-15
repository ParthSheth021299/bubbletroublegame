import 'package:flutter/material.dart';

/**
 * Created by Parth Sheth.
 * Created on 14/06/23 at 3:53 pm
 */

class Ball extends StatelessWidget {
  final ballX;
  final ballY;
  const Ball({super.key, this.ballX, this.ballY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown
        ),
      ),
    );
  }
}
