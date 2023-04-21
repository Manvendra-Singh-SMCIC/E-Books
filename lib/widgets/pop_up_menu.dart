import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../pages/my_stories/story_reader.dart';

class PopupMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  final Function()? onTap;
  final QueryDocumentSnapshot doc;
  const PopupMenu(
      {super.key,
      required this.menuList,
      this.icon,
      required this.doc,
      required this.onTap});

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
            final Email email = Email(
              body: doc["note_content"],
              subject: doc["note_title"],
              recipients: ["12a.manvendrasingh@gmail.com"],
              //cc: ['cc@example.com'],
              //bcc: ['bcc@example.com'],
              //attachmentPaths: ['/path/to/attachment.zip'],
              isHTML: false,
            );

            await FlutterEmailSender.send(email);

            break;
        }
      },
    );
  }
}
