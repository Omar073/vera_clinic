import 'package:flutter/material.dart';

class NewVisit extends StatefulWidget {
  const NewVisit({super.key});

  @override
  State<NewVisit> createState() => _NewVisitState();
}

class _NewVisitState extends State<NewVisit> {
  int visitCounter = 1;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${visitCounter}زيارة # "),
      ),
    );
  }
}
