import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/my_stories/story_reader.dart';

class PopupMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  final Function()? onTap;
  final QueryDocumentSnapshot doc;
  const PopupMenu({
    super.key,
    required this.menuList,
    this.icon,
    required this.doc,
    required this.onTap,
  });

  Future launchEmail({
    required String toEmail,
    required String subject,
    required String message,
  }) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => menuList,
      icon: icon,
      color: const Color.fromARGB(255, 240, 240, 240),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      onSelected: (value) async {
        switch (value) {
          case "Delete":
            FirebaseFirestore.instance
                .collection("mystories")
                .doc(doc["id"])
                .delete();
            break;
          case "Edit":
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return StoryReaderScreen(doc: doc);
              },
            ));
            break;
          case "Send":
            launchEmail(
              toEmail: "12a.manvendrasingh@gmail.com",
              subject: "Story",
              message: doc["note_title"] + "\n" + doc["note_content"],
            );

            break;
        }
      },
    );
  }
}
