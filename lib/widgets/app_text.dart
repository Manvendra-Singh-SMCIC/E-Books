// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class AppText extends StatelessWidget {
  double size;
  final String text;
  final dynamic fontFamily;
  final Color color;

  AppText({
    super.key,
    required this.text,
    this.fontFamily = "",
    this.color = AppColors.white,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    if (size == 16) {
      size = 16;
    }
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: fontFamily,
      ),
    );
  }
}
