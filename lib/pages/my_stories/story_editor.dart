// ignore_for_file: non_constant_identifier_names, invalid_return_type_for_catch_error, avoid_print, unnecessary_null_comparison

import 'dart:math';

import 'package:book_reader_app/app_style/style.dart';
import 'package:book_reader_app/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoryEditor extends StatefulWidget {
  const StoryEditor({super.key});

  @override
  State<StoryEditor> createState() => _StoryEditorState();
}

class _StoryEditorState extends State<StoryEditor> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Padding(
          padding: EdgeInsets.only(left: width / 22, top: height / 70),
          child: Text("Add a new story here",
              style: TextStyle(
                color: Colors.black,
                fontSize: width / 15,
                fontFamily: "Samantha",
              )),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: Sizes.screenWidth / 20,
            top: Sizes.screenHeight / 1000,
            right: Sizes.screenWidth / 20),
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.center,
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Story Title",
                labelStyle: TextStyle(fontSize: Sizes.screenWidth / 12),
                hintStyle: TextStyle(fontSize: Sizes.screenWidth / 12),
              ),
              style: TextStyle(
                fontSize: Sizes.screenWidth / 12,
                fontWeight: FontWeight.bold,
                fontFamily: "Samantha",
              ),
            ),
            SizedBox(height: Sizes.screenHeight / 100),
            Text(date, style: AppStyle.dateTitle),
            SizedBox(height: Sizes.screenHeight / 100),
            Expanded(
              child: SingleChildScrollView(
                child: TextField(
                  controller: _mainController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 50000,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Start writing here",
                    labelStyle: TextStyle(fontSize: Sizes.screenWidth / 20),
                    hintStyle: TextStyle(fontSize: Sizes.screenWidth / 20),
                  ),
                  style: TextStyle(
                      fontSize: Sizes.screenWidth / 20,
                      fontFamily: "Samantha"),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          if (_titleController.text == null ||
              _titleController.text == "" ||
              _titleController.text == '\b') {
            _titleController.text = "Story Title";
          }
          if (_mainController.text == null ||
              _mainController.text == "" ||
              _mainController.text == '\b') {
            _mainController.text = "Start writing here....";
          }
          String id = DateTime.now().microsecondsSinceEpoch.toString();
          FirebaseFirestore.instance.collection("mystories").doc(id).set({
            "id": id,
            "note_title": _titleController.text,
            "creation_date": date,
            "note_content": _mainController.text,
            "color_id": color_id
          }).then((value) {
            print("Done");
            Navigator.pop(context);
          }).catchError(
              (error) => print("Failed to add new note due to $error"));
        },
        child: Container(
          width: Sizes.screenWidth/6,
          height: Sizes.screenWidth/6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.screenWidth/12),
            color: AppStyle.cardsColor[color_id],
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2.5,
                  blurRadius: Sizes.screenWidth / 300)
            ],
          ),
          child: const Icon(Icons.check, color: Colors.grey)),
      ),
    );
  }
}
