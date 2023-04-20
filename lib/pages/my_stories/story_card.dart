import 'package:book_reader_app/app_style/style.dart';
import 'package:book_reader_app/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget storyCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Stack(children: [
      Container(
        padding: EdgeInsets.all(Sizes.screenWidth / 40),
        margin: EdgeInsets.all(Sizes.screenWidth / 100),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2.0,
                  offset: Offset(Sizes.screenWidth/200, Sizes.screenWidth/200),
                  blurRadius: Sizes.screenWidth / 500)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doc["note_title"],
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: Sizes.screenHeight / 130),
            Text(
              doc["creation_date"],
              style: AppStyle.dateTitle,
            ),
            SizedBox(height: Sizes.screenHeight / 50),
            Expanded(
              child: Text(
                doc["note_content"],
                style: AppStyle.mainContent,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      Positioned(
          right: Sizes.screenWidth / 20,
          top: Sizes.screenWidth / 20,
          child: Container(
            width: Sizes.screenWidth / 27,
            height: Sizes.screenWidth / 27,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.screenWidth / 54),
                color: AppStyle.cardsColor[doc['color_id']]),
          ))
    ]),
  );
}
