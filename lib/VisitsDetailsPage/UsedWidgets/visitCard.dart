import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart';
import 'package:vera_clinic/VisitsDetailsPage/UsedWidgets/visitTextBox.dart';

import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../../Core/View/PopUps/MyAlertDialogue.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import '../../UpdateVisitDetailsPage/UpdateVisitDetailsPage.dart';

class VisitCard extends StatefulWidget {
  final Visit visit;
  final int index;
  final VoidCallback? onVisitDeleted;
  const VisitCard(
      {super.key,
      required this.visit,
      required this.index,
      required this.onVisitDeleted});

  @override
  State<VisitCard> createState() => _VisitCardState();
}

class _VisitCardState extends State<VisitCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: myCard(
        'زيارة رقم ${widget.index}',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showAlertDialogue(
                      context: context,
                      title: "تأكيد الحذف",
                      content: "هل أنت متأكد أنك تريد حذف هذه الزيارة؟",
                      buttonText: "حذف",
                      returnText: "رجوع",
                      onPressed: () async {
                        await context
                            .read<VisitProvider>()
                            .deleteVisit(widget.visit.mVisitId);
                        Navigator.pop(context);
                        widget.onVisitDeleted!();
                      },
                    );
                  },
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateVisitDetailsPage(
                              visit: widget.visit,
                              onVisitUpdated: () {
                                setState(() {});
                              },
                            ),
                          ));
                    },
                    label: const Text("تعديل"),
                    icon: const Icon(Icons.edit)),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
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
                        visitTextBox(
                          title: "التاريخ",
                          value: DateFormat('dd-MM-yyyy')
                              .format(widget.visit.mDate),
                        ),
                        visitTextBox(
                          title: "النظام الغذائي",
                          value: widget.visit.mDiet,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      textDirection: TextDirection.rtl,
                      alignment: WrapAlignment.end,
                      spacing: 70,
                      runSpacing: 20,
                      children: [
                        visitTextBox(
                          title: "مؤشر كتلة الجسم",
                          value: "${widget.visit.mBMI}",
                        ),
                        visitTextBox(
                          title: "(كجم) الوزن",
                          value: "${widget.visit.mWeight}",
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      textDirection: TextDirection.rtl,
                      alignment: WrapAlignment.end,
                      spacing: 70,
                      runSpacing: 20,
                      children: [
                        visitTextBox(
                          title: "ملاحظات",
                          value: widget.visit.mVisitNotes,
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
