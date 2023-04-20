// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:book_reader_app/constants/sizes.dart';
import 'package:book_reader_app/cubit/app_cubit_states.dart';
import 'package:book_reader_app/cubit/app_cubits.dart';
import 'package:book_reader_app/pages/my_stories/write_my_stories.dart';
import 'package:flutter/material.dart';
import 'package:book_reader_app/pages/detail_pages/detail_page.dart';
import 'package:book_reader_app/widgets/app_large_text.dart';
import 'package:book_reader_app/widgets/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    TabController _tabController = TabController(length: 3, vsync: this);

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
                Icon(Icons.menu, size: 30, color: Colors.black),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1),
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
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: AppLargeText(
              text: "Discover",
              color: Colors.black,
              fontfamily: "Kaushan",
            ),
          ),
          SizedBox(height: 30),
          //TabBar
          Container(
            child: TabBar(
              labelPadding: EdgeInsets.only(left: 20, right: 0),
              labelColor: black,
              indicator:
                  CircleTabIndicator(color: grey.withOpacity(0.8), radius: 4),
              indicatorSize: TabBarIndicatorSize.label,
              controller: _tabController,
              tabs: [
                Tab(text: "Books"),
                Tab(text: "Authors"),
                Tab(text: "Genre"),
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
                ListView.builder(
                    itemCount: tabItems.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      int ind = i;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DetailPage(tabItems: tabItems, i: ind);
                            },
                          ));
                        },
                        child:
                            MenuPageListItems(tabItems: tabItems, i: ind),
                      );
                    }),
                Text("Hi"),
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
                AppLargeText(
                  text: "Find more",
                  size: 22,
                  fontfamily: "Kaushan",
                  color: black,
                ),
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
            child: ListView.builder(
              itemCount: smallTabs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return WriteMyStories();
                            },
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: grey.withOpacity(0.1),
                              image: DecorationImage(
                                image: AssetImage(smallTabs[i]["img"]),
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(top: Sizes.screenHeight/60),
                            child: Center(
                                child: Text(
                              smallTabs[i]["title"],
                              style: TextStyle(color: grey),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
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
