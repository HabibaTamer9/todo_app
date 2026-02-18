import 'package:flutter/material.dart';
import 'package:todo_app/features/home_screen/widgets/popup_child.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({
    super.key,
    this.sortFun,
    this.completedFun,
    this.notCompletedFun,
    this.allFun,
  });

  final Function()? sortFun;
  final Function()? completedFun;
  final Function()? notCompletedFun;
  final Function()? allFun;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        iconColor: Colors.white,
        iconSize: 33,
        itemBuilder: (context) => [
              //sort
              PopupMenuItem(
                  onTap: sortFun,
                  child: PopupChild(
                      text: "sort by date", icon: Icons.calendar_month)),
              // complete tasks
              PopupMenuItem(
                  onTap: completedFun,
                  child: PopupChild(
                      text: "Complete",
                      icon: Icons.assignment_turned_in_outlined)),
              // not complete tasks
              PopupMenuItem(
                  onTap: notCompletedFun,
                  child: PopupChild(
                      text: "Not Complete", icon: Icons.content_paste)),
              // All tasks
              PopupMenuItem(
                  onTap: allFun,
                  child: PopupChild(text: "All", icon: Icons.list)),
            ]);
  }
}
