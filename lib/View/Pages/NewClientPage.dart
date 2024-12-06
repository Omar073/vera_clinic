import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Reusable widgets/Reusable widgets.dart';

class NewClientPage extends StatefulWidget {
  const NewClientPage({super.key});

  @override
  State<NewClientPage> createState() => _NewClientPageState();
}

class _NewClientPageState extends State<NewClientPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _dietController = TextEditingController();
  final TextEditingController _BMIController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vera-Life Clinic'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
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
                        MyInputField(
                            myController: _weightController,
                            hint: "أدخل الوزن (كيلوجرام)",
                            label: "الوزن"),
                        const SizedBox(width: 150),
                        MyInputField(
                            myController: _areaController,
                            hint: "أدخل المنطقة",
                            label: "المنطقة"),
                        const SizedBox(width: 150),
                        MyInputField(
                            myController: _phoneController,
                            hint: "أدخل رقم الهاتف 01234567890",
                            label: "رقم الهاتف"),
                        const SizedBox(width: 150),
                        MyInputField(
                            myController: _nameController,
                            hint: "أدخل اسم العميل",
                            label: "اسم العميل"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyInputField(
                            myController: _heightController,
                            hint: "",
                            label: "ملاحظات"),
                        const SizedBox(width: 150),
                        MyInputField(
                            myController: _BMIController,
                            hint: "BMI",
                            label: "مؤشر كتلة الجسم"),
                        const SizedBox(width: 150),
                        MyInputField(
                            myController: _dietController,
                            hint: "أدخل نوع الدايت",
                            label: "نوع الدايت"),
                        const SizedBox(width: 150),
                        MyInputField(
                            myController: _notesController,
                            hint: "أدخل الطول (سنتيمتر)",
                            label: "الطول"),
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
