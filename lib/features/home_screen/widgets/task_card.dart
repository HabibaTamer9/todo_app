import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/home_screen/widgets/itemshow.dart';
import 'package:todo_app/data/tasks_data.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksData>(
      builder: (context , notes , child){
        return  SizedBox(
          height: MediaQuery.of(context).size.height*0.8,
          child: ListView.builder(
              itemCount: TasksData.tasksList.length,
              itemBuilder: (context , i ) {
                var task = TasksData.tasksList[i];
                return ItemShow(task: task,index: i,);
              }
          ),
        );
      },

    );
  }
}
