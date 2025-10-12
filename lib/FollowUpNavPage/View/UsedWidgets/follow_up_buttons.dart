import 'package:flutter/material.dart';
import 'package:vera_clinic/BiweeklyFollowUp/View/BiweeklyFollowUp.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyNavigationButton.dart';
import 'package:vera_clinic/SingleFollowUp/View/SingleFollowUp.dart';

class FollowUpButtons extends StatelessWidget {
  final Client client;

  const FollowUpButtons({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyNavigationButton(
          mButtonText: "متابعة أسبوعين",
          mButtonIcon: Icons.calendar_month_rounded,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BiweeklyFollowUp(client: client)));
          },
        ),
        MyNavigationButton(
          mButtonText: "متابعة منفردة",
          mButtonIcon: Icons.calendar_today_rounded,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SingleFollowUp(client: client)));
          },
        ),
      ],
    );
  }
}

