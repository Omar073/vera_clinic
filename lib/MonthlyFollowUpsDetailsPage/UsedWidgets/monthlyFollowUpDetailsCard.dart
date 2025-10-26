import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyTextBox.dart';
import 'package:vera_clinic/Core/View/Reusable widgets/myCard.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/View/PopUps/MyAlertDialogue.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/UpdateMonthlyFollowUpDetailsPage/UpdateMonthlyFollowUpDetailsPage.dart';

class MonthlyFollowUpDetailsCard extends StatefulWidget {
  final ClientMonthlyFollowUp cmfu;
  final int index;
  final VoidCallback? onDeleted;

  const MonthlyFollowUpDetailsCard({
    super.key,
    required this.cmfu,
    required this.index,
    this.onDeleted,
  });

  @override
  State<MonthlyFollowUpDetailsCard> createState() => _MonthlyFollowUpDetailsCardState();
}

class _MonthlyFollowUpDetailsCardState extends State<MonthlyFollowUpDetailsCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: myCard(
        'متابعة رقم ${widget.index}',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    showAlertDialogue(
                      context: context,
                      title: "تأكيد الحذف",
                      content: "هل أنت متأكد أنك تريد حذف هذه المتابعة؟",
                      buttonText: "حذف",
                      returnText: "رجوع",
                      onPressed: () async {
                        await context
                            .read<ClientMonthlyFollowUpProvider>()
                            .deleteClientMonthlyFollowUp(widget.cmfu.mClientMonthlyFollowUpId);
                        Navigator.pop(context);
                        widget.onDeleted!();
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.clear),
                  label: const Text('مسح'),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateMonthlyFollowUpDetailsPage(
                              cmfu: widget.cmfu,
                              onMonthlyFollowUpUpdated: () {
                                setState(() {});
                              },
                            ),
                          ));
                    },
                    label: const Text("تعديل"),
                    icon: const Icon(Icons.edit)),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Wrap(
                      textDirection: TextDirection.rtl,
                      alignment: WrapAlignment.end,
                      spacing: 70,
                      runSpacing: 20,
                      children: [
                        MyTextBox(
                            title: 'التاريخ', value: getDateText(widget.cmfu.mDate)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Wrap 1: BMI | Water | MuscleMass
                    Wrap(
                      textDirection: TextDirection.rtl,
                      alignment: WrapAlignment.end,
                      spacing: 70,
                      runSpacing: 20,
                      children: [
                        MyTextBox(
                            title: '(BMI) مؤشر كتلة الجسم',
                            value: widget.cmfu.mBMI?.toString() ?? '0'),
                        MyTextBox(title: 'الماء', value: widget.cmfu.mWater ?? ''),
                        MyTextBox(
                            title: 'كتلة العضلات',
                            value: widget.cmfu.mMuscleMass?.toString() ?? '0'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Wrap 2: PBF | BMR | [empty]
                    Wrap(
                      textDirection: TextDirection.rtl,
                      alignment: WrapAlignment.end,
                      spacing: 70,
                      runSpacing: 20,
                      children: [
                        MyTextBox(
                            title: '(PBF) نسبة الدهون ',
                            value: widget.cmfu.mPBF?.toString() ?? '0'),
                        MyTextBox(
                            title: '(BMR) معدل الحرق الأساسي',
                            value: widget.cmfu.mBMR?.toString() ?? '0'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Wrap 3: MaxWeight | OptimalWeight | MaxCalories | DailyCalories
                    Wrap(
                      textDirection: TextDirection.rtl,
                      alignment: WrapAlignment.end,
                      spacing: 50,
                      runSpacing: 20,
                      children: [
                        MyTextBox(
                            title: 'الوزن الأقصى (كجم)',
                            value: widget.cmfu.mMaxWeight?.toString() ?? '0'),
                        MyTextBox(
                            title: 'الوزن المثالي (كجم)',
                            value: widget.cmfu.mOptimalWeight?.toString() ?? '0'),
                        MyTextBox(
                            title: 'السعرات القصوى',
                            value: widget.cmfu.mMaxCalories?.toString() ?? '0'),
                        MyTextBox(
                            title: 'السعرات اليومية',
                            value: widget.cmfu.mDailyCalories?.toString() ?? '0'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Notes section
                      Wrap(
                        textDirection: TextDirection.rtl,
                        alignment: WrapAlignment.end,
                        spacing: 70,
                        runSpacing: 20,
                        children: [
                          MyTextBox(
                            title: 'ملاحظات',
                            value: widget.cmfu.mNotes ?? '',
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
