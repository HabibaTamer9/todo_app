
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TaskData extends ChangeNotifier{
  static bool selection = false;
 static List tasks = [
   {
     "date" : "29 May 2025" ,
     "name" : "Flutter" ,
     "description" : "Learn flutter",
     "isComplete" : false
   },
   {
     "date" : "30 May 2025" ,
     "name" : "Provider" ,
     "description" : "learn Provider",
     "isComplete" : false
   },
   {
     "date" : "28 May 2025" ,
     "name" : "Make todo App " ,
     "description" : "Making app",
     "isComplete" : false
   },
 ];

  void AddTaskData(String date, String name, String description) {
    tasks.add(
      {
        "date" : date ,
        "name" : name ,
        "description" : description,
        "isComplete" : false
      }
    );
    notifyListeners();
  }

  void EditTaskData(int i ,String date, String name, String description) {
    tasks[i]["name"] = name ;
    tasks[i]["description"] = description ;
    tasks[i]["date"] = date ;
    notifyListeners();
  }

  Delete(int index){
    tasks.removeAt(index);
    notifyListeners();
  }

  sortData(){
    final dateFormat = DateFormat('d MMM yyyy');

    tasks.sort((a, b) {
      DateTime dateA = dateFormat.parse(a['date']);
      DateTime dateB = dateFormat.parse(b['date']);

      return dateA.compareTo(dateB);
      // return dateB.compareTo(dateA);
    });
    notifyListeners();
  }
}
