import 'package:book_reader_app/constants/sizes.dart';
import 'package:book_reader_app/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final Color color;
  const ExpandableText(
      {super.key, required this.text, this.color = AppColors.grey});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;

  double textHeight = Sizes.screenHeight / 7.63;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? AppText(text: firstHalf, color: widget.color.withOpacity(0.7))
          : Column(
              children: [
                AppText(
                  text:
                      hiddenText ? ("$firstHalf...") : (firstHalf + secondHalf),
                  color: AppColors.grey.withOpacity(0.7),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      AppText(text: "Show ${hiddenText?"More":"Less"}", color: AppColors.blue),
                      SizedBox(width: Sizes.screenWidth / 80),
                      Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.blue),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
