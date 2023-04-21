import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopupMenu({super.key, required this.menuList, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton(
        itemBuilder: (context) => menuList,
        icon: icon,
      ),
    );
  }
}
