
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TaskData extends ChangeNotifier{
  String message = "";
  static String selection = "";
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

  fetchData() async {
    message = "";
    var response = await http.get(Uri.parse("https://shrimo.com/fake-api/todos"));
    var allTask = jsonDecode(response.body);
    if(response.statusCode==200) {
      tasks = allTask;
    }else {
      message = "error in fetching date";
    }
  }

  Future<void> addTaskData(String date, String name, String description) async {
    message = "";
    var response = await http.post(
      Uri.parse('https://shrimo.com/fake-api/todos'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': name,
        'dueDate': date,
        'description': description,
        'status': "Not Started",
        "priority": "High",
        "tags": ["JavaScript", "Learning"],
      }),
    );
    if(response.statusCode != 500) {
      await fetchData();
      message = "Success";
    }else {
      message = "unsuccessful : ${response.body}";
    }
    notifyListeners();
  }

  Future<void> editTaskData(String id ,String date, String name, String description ,[ String isCompleted = "Not Started"]) async {
    message = "";
    var response = await http.put(
      Uri.parse('https://shrimo.com/fake-api/todos/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': name,
        'dueDate': date,
        'description': description,
        'status': isCompleted,
        "priority": "High",
        "tags": ["JavaScript", "Learning"],
      }),
    );
    if(response.statusCode != 500) {
      await fetchData();
      message = "Success";
    }else {
      message = "unsuccessful : ${response.body}";
    }
    notifyListeners();
  }

  delete(String id) async {
    message = "";
    var response = await http.delete(
      Uri.parse('https://shrimo.com/fake-api/todos/$id')
    );
    if(response.statusCode != 500) {

      await fetchData();
      message = "Success";
    }else {
      message = "unsuccessful : ${response.body}";
    }
    notifyListeners();
  }

  sortData() {
    tasks.sort((a, b) {
      DateTime dateA = DateTime.parse(a['dueDate']);
      DateTime dateB = DateTime.parse(b['dueDate']);

      return dateA.compareTo(dateB); // تصاعدي
      // return dateB.compareTo(dateA); // تنازلي
    });

    notifyListeners();
  }
}

