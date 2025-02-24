import 'package:flutter/material.dart';
import 'package:vera_clinic/NewClientRegistration/View/UsedWidgets/datePicker.dart';
import 'package:vera_clinic/NewVisit/Controller/NewVisitTEC.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyInputField.dart';
import 'package:vera_clinic/NewVisit/View/UsedWidgets/AddAnotherVisitButton.dart';
import 'package:vera_clinic/NewVisit/View/UsedWidgets/SaveVisitButton.dart';

import '../../Core/View/Reusable widgets/myCard.dart';
import '../Controller/NewVisitUF.dart';

class NewVisit extends StatefulWidget {
  const NewVisit({super.key});

  @override
  State<NewVisit> createState() => _NewVisitState();
}

class _NewVisitState extends State<NewVisit> {
  @override
  void initState() {
    super.initState();
    NewVisitTEC.init();
  }

  @override
  void dispose() {
    super.dispose();
    NewVisitTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
        title: Text("${NewVisitTEC.clientVisits.length + 1}# " "زيارة"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0)
            .copyWith(right: 30, top: 20),
        child: Center(
          child: Container(
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
                                    myController:
                                        NewVisitTEC.visitDietController,
                                    hint: '',
                                    label: 'اسم النظام'),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: DatePicker(
                                    textEditingController:
                                        NewVisitTEC.visitDateController,
                                    label: 'تاريخ الزيارة'),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: MyInputField(
                                    myController:
                                        NewVisitTEC.visitNotesController,
                                    hint: '',
                                    label: 'ملاحظات'),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: MyInputField(
                                    myController:
                                        NewVisitTEC.visitWeightController,
                                    hint: 'أدخل الوزن (كجم)',
                                    label: 'الوزن'),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: MyInputField(
                                    myController:
                                        NewVisitTEC.visitBMIController,
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
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Wrap(
                        spacing: 20,
                        children: [
                          SaveVisitButton(),
                          AddAnotherVisitButton(),
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
    );
  }
}
