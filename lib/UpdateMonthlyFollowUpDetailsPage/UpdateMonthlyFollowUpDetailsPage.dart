import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/my_app_bar.dart';
import 'package:vera_clinic/UpdateMonthlyFollowUpDetailsPage/Controller/UpdateMonthlyFollowUpDetailsTEC.dart';

import '../Core/View/Reusable widgets/BackGround.dart';
import '../Core/View/Reusable widgets/MyInputField.dart';
import '../Core/View/Reusable widgets/datePicker.dart';
import '../Core/View/Reusable widgets/myCard.dart';
import 'View/UpdateMonthlyFollowUpButton.dart';

class UpdateMonthlyFollowUpDetailsPage extends StatefulWidget {
  final ClientMonthlyFollowUp cmfu;
  final VoidCallback onMonthlyFollowUpUpdated;
  const UpdateMonthlyFollowUpDetailsPage(
      {super.key, required this.cmfu, required this.onMonthlyFollowUpUpdated});

  @override
  State<UpdateMonthlyFollowUpDetailsPage> createState() => _UpdateMonthlyFollowUpDetailsPageState();
}

class _UpdateMonthlyFollowUpDetailsPageState extends State<UpdateMonthlyFollowUpDetailsPage> {
  @override
  void initState() {
    super.initState();
    UpdateMonthlyFollowUpDetailsTEC.init(widget.cmfu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'تحديث تفاصيل المتابعة',
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
                        'تفاصيل المتابعة',
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateMonthlyFollowUpDetailsTEC
                                          .waterController,
                                      hint: '',
                                      label: 'الماء'),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: DatePicker(
                                      textEditingController:
                                          UpdateMonthlyFollowUpDetailsTEC
                                              .dateController,
                                      label: 'تاريخ المتابعة'),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateMonthlyFollowUpDetailsTEC
                                          .bmiController,
                                      hint: 'BMI',
                                      label: 'مؤشر كتلة الجسم'),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateMonthlyFollowUpDetailsTEC
                                          .muscleMassController,
                                      hint: 'كتلة العضلات',
                                      label: 'كتلة العضلات'),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateMonthlyFollowUpDetailsTEC
                                          .pbfController,
                                      hint: 'نسبة الدهون',
                                      label: 'نسبة الدهون'),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateMonthlyFollowUpDetailsTEC
                                          .bmrController,
                                      hint: 'معدل الحرق الأساسي',
                                      label: 'معدل الحرق الأساسي'),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateMonthlyFollowUpDetailsTEC
                                          .maxWeightController,
                                      hint: 'الوزن الأقصى (كجم)',
                                      label: 'الوزن الأقصى'),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateMonthlyFollowUpDetailsTEC
                                          .optimalWeightController,
                                      hint: 'الوزن المثالي (كجم)',
                                      label: 'الوزن المثالي'),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateMonthlyFollowUpDetailsTEC
                                          .dailyCaloriesController,
                                      hint: 'السعرات اليومية',
                                      label: 'السعرات اليومية'),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: MyInputField(
                                      myController: UpdateMonthlyFollowUpDetailsTEC
                                          .maxCaloriesController,
                                      hint: 'السعرات القصوى',
                                      label: 'السعرات القصوى'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            MyInputField(
                              myController: UpdateMonthlyFollowUpDetailsTEC.notesController,
                              hint: 'أدخل ملاحظات إضافية...',
                              label: 'ملاحظات',
                              maxLines: 3,
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
                            UpdateMonthlyFollowUpButton(
                              cmfu: widget.cmfu,
                              onMonthlyFollowUpUpdated: widget.onMonthlyFollowUpUpdated,
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
