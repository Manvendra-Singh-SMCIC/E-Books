// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/app_text.dart';

class MenuPageListItems extends StatelessWidget {
  QueryDocumentSnapshot doc;
  MenuPageListItems({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20),
          width: 200,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(doc["img"]),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          width: 200,
          height: 220,
          alignment: Alignment(-0.7, 0.85),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: AppText(
              text: doc["title"], color: Colors.white, size: 18),
        ),
      ],
    );
  }
}
