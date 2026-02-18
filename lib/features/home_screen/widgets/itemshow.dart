import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/tasks_data.dart';
import 'package:todo_app/models/task_model.dart';

import '../../edit_screen/edit.dart';

class ItemShow extends StatefulWidget {
  const ItemShow({super.key, required this.task, required this.index});

  final TaskModel task;
  final int index;

  @override
  State<ItemShow> createState() => _ItemShowState();
}

class _ItemShowState extends State<ItemShow> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksData>(builder: (context, notes, child) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              children: [
                Checkbox(
                  value: widget.task.isCompleted == false ? false : true,
                  onChanged: (val) {
                    setState(() {
                      if (val == false) {
                        widget.task.isCompleted = false;
                      } else {
                        widget.task.isCompleted = true;
                      }
                    });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.78,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.task.title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                decoration: widget.task.isCompleted == true
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          PopupMenuButton(
                              itemBuilder: (context) => [
                                    // delete
                                    PopupMenuItem(
                                        onTap: () async {
                                          await notes.deleteTask(widget.index);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: Colors.red.shade400,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "delete",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.red.shade400),
                                            ),
                                          ],
                                        )),
                                    // edit
                                    PopupMenuItem(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Edit(
                                                        index: widget.index,
                                                    task: widget.task,
                                                      )));
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "edit",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        )),
                                  ]),
                        ],
                      ),
                      //description
                      Text(
                        widget.task.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black45, fontSize: 18),
                      ),
                      //date
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        width: MediaQuery.of(context).size.width * 0.78,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.shade300),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.task.date,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.4, color: Colors.grey)),
            ),
          )
        ],
      );
    });
  }
}
