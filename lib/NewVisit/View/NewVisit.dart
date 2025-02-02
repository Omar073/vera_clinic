import 'package:flutter/material.dart';
import 'package:vera_clinic/NewVisit/Controller/TextEditingControllers.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyInputField.dart';

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
        //todo: could replace the counter with the length of the list of visits
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
                  Wrap(
                    spacing: 325,
                    runSpacing: 10,
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      MyInputField(
                          myController: visitDietController,
                          hint: '',
                          label: 'اسم النظام'),
                      Padding(
                        padding: const EdgeInsets.only(top: 9.0),
                        child: GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                visitDateController.text =
                                    "${pickedDate.toLocal()}".split(' ')[0];
                              });
                            }
                          },
                          child: const Wrap(
                            spacing: 20,
                            children: [
                              Icon(Icons.calendar_today),
                              Text('تاريخ الزيارة',
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 250,
                    runSpacing: 10,
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      MyInputField(
                          myController: visitNotesController,
                          hint: '',
                          label: 'ملاحظات'),
                      MyInputField(
                          myController: visitWeightController,
                          hint: '',
                          label: 'الوزن'),
                      MyInputField(
                          myController: visitBMIController,
                          hint: 'BMI',
                          label: 'مؤشر كتلة الجسم'),
                    ],
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Wrap(
                        spacing: 20,
                        children: [
                          ElevatedButton(
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
                              if (success) disposeControllers();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 13),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            child: const Text(
                              "تسجيل",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
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
                                if (success) disposeControllers();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 13),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              child: const Text(
                                'إضافة زيارة أخري',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              )),
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
