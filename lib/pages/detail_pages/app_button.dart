// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:book_reader_app/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  final Color color;
  String? text;
  IconData? icon;
  final Color backgroundColor;
  final Color borderColor;
  double size;
  bool? isIcon;

  AppButton(
      {super.key,
      this.text = "BTN",
      this.icon,
      this.isIcon = false,
      required this.size,
      required this.color,
      required this.backgroundColor,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: isIcon == false ? Center(child: AppText(text: text!, color: color, size: 12)) : Icon(icon, color: color),
    );
  }
}
