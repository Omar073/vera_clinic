import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyInputField.dart';
import 'package:vera_clinic/WeeklyFollowUp/Controller/UtilityFunctions.dart';

import '../../Core/Controller/Providers/ClientProvider.dart';
import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import '../Controller/WeeklyFollowUpTEC.dart';

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
    initVisitTEC();
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
        title: Text('${widget.client.mName!} :متابعة اسبوعية, عميل '),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: myCard(
                  //todo: extract
                  "متابعة اسبوعية",
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Wrap(
                          spacing: 60,
                          children: [
                            Text(
                                "${widget.client.mDiet ?? 'No Diet'} :إسم النظام الحالي ",
                                style: const TextStyle(fontSize: 20)),
                            Text(
                                "الوزن: ${widget.client.mWeight ?? 'No weight'}",
                                style: const TextStyle(fontSize: 20)),
                            Text(
                              'السن: ${getAge(widget.client.mBirthdate) ?? 'No age'}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              '${widget.client.mName ?? 'No name'} :الإسم',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: myCard(
                "اخر متابعة",
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Wrap(
                      spacing: 60,
                      children: [
                        FutureBuilder<Visit?>(
                          //todo: merge into one future builder
                          future: _lastVisitDate,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                "نظام اخر متابعة: Loading...",
                                style: TextStyle(fontSize: 20),
                              );
                            } else if (snapshot.hasError) {
                              return const Text(
                                "نظام اخر متابعة: Error",
                                style: TextStyle(fontSize: 20),
                              );
                            } else {
                              return Text(
                                "${snapshot.data?.mDiet ?? 'No last visit diet'} :نظام اخر متابعة ",
                                style: const TextStyle(fontSize: 20),
                              );
                            }
                          },
                        ),
                        FutureBuilder<Visit?>(
                          future: _lastVisitDate,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                "وزن اخر متابعة: Loading...",
                                style: TextStyle(fontSize: 20),
                              );
                            } else if (snapshot.hasError) {
                              return const Text(
                                "وزن اخر متابعة: Error",
                                style: TextStyle(fontSize: 20),
                              );
                            } else {
                              return Text(
                                "وزن اخر متابعة: ${snapshot.data?.mWeight ?? 'No last visit weight'}",
                                style: const TextStyle(fontSize: 20),
                              );
                            }
                          },
                        ),
                        FutureBuilder<Visit?>(
                          future: _lastVisitDate,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                "تاريخ اخر متابعة: Loading...",
                                style: TextStyle(fontSize: 20),
                              );
                            } else if (snapshot.hasError) {
                              return const Text(
                                "تاريخ اخر متابعة: Error",
                                style: TextStyle(fontSize: 20),
                              );
                            } else {
                              return Text(
                                "تاريخ اخر متابعة: ${snapshot.data?.mDate.toLocal().toString().split(' ')[0] ?? 'No last visit date'}",
                                style: const TextStyle(fontSize: 20),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: myCard(
                  "بيانات الزيارة",
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Wrap(
                          spacing: 60,
                          children: [
                            MyInputField(
                              myController: visitDietController,
                              hint: "",
                              label: "اسم النظام",
                            ),
                            MyInputField(
                              myController: visitWeightController,
                              hint: "",
                              label: "الوزن",
                            ),
                            MyInputField(
                              myController: visitBMIController,
                              hint: "",
                              label: "مؤشر كتلة الجسم",
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: myCard(
                  "بيانات الزيارة",
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                            child: MyInputField(
                                myController: visitNotesController,
                                hint: '',
                                label: "ملاحظات"))
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                bool success = await createVisit(widget.client, context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? 'Client registration successful'
                        : 'Client registration failed'),
                    backgroundColor: success ? Colors.green : Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
                if (success) {
                  Navigator.pop(context);
                  disposeVisitTEC();
                }
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check, color: Colors.blueAccent),
                  SizedBox(width: 12),
                  Text('حفظ',
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
