import 'package:flutter/material.dart';
import 'package:vera_clinic/NewClientRegistration/View/UsedWidgets/datePicker.dart';
import 'package:vera_clinic/NewVisit/Controller/TextEditingControllers.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyInputField.dart';

import '../../Core/View/Reusable widgets/myCard.dart';
import '../Controller/UtilityFunctions.dart';

class NewVisit extends StatefulWidget {
  const NewVisit({super.key});

  @override
  State<NewVisit> createState() => _NewVisitState();
}

class _NewVisitState extends State<NewVisit> {
  // int visitCounter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
        title: Text("${clientVisits.length + 1}# " "زيارة"),
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
                                    myController: visitDietController,
                                    hint: '',
                                    label: 'اسم النظام'),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: DatePicker(
                                    textEditingController: visitDateController,
                                    label: 'تاريخ الزيارة'),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: MyInputField(
                                    myController: visitNotesController,
                                    hint: '',
                                    label: 'ملاحظات'),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: MyInputField(
                                    myController: visitWeightController,
                                    hint: 'أدخل الوزن (كجم)',
                                    label: 'الوزن'),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                child: MyInputField(
                                    myController: visitBMIController,
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
                          ElevatedButton.icon(
                            label: const Text(
                              "تسجيل",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              debugPrint("Button pressed: حفظ");
                              bool success = await createVisit();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(
                                    child: Text(success
                                        ? 'تم حفظ الزيارة ${clientVisits.length + 1} بنجاح'
                                        : 'فشل حفظ الزيارة'),
                                  ),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor:
                                      success ? Colors.green : Colors.red,
                                ),
                              );
                              if (success) {
                                disposeControllers();
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 27, 169, 34),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 13),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            icon: const Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                          ),
                          ElevatedButton.icon(
                            label: const Text(
                              'إضافة زيارة أخري',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              bool success = await createVisit();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(
                                    child: Text(success
                                        ? 'تم حفظ الزيارة ${clientVisits.length + 1} بنجاح'
                                        : 'فشل حفظ الزيارة'),
                                  ),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor:
                                      success ? Colors.green : Colors.red,
                                ),
                              );
                              setState(() {});
                              // if (success) disposeControllers();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 13),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
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
    );
  }
}
