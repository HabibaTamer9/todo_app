import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Header extends StatelessWidget {
  Header({super.key});

  String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          formattedDate,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 8),
        Text(
          "My Todo List",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
