import 'package:flutter/material.dart';
import 'features/home_screen/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState

    startTimer();
    super.initState();
  }

  startTimer() async {
    Future.delayed(const Duration(seconds: 3), () {
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


