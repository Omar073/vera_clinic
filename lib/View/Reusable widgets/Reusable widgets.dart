import 'package:flutter/material.dart';
import 'package:vera_clinic/View/Pages/AnalysisPage.dart';
import 'package:vera_clinic/View/Pages/ClientSearchPage.dart';
import 'package:vera_clinic/View/Pages/FollowUpNav.dart';

import '../Pages/NewClientPage.dart';

class MyInputField extends StatefulWidget {
  final TextEditingController myController;
  final String hint;
  final String label;
  const MyInputField(
      {super.key,
      required this.myController,
      required this.hint,
      required this.label});

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TextField(
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.end,
        controller: widget.myController,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 15),
          label: Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Aligns to the other side
            children: [
              Text(
                widget.label ?? '', // Display the label text
                style: const TextStyle(
                    fontSize: 16), // Customize label style if needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatefulWidget {
  final String title;
  final String value;
  const MyTextField({super.key, required this.title, required this.value});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.value,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          " : ${widget.title}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
    //Text("${client.name} :اسم العميل", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
  }
}
