// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  final fontfamily;

  AppLargeText(
      {super.key,
      required this.text,
      this.color = Colors.white,
      this.fontfamily = "Samantha",
      this.size = 30}) {}

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: fontfamily,
      ),
    );
  }
}
