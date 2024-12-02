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
                  NavigationButton(mButtonText: "عميل جديد", mButtonIcon: Icons.person_add,),
                  NavigationButton(mButtonText: "عميل سابق", mButtonIcon: Icons.person,),
                  NavigationButton(mButtonText: "بحث", mButtonIcon: Icons.search,),
                  NavigationButton(mButtonText: "متابعة", mButtonIcon: Icons.person_search,),
                  NavigationButton(mButtonText: "بيانات", mButtonIcon: Icons.area_chart,),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
