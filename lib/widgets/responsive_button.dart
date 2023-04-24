// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:book_reader_app/widgets/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  bool isResponsive;
  double? width;
  double? height;
  Color color;
  String text;

  ResponsiveButton(
      {super.key,
      this.isResponsive = false,
      this.width = 120,
      this.height = 50,
      this.color = Colors.blue,
      this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: isResponsive
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          isResponsive
              ? Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                  child: AppText(text: text),
                )
              : Container(),
          const Icon(
            Icons.keyboard_double_arrow_right,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
