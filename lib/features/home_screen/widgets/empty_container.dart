import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.playlist_add,
            color: Colors.deepPurple.shade400,
            size: 100,
          ),
          Text(
            "Add your tasks",
            style: TextStyle(
                color: Colors.deepPurple.shade400,
                fontSize: 33,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
