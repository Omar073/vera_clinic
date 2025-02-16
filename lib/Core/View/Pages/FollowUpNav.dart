import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/WeeklyFollowUp/View/WeeklyFollowUp.dart';
import '../Reusable widgets/MyNavigationButton.dart';

class FollowUpNav extends StatefulWidget {
  final Client client;
  const FollowUpNav({super.key, required this.client});

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
                MyNavigationButton(
                  mButtonText: "متابعة شهرية",
                  mButtonIcon: Icons.calendar_month,
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const FollowUpNav()));
                  },
                ),
                MyNavigationButton(
                  mButtonText: "متابعة اسبوعية",
                  mButtonIcon: Icons.calendar_today,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WeeklyFollowUp(client: widget.client)));
                  },
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
