// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:book_reader_app/colors/app_colors.dart';
import 'package:book_reader_app/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_reader_app/pages/my_stories/write_my_stories.dart';
import 'package:flutter/material.dart';
import 'package:book_reader_app/pages/detail_pages/detail_page.dart';
import 'package:book_reader_app/widgets/app_large_text.dart';
import 'package:book_reader_app/widgets/app_text.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'menu_page_list_items.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  List tabItems = [""];
  List smallTabs = [""];

  String profile_book_image = "lib/images/book_profile.png";

  Color black = Colors.black;
  Color grey = Colors.grey;
  Color white = Colors.white;

  @override
  void initState() {
    super.initState();

    readData();
  }

  readData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((s) {
      setState(() {
        tabItems = json.decode(s);
      });
    });

    await DefaultAssetBundle.of(context)
        .loadString("json/menupage_tabs_small.json")
        .then((s) {
      setState(() {
        smallTabs = json.decode(s);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    int indexTab = 0;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Read Title
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Center(child: AppLargeText(text: "READ", color: black)),
          ),
          //Menu + User Icon
          Padding(
            padding: EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Row(
              children: [
                Icon(Icons.menu,
                    size: Sizes.screenWidth / 12, color: AppColors.themeColor),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.themeColor.withOpacity(0.3),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://drive.google.com/uc?export=view&id=1gfpCHbQhgFxcQSuCyXYd_reoVn4FyxSe"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          //Discover
          Container(
            margin: EdgeInsets.only(left: width * 0.01),
            child: Wrap(
              children: [
                SizedBox(width: 20),
                Container(
                  height: height * 0.05,
                  width: context.width * 0.41,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.height/2),
                    color: AppColors.themeColor,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.03),
                      Padding(
                        padding: EdgeInsets.only(left: context.width * 0.006),
                        child: AppLargeText(
                          text: "Discover",
                          color: Colors.black,
                          fontfamily: "Kaushan",
                          size: width * 0.08,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          //TabBar
          Container(
            color: Colors.transparent,
            child: TabBar(
              onTap: (value) {
                setState(() {
                  indexTab = value;
                });
              },
              labelPadding: EdgeInsets.only(left: 20, right: 0),
              labelColor: black,
              indicator:
                  CircleTabIndicator(color: grey.withOpacity(0.8), radius: 4),
              indicatorSize: TabBarIndicatorSize.label,
              controller: _tabController,
              tabs: [
                Tab(text: "Books"),
                Tab(text: "Authors"),
              ],
            ),
          ),
          SizedBox(height: 10),
          //TabBar List
          Container(
            padding: EdgeInsets.only(left: 20),
            height: 220,
            width: double.maxFinite,
            child: TabBarView(
              controller: _tabController,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("book_details")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return DetailPage(
                                        doc: snapshot.data!.docs[i]);
                                  },
                                ));
                              },
                              child: MenuPageListItems(
                                  doc: snapshot.data!.docs[i]),
                            );
                          });
                    }
                    return Center(child: Text("Offline"));
                  },
                ),
                Text("Hi"),
              ],
            ),
          ),
          SizedBox(height: 30),
          //Find more
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(children: [
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(17.5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 3, bottom: 3),
                      child: AppLargeText(
                        text: "Find more",
                        size: 22,
                        fontfamily: "Kaushan",
                        color: black,
                      ),
                    ),
                  ),
                ]),
                AppText(
                    text: "See all",
                    color: grey,
                    fontFamily: "Kaushan",
                    size: 14)
              ],
            ),
          ),
          SizedBox(height: 10),
          // Some icons in a row with name
          Container(
            height: 130,
            padding: EdgeInsets.only(left: 10, top: 20),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("menu_page_small_icons")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        QueryDocumentSnapshot doc = snapshot.data!.docs[i];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return WriteSplash();
                                  },
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.themeColor,
                                    image: DecorationImage(
                                      image: NetworkImage(doc["img"]),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 80,
                                height: 50,
                                margin: EdgeInsets.only(
                                    top: Sizes.screenHeight / 100),
                                decoration: BoxDecoration(
                                  color: AppColors.themeColor,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 1),
                                  child: Center(
                                      child: Text(
                                    doc["title"],
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          )
        ],
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 + 2 * radius,
        configuration.size!.height - radius * 2);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}

class WriteSplash extends StatefulWidget {
  const WriteSplash({super.key});

  @override
  State<WriteSplash> createState() => _WriteSplashState();
}

class _WriteSplashState extends State<WriteSplash> {
  @override
  void initState() {
    super.initState();
    _navigateToWrite();
  }

  _navigateToWrite() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WriteMyStories()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 500,
          alignment: const Alignment(0,1),
          child: OverflowBox(
            // child: AnimatedSplashScreen(
            //   splash: Lottie.network(
            //     "https://assets4.lottiefiles.com/packages/lf20_D7l6QPTtOL.json",
            //     fit: BoxFit.cover,
            //   ),
            //   splashTransition: SplashTransition.scaleTransition,
            //   pageTransitionType: PageTransitionType.fade,
            //   nextScreen: const HomePage(),
            //   duration: 3000,
            // ),
            child: Lottie.network(
                "https://assets2.lottiefiles.com/packages/lf20_yswp4uj3.json",
                fit: BoxFit.cover,
              ),
          ),
        ),
      ),
    );
  }
}
