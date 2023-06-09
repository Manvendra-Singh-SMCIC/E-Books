import 'package:book_reader_app/app_style/style.dart';
import 'package:book_reader_app/constants/sizes.dart';
import 'package:book_reader_app/pages/my_stories/story_card.dart';
import 'package:book_reader_app/pages/my_stories/story_editor.dart';
import 'package:book_reader_app/pages/my_stories/story_reader.dart';
import 'package:book_reader_app/widgets/app_large_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors/app_colors.dart';

class WriteMyStories extends StatefulWidget {
  const WriteMyStories({super.key});

  @override
  State<WriteMyStories> createState() => _WriteMyStoriesState();
}

class _WriteMyStoriesState extends State<WriteMyStories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        toolbarHeight: Sizes.screenHeight / 13,
        backgroundColor: AppColors.themeColor,
        title: Text(
          "My Stories",
          style: TextStyle(
            fontFamily: "Samantha",
            fontSize: Sizes.screenHeight / 30,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.05),
        padding: EdgeInsets.all(Sizes.screenHeight/50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading
            Center(
                child: AppLargeText(
              text: "My recent stories...",
              size: Sizes.screenHeight / 40,
              color: AppColors.black,
              fontfamily: "Samantha",
            )),
            SizedBox(height: Sizes.screenHeight/40),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("mystories")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map((note) => storyCard(() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return StoryReaderScreen(doc: note);
                            },));
                          }, note))
                          .toList(),
                    );
                  }
                  return Text(
                    "No Stories",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.themeColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const StoryEditor();
          },));
        },
        label: const Text("Add Story"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
