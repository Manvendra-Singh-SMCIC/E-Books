// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_reader_app/colors/app_colors.dart';
import 'package:book_reader_app/constants/sizes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:book_reader_app/pages/bar_item_page.dart';
import 'package:book_reader_app/pages/menu_page.dart';
import 'package:book_reader_app/pages/search_page.dart';

import 'my_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    MenuPage(),
    BarItemPage(),
    SearchPage(),
    MyPage(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      body: pages[currentIndex],
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: onTap,
        animationDuration: Duration(milliseconds:0500),
        color: AppColors.themeColor.withOpacity(0.8),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: AppColors.themeColor.withOpacity(0.9),
        height: height * 0.06,
        animationCurve: Curves.fastOutSlowIn,
        index: currentIndex,
        items: [
          Icon(Icons.apps, size: height * 0.037),
          Icon(Icons.search, size: height * 0.037),
          Icon(Icons.book, size: height * 0.037),
          Icon(Icons.person, size: height * 0.037),
        ],
      ),
    );
  }
}