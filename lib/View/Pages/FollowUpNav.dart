import 'package:flutter/material.dart';

import '../Reusable widgets.dart';

class FollowUpNav extends StatefulWidget {
  const FollowUpNav({super.key});

  @override
  State<FollowUpNav> createState() => _FollowUpNavState();
}

class _FollowUpNavState extends State<FollowUpNav> {
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
                  NavigationButton(mButtonText: "متابعة شهرية", mButtonIcon: Icons.calendar_month,),
                  NavigationButton(mButtonText: "متابعة اسبوعية", mButtonIcon: Icons.calendar_today,),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
