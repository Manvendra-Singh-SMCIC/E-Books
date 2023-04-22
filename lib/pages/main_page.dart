// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_reader_app/colors/app_colors.dart';
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
    return Scaffold(
      extendBody: true,
      body: pages[currentIndex],
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: onTap,
        color: AppColors.themeColor.withOpacity(0.6),
        backgroundColor: Colors.transparent,
        height: 50,
        animationCurve: Curves.fastOutSlowIn,
        index: currentIndex,
        items: [
          Icon(Icons.apps, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.book, size: 30),
          Icon(Icons.person, size: 30),
        ],
      ),
    );
  }
}