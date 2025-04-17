import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyCheckBox.dart';
import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/UpdateClientDetailsPageTEC.dart';

Widget medicalHistoryCardU() {
  return myCard(
    'التاريخ الطبي',
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          ":أمراض القلب والأوعية الدموية",
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
                myController: UpdateClientDetailsPageTEC.otherHeartController,
                hint: '',
                label: "أخري",
              ),
            ),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.hypertensionController,
                text: "HyperTension"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.hypotensionController,
                text: "HypoTension"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.vascularController,
                text: "Vascular"),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.anemiaController,
                text: "Anemia"),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          ":أمراض الجهاز الهضمي",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.gitController,
                hint: 'GIT ',
                label: "جهاز هضمي",
              ),
            ),
            const SizedBox(width: 30),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.constipationController,
                text: 'إمساك'),
            const SizedBox(width: 30),
            MyCheckBox(
                controller: UpdateClientDetailsPageTEC.colonController,
                text: 'قولون'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.liverController,
                hint: 'Liver ',
                label: "كبد",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.renalController,
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
                myController: UpdateClientDetailsPageTEC.endocrineController,
                hint: 'Endocrine ',
                label: "الغدد الصماء",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.rheumaticController,
                hint: 'Rheumatic ',
                label: "روماتيزم",
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          ":معلومات طبية إضافية",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.neuroController,
                hint: '',
                label: "عصبية",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.allergiesController,
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
                myController:
                    UpdateClientDetailsPageTEC.otherDiseasesController,
                hint: '',
                label: "أخري",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.psychiatricController,
                hint: '',
                label: "نفسية",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.hormonalController,
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
                  UpdateClientDetailsPageTEC.previousOBOperationsController,
              text: "عمليات سمنة سابقة",
            ),
            MyCheckBox(
              controller: UpdateClientDetailsPageTEC.previousOBMedController,
              text: "أدوية سمنة سابقة",
            ),
            MyCheckBox(
              controller: UpdateClientDetailsPageTEC.familyHistoryDMController,
              text: "تاريخ مرضي سكر",
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(
            child: MyInputField(
              myController: UpdateClientDetailsPageTEC.notesController,
              hint: "",
              label: "ملاحظات",
            ),
          ),
        ]),
      ],
    ),
  );
}
