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
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data!.docs[i]['img']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppLargeText(
                                    text: snapshot.data!.docs[i]['title'],
                                    fontfamily: "Samantha",
                                  ),
                                  AppText(
                                    text: snapshot.data!.docs[i]['sub_title'],
                                    fontFamily: "Samantha",
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 300,
                                    child: AppText(
                                      text: snapshot.data!.docs[i]['text'],
                                      size: 14,
                                      fontFamily: "Samantha",
                                    ),
                                  ),
                                  SizedBox(height: 130),
                                ],
                              ),
                              SizedBox(width: 25),
                              Column(
                                children: [
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              4 /
                                              20),
                                  // Dot Indicator
                                  Column(
                                    children: List.generate(
                                        snapshot.data!.docs.length, (index) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 3),
                                        width: 5,
                                        height: (index == i) ? 25 : 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: (index == i)
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.3),
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
                                    return MainPage();
                                  },
                                ));
                              },
                              child: Container(
                                alignment: Alignment(1, 1),
                                child: Padding(
                                    padding: EdgeInsets.only(bottom: 30),
                                    child: ResponsiveButton(
                                      width: 80,
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
