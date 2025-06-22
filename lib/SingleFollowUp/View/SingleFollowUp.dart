import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/SingleFollowUp/View/UsedWidgets/SFUInfo1.dart';

import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import '../Controller/SingleFollowUpTEC.dart';
import 'UsedWidgets/SFUActionButton.dart';
import 'UsedWidgets/SFUClientInfoCard.dart';
import 'UsedWidgets/SFUInfo2.dart';

class SingleFollowUp extends StatefulWidget {
  final Client client;
  const SingleFollowUp({super.key, required this.client});

  @override
  State<SingleFollowUp> createState() => _SingleFollowUpState();
}

class _SingleFollowUpState extends State<SingleFollowUp> {
  late Future<Visit?> _lastVisitDate;

  @override
  void initState() {
    super.initState();
    _lastVisitDate = _fetchLastVisitDate();
    SingleFollowUpTEC.init();
  }

  @override
  void dispose() {
    SingleFollowUpTEC.dispose();
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
        surfaceTintColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.client.mName!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(' :متابعة منفردة'),
          ],
        ),
      ),
      body: Background(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              singleFollowUpClientInfoCard(widget.client),
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
                          "تفاصيل اخر متابعة: جاري التحميل...",
                          style: TextStyle(fontSize: 20),
                        );
                      } else if (snapshot.hasError) {
                        return const Text(
                          "تفاصيل اخر متابعة: خطأ",
                          style: TextStyle(fontSize: 20),
                        );
                      } else {
                        Visit? visit = snapshot.data;
                        return Wrap(
                          spacing: 40,
                          runSpacing: 15,
                          alignment: WrapAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            MyTextBox(
                              title: "مؤشر كتلة الجسم",
                              value: visit?.mBMI.toString() ??
                                  'لا يوجد مؤشر كتلة الجسم',
                            ),
                            MyTextBox(
                              title: "الوزن (كجم)",
                              value: visit?.mWeight.toString() ??
                                  'لا يوجد وزن متابعة',
                            ),
                            MyTextBox(
                                title: "إسم النظام",
                                value: visit?.mDiet ?? 'لا يوجد نظام متابعة'),
                            MyTextBox(
                              title: "تاريخ",
                              value: visit?.mDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0] ??
                                  'لا يوجد تاريخ متابعة',
                            ),
                            MyTextBox(
                              title: "ملاحظات",
                              value: visit?.mVisitNotes ?? 'لا توجد ملاحظات',
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              singleFollowUpInfo1(),
              const SizedBox(height: 20),
              singleFollowUpInfo2(),
              const SizedBox(height: 30),
              SingleFollowUpActionButton(client: widget.client),
            ],
          ),
        )),
      ),
    );
  }
}
