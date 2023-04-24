// ignore_for_file: file_names

import 'package:book_reader_app/pages/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_reader_app/widgets/app_large_text.dart';
import 'package:book_reader_app/widgets/app_text.dart';
import 'package:book_reader_app/widgets/responsive_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List btnColors = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("introPage").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return PageView.builder(
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (_, i) {
                  btnColors.add(
                      HexColor.fromHex(snapshot.data!.docs[i]['btn_color']));
                  return Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      // BackGround Image
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data!.docs[i]['img']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: height / 70,
                          left: width / 15,
                          right: width / 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height *0.007),
                                  // Title
                                  AppLargeText(
                                    text: snapshot.data!.docs[i]['title'],
                                    fontfamily: "Samantha",
                                  ),
                                  SizedBox(height: height / 50),
                                  //SubTitle
                                  AppText(
                                    text: snapshot.data!.docs[i]['sub_title'],
                                    size: height / 50,
                                    fontFamily: "Samantha",
                                  ),
                                  // Description
                                  SizedBox(height: height / 50),
                                  SizedBox(
                                    width: width * 0.8,
                                    child: AppText(
                                      text: snapshot.data!.docs[i]['text'],
                                      size: height / 50,
                                      fontFamily: "Samantha",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: width * 0.025),
                              Column(
                                children: [
                                  Container(height: height * 4 / 20),
                                  // Dot Indicator
                                  Column(
                                    children: List.generate(
                                        snapshot.data!.docs.length, (index) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: height/200),
                                        width: width * 0.013,
                                        height: (index == i) ? height*0.03 : height * 0.009,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(width * 0.013 / 2),
                                          color: (index == i)
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.6),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              )
                            ],
                          ),
                          //Button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const MainPage();
                                  },
                                ));
                              },
                              child: Container(
                                alignment: const Alignment(1, 1),
                                child: Padding(
                                    padding: EdgeInsets.only(bottom: height * 0.03),
                                    child: ResponsiveButton(
                                      width: width * 0.23,
                                      color: btnColors[i],
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
