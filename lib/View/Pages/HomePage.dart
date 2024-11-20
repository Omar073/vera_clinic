import 'package:flutter/material.dart';
import 'package:vera_clinic/View/Reusable%20widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vera-Life Clinic'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavigationButton(mType: "new client"),
                  NavigationButton(mType: "previous client"),
                  NavigationButton(mType: "follow-up"),
                  NavigationButton(mType: "analysis"),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
