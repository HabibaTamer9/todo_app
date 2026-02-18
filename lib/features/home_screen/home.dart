import 'package:flutter/material.dart';
import 'package:todo_app/data/tasks_data.dart';
import 'package:todo_app/features/add_task/add_task.dart';
import 'package:todo_app/features/home_screen/widgets/task_card.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/home_screen/widgets/custom_popup_menu.dart';
import 'package:todo_app/features/home_screen/widgets/empty_container.dart';
import 'package:todo_app/features/home_screen/widgets/header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddTask()));
          },
          child: SafeArea(
              child: Icon(
            Icons.add,
            size: 33,
          )),
        ),
        body: Consumer<TasksData>(builder: (context, notes, child) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.28,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.deepPurple,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomPopupMenu(
                                sortFun: () => notes.sortData(),
                                completedFun: () => notes.completedTasks(),
                                notCompletedFun: () =>
                                    notes.notCompletedTasks(),
                                allFun: () => notes.allTasks(),
                              ),
                            ]),
                        SizedBox(height: 8),
                        Header()
                      ],
                    ),
                  ),
                ),
                TasksData.tasksBox.isEmpty
                    ? EmptyContainer()
                    : Positioned(
                        top: MediaQuery.of(context).size.height * 0.2,
                        right: 0,
                        left: 0,
                        child: TaskCard(),
                      )
              ],
            ),
          );
        }));
  }
}
