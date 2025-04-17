import 'package:flutter/material.dart';
import 'package:vera_clinic/UpdateClientDetailsPage/Controller/UpdateClientDetailsPageTEC.dart';

import '../../../Core/Controller/UtilityFunctions.dart';
import '../../../Core/View/Reusable widgets/GenderDropdownMenu.dart';
import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/SubscriptionTypeDropdown.dart';
import '../../../Core/View/Reusable widgets/datePicker.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';

Widget personalInfoCardU() {
  return myCard(
    'المعلومات الشخصية',
    Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: SubscriptionTypeDropdown(
                subscriptionTypeController:
                    UpdateClientDetailsPageTEC.subscriptionTypeController,
                selectedType: getSubscriptionTypeFromString(
                    UpdateClientDetailsPageTEC.subscriptionTypeController.text),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.phoneController,
                hint: '',
                label: "رقم الهاتف",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.nameController,
                hint: '',
                label: "اسم العميل",
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GenderDropdownMenu(
                  genderController: UpdateClientDetailsPageTEC.genderController,
                  selectedGender: getGenderFromString(
                      UpdateClientDetailsPageTEC.genderController.text)
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DatePicker(
                  textEditingController:
                      UpdateClientDetailsPageTEC.birthdateController,
                  label: "تاريخ الميلاد"),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsPageTEC.areaController,
                hint: '',
                label: "المنطقة",
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
