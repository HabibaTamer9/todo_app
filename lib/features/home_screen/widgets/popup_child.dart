import 'package:flutter/material.dart';

class PopupChild extends StatelessWidget {
  const PopupChild({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon , color: Colors.black54,),
        SizedBox(width: 10,),
        Text(
          text,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black54
          ),
        ),
      ],
    );
  }
}
