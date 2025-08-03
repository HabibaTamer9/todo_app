import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/componant/itemshow.dart';

import '../componant/data.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context , notes , child){
        return  SizedBox(
          height: MediaQuery.of(context).size.height*0.8,
          child: ListView.builder(
              itemCount: TaskData.tasks.length,
              itemBuilder: (context , i ) {
                return ItemShow(index: i);
              }
          ),
        );
      },

    );
  }
}
