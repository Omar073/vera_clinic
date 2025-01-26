import 'package:flutter/material.dart';
import 'package:vera_clinic/NewClientPage/View/UsedWidgets.dart';
import '../../View/Reusable widgets/MyInputField.dart';
import '../Controller/TextEditingControllers.dart';

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
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
                        ),
                        const SizedBox(width: 10),
                        const Text('تاريخ الميلاد',
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: areaController,
                            hint: "أدخل المنطقة",
                            label: "المنطقة"),
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: phoneController,
                            hint: "أدخل رقم الهاتف 01234567890",
                            label: "رقم الهاتف"),
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: nameController,
                            hint: "أدخل اسم العميل",
                            label: "اسم العميل"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyInputField(
                            myController: notesController,
                            hint: "",
                            label: "ملاحظات"),
                        const SizedBox(width: 170),
                        SubscriptionTypeDropdown(
                            subscriptionTypeController:
                                subscriptionTypeController),
                        const SizedBox(
                          width: 178,
                        ),
                        MyCheckBox(controller: yoyoController, text: 'Sports'),
                        const SizedBox(width: 185),
                        MyCheckBox(
                            controller: yoyoController,
                            text: '(رجيم سابق) YOYO'),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MyInputField(
                            myController: platControllers[
                                platControllers.length - 6 - index],
                            hint:
                                "أدخل الوزن الثابت ${platControllers.length - 5 - index}",
                            label:
                                "الوزن الثابت ${platControllers.length - 5 - index}",
                          ),
                        );
                      }),
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MyInputField(
                            myController: platControllers[
                                platControllers.length - 1 - index],
                            hint:
                                "أدخل الوزن الثابت ${platControllers.length - index}",
                            label:
                                "الوزن الثابت ${platControllers.length - index}",
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 80.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MyInputField(
                                    myController:
                                        othersPreferredFoodsController,
                                    hint: '',
                                    label: 'أخري'),
                                const SizedBox(width: 14),
                                MyCheckBox(
                                    controller: fruitsController,
                                    text: "فاكهة"),
                                const SizedBox(width: 14),
                                MyCheckBox(
                                    controller: vegController, text: "خضار"),
                                const SizedBox(width: 14),
                                MyCheckBox(
                                    controller: dairyController, text: "ألبان"),
                                const SizedBox(width: 14),
                                MyCheckBox(
                                    controller: proteinController,
                                    text: "بروتينات"),
                                const SizedBox(width: 14),
                                MyCheckBox(
                                    controller: carbohydratesController,
                                    text: "كربوهايدرات"),
                              ],
                            ),
                          ),
                        ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: optimalWeightController,
                            hint: '',
                            label: "وزن مثالي"),
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: maxWeightController,
                            hint: '',
                            label: "أقصي وزن"),
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: waterController,
                            hint: '',
                            label: 'الماء'),
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: pbfController,
                            hint: 'PBF',
                            label: 'نسبة الدهن'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyInputField(
                            myController: dailyCaloriesController,
                            hint: '',
                            label: "السعرات اليومية"),
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: maxCaloriesController,
                            hint: '',
                            label: "أقصي سعرات"),
                        const SizedBox(width: 100),
                        MyInputField(
                            myController: bmrController,
                            hint: 'BMR',
                            label: "حد الحرق الأدني"),
                      ],
                    ),
                    const SizedBox(height: 200),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          debugPrint("Button pressed: حفظ");
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
