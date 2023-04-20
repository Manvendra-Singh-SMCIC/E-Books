// ignore_for_file: must_be_immutable, prefer_const_constructors, sized_box_for_whitespace

import 'package:book_reader_app/colors/app_colors.dart';
import 'package:book_reader_app/constants/sizes.dart';
import 'package:book_reader_app/widgets/expandable_text_widget.dart';
import 'package:book_reader_app/widgets/small_buttons_circular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_reader_app/pages/detail_pages/app_button.dart';
import 'package:book_reader_app/pages/pdf_view.dart';
import 'package:book_reader_app/widgets/app_large_text.dart';
import 'package:book_reader_app/widgets/responsive_button.dart';
import '../../widgets/app_text.dart';

class DetailPage extends StatefulWidget {
  QueryDocumentSnapshot doc;
  DetailPage({super.key, required this.doc});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedIndexRating = -1;
  int previousIndexRating = -1;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    liked = widget.doc["liked"] == 1 ? true : false;
    selectedIndexRating = widget.doc["my_rating"] - 1;
    previousIndexRating = widget.doc["my_rating"] - 2;
  }

  void back() {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot doc = widget.doc;
    Color black = Colors.black;
    Color white = Colors.white;
    Color grey = Colors.grey;
    Color blue = Colors.blue.shade700;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
//Image
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: height * 0.42,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(doc["img"]),
                    fit: BoxFit.cover,
                  )),
                )),
//Top icons
            Positioned(
              left: 20,
              top: 40,
              child: Row(
                children: [
                  SmallButtonCircular(
                    bgColor: white,
                    iconColor: black,
                    icon: Icons.arrow_back,
                    size: Sizes.smallButtonsize,
                    onPressed: back,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.66),
                  SmallButtonCircular(
                    bgColor: AppColors.white,
                    iconColor: AppColors.black,
                    icon: Icons.more_vert,
                    size: Sizes.smallButtonsize,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
//Curved Card
            Positioned(
                top: height * 0.33,
                child: Container(
                  height: height * 0.74,
                  width: width,
                  margin: EdgeInsets.only(bottom: Sizes.screenHeight / 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Title of card
                      Container(
                        padding: EdgeInsets.only(
                            left: Sizes.screenWidth / 20,
                            top: Sizes.screenHeight / 100,
                            right: Sizes.screenHeight / 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppLargeText(text: doc["title"], color: black),
                            AppText(
                                text: "Read more",
                                color: grey.withOpacity(0.7)),
                          ],
                        ),
                      ),
                      SizedBox(height: 0),
                      //Location
                      Container(
                        padding: EdgeInsets.only(left: Sizes.screenWidth / 60),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.location_pin, color: blue)),
                            GestureDetector(
                                child: AppText(
                                    text: doc["location"], color: blue)),
                          ],
                        ),
                      ),
                      SizedBox(height: Sizes.screenHeight / 180),
                      //Stars
                      Container(
                        padding: EdgeInsets.only(left: Sizes.screenWidth / 20),
                        child: Row(
                          children: [
                            Wrap(
                              children: List.generate(5, (index) {
                                double size = Sizes.screenHeight / 30;
                                double stars = double.parse(doc["rating"]);
                                int wholeRating = stars.floor();
                                int fractRating =
                                    ((stars - wholeRating) * 10).ceil();
                                if (index < wholeRating) {
                                  return Icon(Icons.star,
                                      color: Colors.amber, size: size);
                                } else if (index == wholeRating) {
                                  return SizedBox(
                                    height: size,
                                    width: size,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: size,
                                        ),
                                        ClipRect(
                                            clipper:
                                                _Clipper(part: fractRating),
                                            child: Icon(Icons.star,
                                                color: grey, size: size))
                                      ],
                                    ),
                                  );
                                } else {
                                  return Icon(Icons.star,
                                      color: grey, size: size);
                                }
                              }),
                            ),
                            SizedBox(width: Sizes.screenHeight / 120),
                            AppText(
                              text: doc["rating"],
                              color: blue,
                              size: Sizes.screenHeight / 50,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: Sizes.screenHeight / 180),
                      //Your Rating
                      Container(
                          margin: EdgeInsets.only(left: Sizes.screenWidth / 20),
                          child:
                              AppLargeText(text: "Your Rating", color: black)),
                      SizedBox(height: Sizes.screenHeight / 120),
                      // Rate the book
                      Container(
                          margin: EdgeInsets.only(left: Sizes.screenWidth / 20),
                          child: AppText(text: "Rate the book", color: grey)),
                      SizedBox(height: Sizes.screenHeight / 120),
                      //Rating Tabs
                      Container(
                        padding: EdgeInsets.only(left: Sizes.screenWidth / 20),
                        child: Wrap(
                          children: List.generate(5, (index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndexRating = index;
                                  if (selectedIndexRating !=
                                      previousIndexRating) {
                                    FirebaseFirestore.instance
                                        .collection("book_details")
                                        .doc(doc.id)
                                        .update({
                                      "my_rating": selectedIndexRating + 1,
                                    });
                                    previousIndexRating = selectedIndexRating;
                                  } else {
                                    FirebaseFirestore.instance
                                        .collection("book_details")
                                        .doc(doc.id)
                                        .update({
                                      "my_rating": -1,
                                    });
                                    selectedIndexRating = -1;
                                    previousIndexRating = -2;
                                  }
                                });
                              },
                              child: Container(
                                child: AppButton(
                                  backgroundColor: selectedIndexRating == index
                                      ? black
                                      : grey.withOpacity(0.5),
                                  size: 60,
                                  borderColor: grey.withOpacity(0.5),
                                  color: selectedIndexRating == index
                                      ? white
                                      : black,
                                  isIcon: false,
                                  text: (index + 1).toString(),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: Sizes.screenHeight / 90),
                      //Description Heading
                      Container(
                        margin: EdgeInsets.only(left: Sizes.screenWidth / 20),
                        child: AppLargeText(text: "Description", color: black),
                      ),
                      SizedBox(height: Sizes.screenHeight / 120),
                      //Description
                      Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        bottom: Sizes.screenHeight / 5.5),
                                    padding: EdgeInsets.only(
                                        left: Sizes.screenHeight / 35,
                                        right: Sizes.screenWidth / 35),
                                    child: ExpandableText(text: doc["about"])),
                              ],
                            )),
                      ),
                      //Bottom Buttons
                    ],
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: height / 40, bottom: height / 75),
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          //Favourite Button
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  liked = !liked;
                  if (widget.doc["liked"] == 0) {
                    FirebaseFirestore.instance
                        .collection("book_details")
                        .doc(doc.id)
                        .update({
                      "liked": 1,
                    });
                  } else {
                    FirebaseFirestore.instance
                        .collection("book_details")
                        .doc(doc.id)
                        .update({
                      "liked": 0,
                    });
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: Sizes.screenWidth / 25),
                child: AppButton(
                  size: Sizes.screenHeight / 15,
                  color: liked ? white : black,
                  backgroundColor: liked ? Colors.pink : white,
                  borderColor: liked ? Colors.transparent : black,
                  isIcon: true,
                  icon: Icons.favorite_border,
                ),
              ),
            ),
            SizedBox(width: Sizes.screenWidth / 25),
            //Read Now Button
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return PdfViews(doc: doc);
                  },
                ));
              },
              child: ResponsiveButton(
                width: MediaQuery.of(context).size.width * 0.68,
                height: Sizes.screenHeight / 15,
                text: "Read Now",
                isResponsive: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;

  _Clipper({required this.part});
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
        (size.width / 10) * part, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
