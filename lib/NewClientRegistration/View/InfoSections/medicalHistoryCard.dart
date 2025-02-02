import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../Controller/TextEditingControllers.dart';
import '../UsedWidgets/MyCard.dart';
import '../UsedWidgets/MyCheckBox.dart';

Widget medicalHistoryCard() {
  return myCard(
    'التاريخ الطبي',
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          "أمراض القلب والأوعية الدموية:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 24,
          runSpacing: 12,
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: MyInputField(
                myController: otherHeartController,
                hint: '',
                label: "أخري",
              ),
            ),
            MyCheckBox(
                controller: hypertensionController, text: "HyperTension"),
            MyCheckBox(controller: hypotensionController, text: "HypoTension"),
            MyCheckBox(controller: vascularController, text: "Vascular"),
            MyCheckBox(controller: anemiaController, text: "Anemia"),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          "أمراض الجهاز الهضمي:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: gitController,
                hint: 'GIT',
                label: "جهاز هضمي",
              ),
            ),
            const SizedBox(width: 30),
            MyCheckBox(controller: constipationController, text: 'إمساك'),
            const SizedBox(width: 30),
            MyCheckBox(controller: colonController, text: 'قولون'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: liverController,
                hint: 'Liver',
                label: "كبد",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MyInputField(
                myController: renalController,
                hint: 'Renal',
                label: "كلي",
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
            const SizedBox(width: 20),
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
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: neuroController,
                hint: '',
                label: "عصبية",
              ),
            ),
            const SizedBox(width: 20),
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
                myController: othersDiseaseController,
                hint: '',
                label: "أخري",
              ),
            ),
            const SizedBox(width: 16),
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
        Row(children: [
          Expanded(
            child: MyInputField(
              myController: notesController,
              hint: "",
              label: "ملاحظات",
            ),
          ),
        ]),
      ],
    ),
  );
}
