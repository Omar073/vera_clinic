import 'package:flutter/material.dart';
import 'package:vera_clinic/View/Pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));
  }
}
