import 'package:flutter/material.dart';
import '../Reusable widgets/MyNavigationButton.dart';

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
                  MyNavigationButton(mButtonText: "متابعة شهرية", mButtonIcon: Icons.calendar_month, onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const FollowUpNav()));
                  },),
                  MyNavigationButton(mButtonText: "متابعة اسبوعية", mButtonIcon: Icons.calendar_today, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FollowUpNav()));
                  },),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
