import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/componant/data.dart';
import 'package:todo_app/componant/textfield.dart';
import 'package:todo_app/home.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
 String selectedDate = "" ;
 String taskname ="";
 String taskdiscription ="";
 TextEditingController nameController = TextEditingController();
 TextEditingController desController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

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
      body : Form(
        key: keyForm,
        child: SingleChildScrollView(
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(8)
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15),
                height: 60,
                width: MediaQuery.of(context).size.width,

                child: Text(
                  selectedDate.isEmpty ? "Select a date ":
                  "task date is ${selectedDate}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.w500
                  ),
                ),
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
                  onPressed: ()  {
                    if (selectedDate.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Missing Date"),
                          content: Text("Please select a date before saving the task."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                      return;
                    }
                    if (keyForm.currentState!.validate()){
                    TaskData().AddTaskData(selectedDate, nameController.text, desController.text);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()),(route)=>false);
                   }
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
      ),

    );
  }
}
