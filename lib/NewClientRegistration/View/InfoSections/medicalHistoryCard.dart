import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../Controller/ClientRegistrationTEC.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
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
                myController: ClientRegistrationTEC.otherHeartController,
                hint: '',
                label: "أخري",
              ),
            ),
            MyCheckBox(
                controller: ClientRegistrationTEC.hypertensionController,
                text: "HyperTension"),
            MyCheckBox(
                controller: ClientRegistrationTEC.hypotensionController,
                text: "HypoTension"),
            MyCheckBox(
                controller: ClientRegistrationTEC.vascularController,
                text: "Vascular"),
            MyCheckBox(
                controller: ClientRegistrationTEC.anemiaController,
                text: "Anemia"),
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
                myController: ClientRegistrationTEC.gitController,
                hint: 'GIT ',
                label: "جهاز هضمي",
              ),
            ),
            const SizedBox(width: 30),
            MyCheckBox(
                controller: ClientRegistrationTEC.constipationController,
                text: 'إمساك'),
            const SizedBox(width: 30),
            MyCheckBox(
                controller: ClientRegistrationTEC.colonController,
                text: 'قولون'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.liverController,
                hint: 'Liver ',
                label: "كبد",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.renalController,
                hint: 'Renal ',
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
                myController: ClientRegistrationTEC.endocrineController,
                hint: 'Endocrine ',
                label: "الغدد الصماء",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.rheumaticController,
                hint: 'Rheumatic ',
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
                myController: ClientRegistrationTEC.neuroController,
                hint: '',
                label: "عصبية",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.allergiesController,
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
                myController: ClientRegistrationTEC.othersDiseaseController,
                hint: '',
                label: "أخري",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.psychiatricController,
                hint: '',
                label: "نفسية",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.hormonalController,
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
              controller:
                  ClientRegistrationTEC.previousOBOperationsController,
              text: "عمليات سمنة سابقة",
            ),
            MyCheckBox(
              controller: ClientRegistrationTEC.previousOBMedController,
              text: "أدوية سمنة سابقة",
            ),
            MyCheckBox(
              controller: ClientRegistrationTEC.familyHistoryDMController,
              text: "تاريخ مرضي سكر",
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(
            child: MyInputField(
              myController: ClientRegistrationTEC.notesController,
              hint: "",
              label: "ملاحظات",
            ),
          ),
        ]),
      ],
    ),
  );
}
