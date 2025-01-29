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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل عميل جديد'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildPersonalInfoCard(),
            const SizedBox(height: 20),
            _buildBodyMeasurementsCard(),
            const SizedBox(height: 20),
            _buildDietPreferencesCard(),
            const SizedBox(height: 20),
            _buildWeightHistoryCard(),
            const SizedBox(height: 20),
            _buildWeightDistributionCard(),
            const SizedBox(height: 20),
            _buildMedicalHistoryCard(),
            const SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return _buildCard(
      'المعلومات الشخصية',
      Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: SubscriptionTypeDropdown(
                  subscriptionTypeController: subscriptionTypeController,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: phoneController,
                  hint: "أدخل رقم الهاتف",
                  label: "رقم الهاتف",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: nameController,
                  hint: "أدخل اسم العميل",
                  label: "اسم العميل",
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GenderDropdownMenu(genderController: genderController),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDatePicker(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: areaController,
                  hint: "أدخل المنطقة",
                  label: "المنطقة",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBodyMeasurementsCard() {
    return _buildCard(
      'القياسات الجسمية',
      Column(
        children: [
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  myController: heightController,
                  hint: "أدخل الطول (سم)",
                  label: "الطول",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: weightController,
                  hint: "أدخل الوزن (كجم)",
                  label: "الوزن",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: bmiController,
                  hint: "BMI",
                  label: "مؤشر كتلة الجسم",
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  myController: pbfController,
                  hint: "PBF",
                  label: "نسبة الدهن",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: waterController,
                  hint: "لتر",
                  label: "الماء",
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDietPreferencesCard() {
    return _buildCard(
      'تفضيلات الغذاء والنشاط',
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: ActivityLevelDropdownMenu(
                  activityLevelController: activityLevelController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "الطعام المفضل:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            alignment: WrapAlignment.end,
            children: [
              MyCheckBox(controller: carbohydratesController, text: "كربوهايدرات"),
              MyCheckBox(controller: proteinController, text: "بروتينات"),
              MyCheckBox(controller: dairyController, text: "ألبان"),
              MyCheckBox(controller: vegController, text: "خضار"),
              MyCheckBox(controller: fruitsController, text: "فاكهة"),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: othersPreferredFoodsController,
                  hint: 'أخري',
                  label: 'أخري',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            alignment: WrapAlignment.end,
            children: [
              MyCheckBox(controller: sportsController, text: 'ممارسة الرياضة'),
              MyCheckBox(controller: yoyoController, text: '(رجيم سابق) YOYO'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeightHistoryCard() {
    return _buildCard(
      'سجل الوزن',
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  myController: maxWeightController,
                  hint: '',
                  label: "أقصي وزن",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: optimalWeightController,
                  hint: '',
                  label: "وزن مثالي",
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "الأوزان الثابتة السابقة:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.end,
            children: List.generate(
              10,
                  (index) => SizedBox(
                width: 180,
                child: MyInputField(
                  myController: platControllers[index],
                  hint: "",
                  label: "الوزن الثابت ${index + 1}",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightDistributionCard() {
    return _buildCard(
      'مناطق توزيع الوزن',
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Wrap(
            spacing: 24,
            runSpacing: 12,
            alignment: WrapAlignment.end,
            children: [
              MyCheckBox(controller: abdomenController, text: "بطن"),
              MyCheckBox(controller: buttocksController, text: "مقعدة"),
              MyCheckBox(controller: waistController, text: "وسط"),
              MyCheckBox(controller: thighsController, text: "أفخاذ"),
              MyCheckBox(controller: armsController, text: "ذراعات"),
              MyCheckBox(controller: breastController, text: "صدر"),
              MyCheckBox(controller: backController, text: "ظهر"),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  myController: dailyCaloriesController,
                  hint: '',
                  label: "السعرات اليومية",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: maxCaloriesController,
                  hint: '',
                  label: "أقصي سعرات",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: maxCaloriesController,
                  hint: '',
                  label: "حد الحرق الأدنى",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            birthdateController.text = "${pickedDate.toLocal()}".split(' ')[0];
          });
        }
      },
      child: AbsorbPointer(
        child: MyInputField(
          myController: birthdateController,
          hint: "اختر تاريخ الميلاد",
          label: "تاريخ الميلاد",
        ),
      ),
    );
  }

  Widget _buildMedicalHistoryCard() {
    return _buildCard(
      'التاريخ الطبي',
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "أمراض القلب والأوعية الدموية:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            alignment: WrapAlignment.end,
            children: [
              MyCheckBox(controller: anemiaController, text: "Anemia"),
              MyCheckBox(controller: vascularController, text: "Vascular"),
              MyCheckBox(controller: hypotensionController, text: "HypoTension"),
              MyCheckBox(controller: hypertensionController, text: "HyperTension"),
              SizedBox(
                width: 200,
                child: MyInputField(
                  myController: otherHeartController,
                  hint: '',
                  label: "أخري",
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "أمراض الجهاز الهضمي:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  myController: gitController,
                  hint: 'GIT',
                  label: "جهاز هضمي",
                ),
              ),
              const SizedBox(width: 16),
              MyCheckBox(controller: constipationController, text: 'إمساك'),
              const SizedBox(width: 16),
              MyCheckBox(controller: colonController, text: 'قولون'),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  myController: renalController,
                  hint: 'Renal',
                  label: "كلي",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: liverController,
                  hint: 'Liver',
                  label: "كبد",
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  myController: endocrineController,
                  hint: 'Endocrine',
                  label: "الغدد الصماء",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: rheumaticController,
                  hint: 'Rheumatic',
                  label: "روماتيزم",
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "معلومات طبية إضافية:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  myController: neuroController,
                  hint: '',
                  label: "عصبية",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: allergiesController,
                  hint: '',
                  label: "حساسية",
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  myController: psychiatricController,
                  hint: '',
                  label: "نفسية",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: hormonalController,
                  hint: '',
                  label: "هرمون",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: othersDiseaseController,
                  hint: '',
                  label: "أخري",
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            alignment: WrapAlignment.end,
            children: [
              MyCheckBox(
                controller: previousOBOperationsController,
                text: "عمليات سمنة سابقة",
              ),
              MyCheckBox(
                controller: previousOBMedController,
                text: "أدوية سمنة سابقة",
              ),
              MyCheckBox(
                controller: familyHistoryDMController,
                text: "تاريخ مرضي سكر",
              ),
            ],
          ),
          const SizedBox(height: 16),
          MyInputField(
            myController: notesController,
            hint: "",
            label: "ملاحظات",
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, Widget content) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              createClient();
            },
            icon: const Icon(Icons.save),
            label: const Text("حفظ"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewVisit()),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("تسجيل زيارة سابقة"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}