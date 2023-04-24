// ignore_for_file: prefer_typing_uninitialized_variables, avoid_unnecessary_containers, unused_local_variable, invalid_return_type_for_catch_error, avoid_print

import 'package:book_reader_app/app_style/style.dart';
import 'package:book_reader_app/colors/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/sizes.dart';
import '../../widgets/small_buttons_circular.dart';

class StoryReaderScreen extends StatefulWidget {
  const StoryReaderScreen({super.key, required this.doc});
  final QueryDocumentSnapshot doc;

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  bool tapped = false;

  void back() {
    Navigator.pop(context, true);
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.doc["note_title"];
    _mainController.text = widget.doc["note_content"];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int colorId = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: Colors.white,
      // Top Two Icons
      body: Column(
        children: [
          Container(
            color: AppColors.themeColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                SmallButtonCircular(
                  bgColor: AppColors.themeColor,
                  iconColor: Colors.black,
                  icon: Icons.arrow_back,
                  size: Sizes.smallButtonsize * 1.5,
                  onPressed: back,
                ),
                Text(
                  !tapped ? "Read" : "Edit",
                  style: TextStyle(
                    fontSize: Sizes.screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Save Button
                SmallButtonCircular(
                  bgColor: AppColors.themeColor,
                  iconColor: tapped ? Colors.black : AppColors.themeColor,
                  icon: Icons.check,
                  size: Sizes.smallButtonsize * 1.5,
                  onPressed: () {
                    if (tapped) {
                      setState(() {
                        String date = DateTime.now().toString();
                        FirebaseFirestore.instance
                            .collection("mystories")
                            .doc(widget.doc["id"])
                            .update({
                              "note_title": _titleController.text,
                              "creation_date": date,
                              "note_content": _mainController.text,
                              "color_id": colorId
                            })
                            .then((value) {})
                            .catchError((error) =>
                                print("Failed to add new note due to $error"));
                        tapped = false;
                        Fluttertoast.showToast(
                          msg: "Saved",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: AppColors.themeColor,
                          textColor: AppColors.white,
                          fontSize: 15,
                        );
                        Navigator.pop(context, true);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(Sizes.screenHeight / 60),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Sizes.screenHeight / 100),
                  // Story Title
                  !tapped
                      ? GestureDetector(
                          onTap: () {
                            if (!tapped) {
                              setState(() {
                                tapped = true;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                color: Colors.transparent,
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 12,
                                child: Center(
                                  child: Text(
                                    widget.doc["note_title"],
                                    style: TextStyle(
                                      fontSize: Sizes.screenWidth / 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: Center(
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: _titleController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Story Title"),
                            style: TextStyle(
                                fontSize: Sizes.screenWidth / 10,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  SizedBox(height: Sizes.screenHeight / 50),
                  // Date
                  Text(
                    widget.doc["creation_date"],
                    style: AppStyle.dateTitle,
                  ),
                  SizedBox(height: Sizes.screenHeight / 50),
                  // Story Content
                  Expanded(
                    child: SingleChildScrollView(
                      child: !tapped
                          ? GestureDetector(
                              onTap: () {
                                if (!tapped) {
                                  setState(() {
                                    tapped = true;
                                  });
                                }
                              },
                              child: Container(
                                width: width - width / 15,
                                padding: const EdgeInsets.all(0.0),
                                child: Text(
                                  widget.doc["note_content"],
                                  style: TextStyle(
                                    fontSize: Sizes.screenWidth / 23,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: TextField(
                                controller: _mainController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 50000,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Start writing here"),
                                style: TextStyle(
                                  fontSize: Sizes.screenWidth / 23,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
