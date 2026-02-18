import 'package:flutter/material.dart';

class TextFieldBuilder extends StatelessWidget {
  const TextFieldBuilder(
      {super.key, required this.title, this.controller, this.maxLength});

  final String title;
  final TextEditingController? controller;

  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) => val!.isEmpty ? 'required' : null,
            controller: controller,
            maxLines: maxLength,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.red.shade900, width: 2)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.red.shade900, width: 2)),
                errorStyle: TextStyle(fontSize: 17)),
          ),
        )
      ],
    );
  }
}
