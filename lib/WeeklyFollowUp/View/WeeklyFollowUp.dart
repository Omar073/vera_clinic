import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/WeeklyFollowUp/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/WeeklyFollowUp/View/UsedWidgets/WFUActionButton.dart';
import 'package:vera_clinic/WeeklyFollowUp/View/UsedWidgets/WFUInfo1.dart';
import 'package:vera_clinic/WeeklyFollowUp/View/UsedWidgets/WFUInfo2.dart';

import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import '../Controller/WeeklyFollowUpTEC.dart';
import 'UsedWidgets/WFUClientInfoCard.dart';

class WeeklyFollowUp extends StatefulWidget {
  final Client client;
  const WeeklyFollowUp({super.key, required this.client});

  @override
  State<WeeklyFollowUp> createState() => _WeeklyFollowUpState();
}

class _WeeklyFollowUpState extends State<WeeklyFollowUp> {
  late Future<Visit?> _lastVisitDate;

  @override
  void initState() {
    super.initState();
    _lastVisitDate = _fetchLastVisitDate();
    WeeklyFollowUpTEC.init();
  }

  @override
  void dispose() {
    WeeklyFollowUpTEC.dispose();
    super.dispose();
  }

  Future<Visit?> _fetchLastVisitDate() async {
    final visit = await context
        .read<VisitProvider>()
        .getClientLastVisit(widget.client.mClientId);
    return visit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.client.mName!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(' :متابعة اسبوعية'),
          ],
        ),
      ),
      body: Background(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              WFUClientInfoCard(
                  widget.client, MediaQuery.of(context).size.width),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: myCard(
                  "اخر متابعة",
                  FutureBuilder<Visit?>(
                    future: _lastVisitDate,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "نظام اخر متابعة: جاري التحميل...",
                          style: TextStyle(fontSize: 20),
                        );
                      } else if (snapshot.hasError) {
                        return const Text(
                          "نظام اخر متابعة: خطأ",
                          style: TextStyle(fontSize: 20),
                        );
                      } else {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Wrap(
                              spacing: 60,
                              children: [
                                MyTextBox(
                                    title: "نظام اخر متابعة",
                                    value: snapshot.data?.mDiet ??
                                        'لا يوجد نظام متابعة'),
                                MyTextBox(
                                  title: "وزن اخر متابعة",
                                  value: snapshot.data?.mWeight.toString() ??
                                      'لا يوجد وزن متابعة',
                                ),
                                MyTextBox(
                                  title: "تاريخ اخر متابعة",
                                  value: snapshot.data?.mDate
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0] ??
                                      'لا يوجد تاريخ متابعة',
                                )
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              visitInfo1(),
              const SizedBox(height: 20),
              visitInfo2(),
              const SizedBox(height: 30),
              VisitActionButton(client: widget.client),
            ],
          ),
        )),
      ),
    );
  }
}
