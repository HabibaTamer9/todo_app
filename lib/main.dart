import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/tasks_data.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskModelAdapter());

  await Hive.openBox<TaskModel>('tasksBox');

  runApp(const MyApp());
  runApp(ChangeNotifierProvider(
      create: (context) => TasksData(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
