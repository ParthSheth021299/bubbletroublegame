import 'package:flutter/material.dart';

/**
 * Created by Parth Sheth.
 * Created on 14/06/23 at 3:45 pm
 */

class Missile extends StatelessWidget {
  final missileX;
  final missileY;
  final missileHeight;
  const Missile({super.key, this.missileX, this.missileY, this.missileHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX, missileY),
      child: Container(
        width: 2,
        height: missileHeight,
        color: Colors.black,
      ),
    );
  }
}
