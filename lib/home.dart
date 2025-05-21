import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Task/add_task.dart';
import 'package:todo_app/componant/data.dart';
import 'package:todo_app/Task/selectedCard.dart';
import 'package:todo_app/Task/taskCard.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List task = TaskData.tasks;
  bool status = false ;
  String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> TaskData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
          },
          child: SafeArea(child: Icon(Icons.add,size: 33,)),
        ),
        body:
        Consumer<TaskData>(
          builder: (context , notes ,child){
            return
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.28,
                    width: 1000,
                    color: Colors.deepPurple,
                    child: SafeArea(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton(
                                  iconColor: Colors.white,
                                  iconSize: 33,
                                  itemBuilder: (context) =>[
                                    //sort
                                    PopupMenuItem(
                                        onTap: (){
                                          context.read<TaskData>().sortData();
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_month ,color: Colors.black54,),
                                            SizedBox(width: 10,),
                                            Text(
                                              "sort by date" ,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    // complete tasks
                                    PopupMenuItem(
                                        onTap: (){
                                          setState(() {
                                            TaskData.selection = true;
                                            status = true ;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.assignment_turned_in_outlined ,color: Colors.black54,),
                                            SizedBox(width: 10,),
                                            Text(
                                              "Complete" ,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    // not complete tasks
                                    PopupMenuItem(
                                        onTap: (){
                                          setState(() {
                                            TaskData.selection = false;
                                            status = true ;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.content_paste , color: Colors.black54,),
                                            SizedBox(width: 10,),
                                            Text(
                                              "Not Complete",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54
                                              ),
                                            ),
                                          ],
                                        )),
                                    // All tasks
                                    PopupMenuItem(
                                        onTap: (){
                                          setState(() {
                                            status = false ;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.list , color: Colors.black54,),
                                            SizedBox(width: 10,),
                                            Text(
                                              "All",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54
                                              ),
                                            ),
                                          ],
                                        )),
                                  ]
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "My Todo List",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TaskData.tasks.isEmpty ?
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.playlist_add ,color: Colors.deepPurple.shade400,size: 100,),
                        Text("Add your tasks",
                          style: TextStyle(
                              color: Colors.deepPurple.shade400,
                              fontSize: 33,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  )
                  :Positioned(
                    top: MediaQuery.of(context).size.height*0.2,
                    right: 0,
                    left: 0,
                    child: status ?
                      SelectedCard():
                      TaskCard(),
                  )
                ],
              ),
            );
          }
        )


      ),
    );
  }
}
