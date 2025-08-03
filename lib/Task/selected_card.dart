import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/componant/itemshow.dart';

import '../componant/data.dart';

class SelectedCard extends StatefulWidget {
  const SelectedCard({super.key});

  @override
  State<SelectedCard> createState() => _SelectedCardState();
}

class _SelectedCardState extends State<SelectedCard> {
  List task = TaskData.tasks;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
        builder: (context, notes, child) {
          return SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: ListView.builder(
                itemCount: TaskData.tasks.length,
                itemBuilder: (context, i) {
                  if (TaskData.tasks[i]["status"] == TaskData.selection) {
                    return ItemShow(index: i);
                  } else {
                    return SizedBox.shrink();
                  }
                }
            ),
          );
        });
  }
}
