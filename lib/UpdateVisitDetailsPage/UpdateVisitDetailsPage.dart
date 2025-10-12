import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Visit.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/my_app_bar.dart';
import 'package:vera_clinic/UpdateVisitDetailsPage/Controller/UpdateVisitDetailsTEC.dart';

import '../Core/View/Reusable widgets/BackGround.dart';
import '../Core/View/Reusable widgets/MyInputField.dart';
import '../Core/View/Reusable widgets/datePicker.dart';
import '../Core/View/Reusable widgets/myCard.dart';
import 'View/UpdateVisitButton.dart';

class UpdateVisitDetailsPage extends StatefulWidget {
  final Visit visit;
  final VoidCallback onVisitUpdated;
  const UpdateVisitDetailsPage(
      {super.key, required this.visit, required this.onVisitUpdated});

  @override
  State<UpdateVisitDetailsPage> createState() => _UpdateVisitDetailsPageState();
}

class _UpdateVisitDetailsPageState extends State<UpdateVisitDetailsPage> {
  @override
  void initState() {
    super.initState();
    UpdateVisitDetailsTEC.init(widget.visit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'تحديث تفاصيل الزيارة',
      ),
      body: Background(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0)
              .copyWith(right: 30, top: 20),
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    myCard(
                        'تفاصيل الزيارة',
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateVisitDetailsTEC
                                          .visitDietController,
                                      hint: '',
                                      label: 'اسم النظام'),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: DatePicker(
                                      textEditingController:
                                          UpdateVisitDetailsTEC
                                              .visitDateController,
                                      label: 'تاريخ الزيارة'),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateVisitDetailsTEC
                                          .visitNotesController,
                                      hint: '',
                                      label: 'ملاحظات'),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateVisitDetailsTEC
                                          .visitWeightController,
                                      hint: 'أدخل الوزن (كجم)',
                                      label: 'الوزن'),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateVisitDetailsTEC
                                          .visitBMIController,
                                      hint: 'BMI ',
                                      label: 'مؤشر كتلة الجسم'),
                                ),
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Wrap(
                          spacing: 20,
                          children: [
                            UpdateVisitButton(
                              v: widget.visit,
                              onVisitUpdated: widget.onVisitUpdated,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
