import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/data/tasks_data.dart';
import 'package:todo_app/models/task_model.dart';
import '../../core/textfield.dart';
import '../home_screen/home.dart';

class Edit extends StatefulWidget {
  const Edit({super.key, required this.index, required this.task});

  final int index;
  final TaskModel task;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String selectedDate = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  int i = 0;

  @override
  void initState() {
    i = widget.index;
    nameController.text = widget.task.title;
    desController.text = widget.task.description;
    selectedDate = widget.task.date;
    DateFormat format = DateFormat("dd MMM yyyy");
    _selectedDay = format.parse(selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit task",
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            )),
      ),
      body: Form(
        key: keyForm,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                //calender
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
                    leftChevronIcon:
                        Icon(Icons.chevron_left, color: Colors.deepPurple),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: Colors.deepPurple),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(15),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    selectedDate.isEmpty
                        ? "Select date "
                        : "task date is $selectedDate",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.w500),
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
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: MaterialButton(
                    onPressed: () async {
            if (keyForm.currentState!.validate()) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              Center(child: CircularProgressIndicator()),
        );
        await TasksData().editTask(
            index: i,
            title: nameController.text,
            description: desController.text,
            date: selectedDate);
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
              (route) => false,
        );
            }
                    },
                    minWidth: 100,
                    color: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // change the value as you like
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
