import 'package:flutter/material.dart';

/**
 * Created by Parth Sheth.
 * Created on 14/06/23 at 2:52 pm
 */

class CustomButtons extends StatelessWidget {
  final icon;
  final function;
  const CustomButtons({super.key, this.icon, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50,
          width: 50,
          color: Colors.grey[100],
          child: Center(
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
