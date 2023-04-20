// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
      body: pages[currentIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.8),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        
        items: [
        BottomNavigationBarItem(label: "Home", icon: Icon(Icons.apps)),
        BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
        BottomNavigationBarItem(label: "Search", icon: Icon(Icons.book)),
        BottomNavigationBarItem(label: "Me", icon: Icon(Icons.person)),
      ]),
    );
  }
}
