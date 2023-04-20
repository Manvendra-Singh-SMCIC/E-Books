// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class SmallButtonCircular extends StatelessWidget {
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final double size;
  final onPressed;
  const SmallButtonCircular({
    super.key,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(size),
        ),
        child: Center(
          child: IconButton(onPressed: onPressed, icon: Icon(icon), color: iconColor),
        ),
      ),
    );
  }
}
