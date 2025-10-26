import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Controller/Providers/VisitProvider.dart';
import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/Model/Classes/Visit.dart';
import '../../../Core/View/Reusable widgets/MyTextBox.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';

class LastSingleFollowUpInfo extends StatefulWidget {
  final Client client;
  const LastSingleFollowUpInfo({super.key, required this.client});

  @override
  State<LastSingleFollowUpInfo> createState() => _LastSingleFollowUpInfoState();
}

class _LastSingleFollowUpInfoState extends State<LastSingleFollowUpInfo> {
  late Future<Visit?> _lastVisitFuture;

  @override
  void initState() {
    super.initState();
    _lastVisitFuture = _fetchLastVisit();
  }

  Future<Visit?> _fetchLastVisit() async {
    if (!mounted) return null;
    if (widget.client.mLastVisitId != null) {
      final visit = await context
          .read<VisitProvider>()
          .getVisit(widget.client.mLastVisitId!);
      return visit;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: myCard(
        "اخر متابعة",
        FutureBuilder<Visit?>(
          future: _lastVisitFuture,
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
                    title: '(BMI) مؤشر كتلة الجسم',
                    value: visit?.mBMI.toString() ?? 'لا يوجد مؤشر كتلة الجسم',
                  ),
                  MyTextBox(
                    title: "الوزن (كجم)",
                    value: visit?.mWeight.toString() ?? 'لا يوجد وزن متابعة',
                  ),
                  MyTextBox(
                      title: "إسم النظام",
                      value: visit?.mDiet ?? 'لا يوجد نظام متابعة'),
                  MyTextBox(
                    title: "تاريخ",
                    value: visit?.mDate.toLocal().toString().split(' ')[0] ??
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
    );
  }
}
