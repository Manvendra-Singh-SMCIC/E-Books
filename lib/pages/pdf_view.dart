// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViews extends StatelessWidget {
  final tabItems;
  int i;
  PdfViews({super.key, this.tabItems, required this.i});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(tabItems[i]["title"]),
      ),
      body: Container(
        child: PDF(
        enableSwipe: true,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
            ).cachedFromUrl('https://drive.google.com/uc?export=download&id=17Lw4Q2GHbuZJmB8WS3pNpRnC1Zbvc3oc')
      ),
    );
  }
}
