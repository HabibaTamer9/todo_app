import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/componant/data.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    startTimer();
    super.initState();
  }
  fetchData() async {
    var response = await http.get(Uri.parse("https://shrimo.com/fake-api/todos"));
    var tasks = jsonDecode(response.body);
    if(response.statusCode==200) {
      TaskData.tasks = tasks;
    }else {
      TaskData().message = "error in fetching date";
    }
  }

  startTimer() async {
    await fetchData();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=>Home()),
        (route) => false,);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.deepPurple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.checklist ,color: Colors.white,size: 100,),
              Text("Manege your life", style: TextStyle(color: Colors.white,fontSize: 33),),
              Text("schedule your day easy", style: TextStyle(color: Colors.white,fontSize: 18),)
            ],
          ),
        ),
    );
  }
}


