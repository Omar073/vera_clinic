import 'package:flutter/material.dart';
import 'package:vera_clinic/NewClientRegistration/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/NewClientRegistration/View/UsedWidgets/ActivityLevelDropdownMenu.dart';
import 'package:vera_clinic/NewClientRegistration/View/UsedWidgets/GenderDropdownMenu.dart';
import 'package:vera_clinic/NewVisit/View/NewVisit.dart';
import '../../Core/View/Reusable widgets/MyInputField.dart';
import '../Controller/TextEditingControllers.dart';
import 'UsedWidgets/MyCheckBox.dart';
import 'UsedWidgets/SubscriptionTypeDropdown.dart';

class NewClientPage extends StatefulWidget {
  const NewClientPage({super.key});

  @override
  State<NewClientPage> createState() => _NewClientPageState();
}

class _NewClientPageState extends State<NewClientPage> {
  @override
  void initState() {
    super.initState();
    yoyoController.text = 'false';
    // for (var controller in platControllers) {
    //   controller.text = '0';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vera-Life Clinic'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade100,
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0).copyWith(right: 30),
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
                      spacing: 70,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
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
                                  birthdateController.text =
                                      "${pickedDate.toLocal()}".split(' ')[0];
                                });
                              }
                            },
                            child: const Wrap(
                              spacing: 20,
                              children: [
                                Icon(Icons.calendar_today),
                                Text('تاريخ الميلاد',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        GenderDropdownMenu(genderController: genderController),
                        MyInputField(
                            myController: areaController,
                            hint: "أدخل المنطقة",
                            label: "المنطقة"),
                        MyInputField(
                            myController: phoneController,
                            hint: "أدخل رقم الهاتف 01234567890",
                            label: "رقم الهاتف"),
                        MyInputField(
                            myController: nameController,
                            hint: "أدخل اسم العميل",
                            label: "اسم العميل"),
                      ],
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      children: [
                        MyInputField(
                            myController: weightController,
                            hint: "أدخل الوزن (كيلوجرام)",
                            label: "الوزن"),
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: heightController,
                            hint: "أدخل الطول (سنتيمتر)",
                            label: "الطول"),
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: bmiController,
                            hint: "BMI",
                            label: "مؤشر كتلة الجسم"),
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: dietController,
                            hint: "أدخل نوع الدايت",
                            label: "نوع الدايت"),
                      ],
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 80,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        MyInputField(
                            myController: notesController,
                            hint: "",
                            label: "ملاحظات"),
                        SubscriptionTypeDropdown(
                            subscriptionTypeController:
                                subscriptionTypeController),
                        ActivityLevelDropdownMenu(
                            activityLevelController: activityLevelController),
                        MyCheckBox(
                            controller: sportsController, text: 'Sports'),
                        MyCheckBox(
                            controller: yoyoController,
                            text: '(رجيم سابق) YOYO'),
                        // const SizedBox(
                        //   width: 178,
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Wrap(
                      spacing: 15,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MyInputField(
                            myController: platControllers[
                                platControllers.length - 6 - index],
                            hint: "",
                            label:
                                "الوزن الثابت ${platControllers.length - 5 - index}",
                          ),
                        );
                      }),
                    ),
                    Wrap(
                      spacing: 15,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MyInputField(
                            myController: platControllers[
                                platControllers.length - 1 - index],
                            hint: "",
                            label:
                                "الوزن الثابت ${platControllers.length - index}",
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 70,
                      runSpacing: 10,
                      direction: Axis.horizontal,
                      // alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        MyInputField(
                            myController: othersPreferredFoodsController,
                            hint: '',
                            label: 'أخري'),
                        MyCheckBox(controller: fruitsController, text: "فاكهة"),
                        MyCheckBox(controller: vegController, text: "خضار"),
                        MyCheckBox(controller: dairyController, text: "ألبان"),
                        MyCheckBox(
                            controller: proteinController, text: "بروتينات"),
                        MyCheckBox(
                            controller: carbohydratesController,
                            text: "كربوهايدرات"),
                        const Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Text(
                            ":الطعام المفضل",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 100.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MyCheckBox(
                                    controller: backController, text: "ظهر"),
                                const SizedBox(width: 14),
                                MyCheckBox(
                                    controller: breastController, text: "صدر"),
                                const SizedBox(width: 14),
                                MyCheckBox(
                                    controller: armsController, text: "ذراعات"),
                                const SizedBox(width: 14),
                                MyCheckBox(
                                    controller: thighsController,
                                    text: "أفخاذ"),
                                const SizedBox(width: 14),
                                MyCheckBox(
                                    controller: waistController, text: "وسط"),
                                const SizedBox(width: 14),
                                MyCheckBox(
                                    controller: buttocksController,
                                    text: "مقعدة"),
                                const SizedBox(width: 14),
                                MyCheckBox(
                                    controller: abdomenController, text: "بطن"),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Text(
                            ":مناطق الوزن",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 100,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      children: [
                        MyInputField(
                            myController: optimalWeightController,
                            hint: '',
                            label: "وزن مثالي"),
                        MyInputField(
                            myController: maxWeightController,
                            hint: '',
                            label: "أقصي وزن"),
                        MyInputField(
                            myController: waterController,
                            hint: '',
                            label: 'الماء'),
                        MyInputField(
                            myController: pbfController,
                            hint: 'PBF',
                            label: 'نسبة الدهن'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 100,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      children: [
                        MyInputField(
                            myController: dailyCaloriesController,
                            hint: '',
                            label: "السعرات اليومية"),
                        MyInputField(
                            myController: maxCaloriesController,
                            hint: '',
                            label: "أقصي سعرات"),
                        MyInputField(
                            myController: bmrController,
                            hint: 'BMR',
                            label: "حد الحرق الأدني"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 60,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        MyInputField(
                            myController: otherHeartController,
                            hint: '',
                            label: "أخري"),
                        MyCheckBox(
                            controller: hypertensionController,
                            text: "HyperTension"),
                        MyCheckBox(
                            controller: hypotensionController,
                            text: "HypoTension"),
                        MyCheckBox(
                            controller: vascularController, text: "Vascular"),
                        MyCheckBox(
                            controller: anemiaController, text: "Anemia"),
                        const Text(
                          "قلب و أوعية",
                          style: TextStyle(fontSize: 16),
                        ),
                        const Text(
                          ":الأمراض",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 100,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        MyInputField(
                            myController: renalController,
                            hint: 'Renal',
                            label: "كلي"),
                        MyInputField(
                            myController: liverController,
                            hint: 'Liver',
                            label: "كبد"),
                        MyInputField(
                            myController: endocrineController,
                            hint: 'Endocrine',
                            label: "الغدد الصماء"),
                        MyInputField(
                            myController: rheumaticController,
                            hint: 'Rheumatic',
                            label: "روماتيزم"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 80,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        MyInputField(
                            myController: neuroController,
                            hint: '',
                            label: "عصبية"),
                        MyInputField(
                            myController: allergiesController,
                            hint: '',
                            label: "حساسية"),
                        MyCheckBox(controller: colonController, text: 'قولون'),
                        MyCheckBox(
                            controller: constipationController, text: 'إمساك'),
                        MyInputField(
                            myController: gitController,
                            hint: 'GIT',
                            label: "جهاز هضمي"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 80,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        MyInputField(
                            myController: othersDiseaseController,
                            hint: '',
                            label: "أخري"),
                        MyInputField(
                            myController: psychiatricController,
                            hint: '',
                            label: "نفسية"),
                        MyInputField(
                            myController: hormonalController,
                            hint: '',
                            label: "هرمون"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 80,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        MyCheckBox(
                            controller: previousOBOperationsController,
                            text: "عمليات سمنة سابقة"),
                        MyCheckBox(
                            controller: previousOBMedController,
                            text: "أدوية سمنة سابقة"),
                        MyCheckBox(
                            controller: familyHistoryDMController,
                            text: "تاريخ مرضي سكر"),
                      ],
                    ),
                    const SizedBox(height: 120),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Wrap(
                          spacing: 20,

                          children: [
                            ElevatedButton(
                              onPressed: () {
                                debugPrint("Button pressed: حفظ");
                                createClient(); //todo: add to checked in clients
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 13),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              child: const Text(
                                "حفظ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewVisit()));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 13),
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                child: const Text(
                                  'تسجيل زيارة سابقة',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
