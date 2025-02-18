import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/HomePage/HomePage.dart';
import 'package:vera_clinic/MonthlyFollowUp/View/MonthlyFollowUp.dart';
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyNavigationButton(
                      mButtonText: "متابعة شهرية",
                      mButtonIcon: Icons.calendar_month,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MonthlyFollowUp(client: widget.client)));
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
                const SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () async {
                    await context
                        .read<ClinicProvider>()
                        .checkOutClient(widget.client);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.check, color: Colors.redAccent),
                      SizedBox(width: 12),
                      Text('تسجيل خروج',
                          style:
                              TextStyle(fontSize: 16, color: Colors.redAccent)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
