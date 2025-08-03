import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Task/edit.dart';
import 'data.dart';

class ItemShow extends StatefulWidget {
  const ItemShow({super.key, required this.index});
  final int index ;

  @override
  State<ItemShow> createState() => _ItemShowState();
}

class _ItemShowState extends State<ItemShow> {
  List task = TaskData.tasks;
  int i = 0  ;

  @override
  void initState() {
    i = widget.index  ;
    // TODO: implement initState
    task = TaskData.tasks;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
        builder: (context, notes, child) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  children: [
                    Checkbox(
                      value: TaskData.tasks[i]["status"] == "Not Started"
                          ? false
                          : true,
                      onChanged: (val) {
                        setState(() {
                          if (val == false) {
                            TaskData.tasks[i]["status"] = "Not Started";
                            TaskData().editTaskData(
                                TaskData.tasks[i]["_id"],
                                TaskData.tasks[i]["dueDate"],
                                TaskData.tasks[i]["title"],
                                TaskData.tasks[i]["description"],
                                "Not Started"
                            );
                          } else {
                            TaskData.tasks[i]["status"] = "Completed";
                            TaskData().editTaskData(
                                TaskData.tasks[i]["_id"],
                                TaskData.tasks[i]["dueDate"],
                                TaskData.tasks[i]["title"],
                                TaskData.tasks[i]["description"],
                                "Completed"
                            );
                          }
                        });
                      },
                    ),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.78,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  TaskData.tasks[i]['title'],
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    decoration: TaskData.tasks[i]["status"] == "Completed"
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              PopupMenuButton(itemBuilder: (context) =>
                              [
                                // delete
                                PopupMenuItem(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => Center(child: CircularProgressIndicator()),
                                      );
                                      await context.read<TaskData>().delete(
                                          TaskData.tasks[i]["_id"]);
                                      Navigator.of(context).pop();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete,
                                          color: Colors.red.shade400,),
                                        SizedBox(width: 10,),
                                        Text(
                                          "delete",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red.shade400
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                // edit
                                PopupMenuItem(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              Edit(index: i,)));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit, color: Colors.black54,),
                                        SizedBox(width: 10,),
                                        Text(
                                          "edit",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54
                                          ),
                                        ),
                                      ],
                                    )),
                              ]),
                            ],
                          ),
                          //description
                          Text(
                            TaskData.tasks[i]['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 18
                            ),
                          ),
                          //date
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.78,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.grey.shade300
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month, color: Colors.black54,),
                                SizedBox(width: 8,),
                                Text(
                                  DateFormat('d MMM yyyy').format(
                                      DateTime.parse(TaskData.tasks[i]['dueDate'])),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87
                                  ),
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.4, color: Colors.grey)
                  ),
                ),
              )
            ],
          );
        });
  }
}
