import 'package:flutter/cupertino.dart';

import '../../../Core/View/Reusable widgets/MyCheckBox.dart';
import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/UpdateClientDetailsTEC.dart';

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
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.otherHeartController,
                hint: '',
                label: "أمراض قلب اخري",
              ),
            ),
            const SizedBox(width: 15),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.hypertensionController,
                text: "HyperTension"),
            const SizedBox(width: 15),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.hypotensionController,
                text: "HypoTension"),
            const SizedBox(width: 15),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.vascularController,
                text: "Vascular"),
            const SizedBox(width: 15),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.anemiaController,
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
                myController: UpdateClientDetailsTEC.gitController,
                hint: 'GIT ',
                label: "أمراض الجهاز الهضمي الأخري",
              ),
            ),
            const SizedBox(width: 30),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.constipationController,
                text: 'إمساك'),
            const SizedBox(width: 30),
            MyCheckBox(
                controller: UpdateClientDetailsTEC.colonController,
                text: 'قولون'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.liverController,
                hint: 'Liver ',
                label: "كبد",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.renalController,
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
                myController: UpdateClientDetailsTEC.endocrineController,
                hint: 'Endocrine ',
                label: "الغدد الصماء",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.rheumaticController,
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
                myController: UpdateClientDetailsTEC.neuroController,
                hint: '',
                label: "عصبية",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.allergiesController,
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
                    UpdateClientDetailsTEC.otherDiseasesController,
                hint: '',
                label: "أخري",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.psychiatricController,
                hint: '',
                label: "نفسية",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.hormonalController,
                hint: '',
                label: "هرمون",
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyCheckBox(
              controller:
                  UpdateClientDetailsTEC.previousOBOperationsController,
              text: "عمليات سمنة سابقة",
            ),
            const SizedBox(width: 24),
            MyCheckBox(
              controller: UpdateClientDetailsTEC.previousOBMedController,
              text: "أدوية سمنة سابقة",
            ),
            const SizedBox(width: 24),
            MyCheckBox(
              controller: UpdateClientDetailsTEC.familyHistoryDMController,
              text: "تاريخ مرضي سكر",
            ),
          ],
        ),
      ],
    ),
  );
}
