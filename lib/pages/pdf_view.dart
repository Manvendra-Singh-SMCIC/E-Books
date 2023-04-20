// ignore_for_file: must_be_immutable, depend_on_referenced_packages, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViews extends StatelessWidget {
  QueryDocumentSnapshot doc;
  PdfViews({super.key, required this. doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(doc["title"]),
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
            ).cachedFromUrl(doc["pdf"])
      ),
    );
  }
}
