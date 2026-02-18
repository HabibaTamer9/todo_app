import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task_model.dart';

class TasksData extends ChangeNotifier {
  static Box<TaskModel> tasksBox = Hive.box<TaskModel>('tasksBox');
  static List<TaskModel> tasksList = tasksBox.values.toList();

  Future<void> getTasks() async {
    tasksBox = Hive.box<TaskModel>('tasksBox');
    tasksList = tasksBox.values.toList();
    notifyListeners();
  }

  Future<void> addTask(
      {required String title,
      required String description,
      required String date}) async {
    TaskModel task = TaskModel(
        title: title, description: description, date: date, isCompleted: false);
    tasksBox.add(task);
    tasksList = tasksBox.values.toList();
    notifyListeners();
  }

  Future<void> editTask(
      {required int index,
      required String title,
      required String description,
      required String date}) async {
    TaskModel? task = tasksBox.getAt(index);
    task!.title = title;
    task.date = date;
    task.description = description;

    notifyListeners();
  }

  Future<void> deleteTask(int index) async {
    tasksBox.deleteAt(index);
    getTasks();
    notifyListeners();
  }

  Future<void> deleteAllTasks() async {
    await tasksBox.clear();
    notifyListeners();
  }

  sortData() {
    DateFormat format = DateFormat("dd MMM yyyy");

    tasksList.sort((a, b) {
      DateTime dateA = format.parse(a.date);
      DateTime dateB = format.parse(b.date);

      return dateA.compareTo(dateB); // تصاعدي
      // return dateB.compareTo(dateA); // تنازلي
    });

    notifyListeners();
  }

  completedTasks() {
    tasksList = tasksBox.values.toList();
    tasksList = tasksList.where((task) => task.isCompleted == true).toList();

    notifyListeners();
  }

  notCompletedTasks() {
    tasksList = tasksBox.values.toList();
    tasksList = tasksList.where((task) => task.isCompleted == false).toList();

    notifyListeners();
  }

  allTasks() {
    tasksList = tasksBox.values.toList();

    notifyListeners();
  }
}
