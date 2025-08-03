import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../componant/textfield.dart';
import '../home.dart';
import '../componant/data.dart';

class Edit extends StatefulWidget {
  final int index ;
  const Edit( {super.key, required this.index});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String selectedDate = "" ;
  String taskname ="";
  String taskdiscription ="";
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  int i = 0 ;
  String id = "";
  String title = "" ;
  String description = "" ;


  @override
  void initState() {
    i = widget.index ;
    id = TaskData.tasks[i]["_id"];
    nameController.text = TaskData.tasks[i]["title"];
    desController.text = TaskData.tasks[i]["description"];
    _selectedDay = DateTime.parse(TaskData.tasks[i]["dueDate"]);
    selectedDate = DateFormat('d MMM yyyy').format(_selectedDay!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add task",style: TextStyle(color: Colors.black,fontSize: 28),),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(Icons.arrow_back,color: Colors.black,size: 30,)),
      ),
      body : SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              //calender
              Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        selectedDate = DateFormat('d MMM yyyy').format(selectedDay);
                      });
                    },
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        shape: BoxShape.circle,
                      ),
                      outsideDaysVisible: false,
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: true,
                      titleCentered: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      formatButtonTextStyle: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                      leftChevronIcon: Icon(Icons.chevron_left, color: Colors.deepPurple),
                      rightChevronIcon: Icon(Icons.chevron_right, color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
              //title
              TextFieldBuilder(
                title: "Title",
                controller: nameController,
                maxLength: 1,
              ),
              //description
              TextFieldBuilder(
                title: "Description",
                controller: desController,
                maxLength: 3,
              ),
              //save button
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: MaterialButton(
                  onPressed: ()  async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Center(child: CircularProgressIndicator()),
                    );
                    await TaskData().editTaskData( id, selectedDate, nameController.text, desController.text );
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context)=>Home()),
                            (route) => false,);
                  },
                  minWidth: 100,
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // change the value as you like
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              )
            ],),
        ),
      ),

    );
  }
}
