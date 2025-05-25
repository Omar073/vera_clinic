import 'package:flutter/material.dart';
import 'package:vera_clinic/UpdateClientDetailsPage/Controller/UpdateClientDetailsTEC.dart';

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
                    UpdateClientDetailsTEC.subscriptionTypeController,
                selectedType: getSubscriptionTypeFromString(
                    UpdateClientDetailsTEC.subscriptionTypeController.text),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.phoneController,
                hint: '',
                label: "رقم التليفون",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.nameController,
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
                  genderController: UpdateClientDetailsTEC.genderController,
                  selectedGender: getGenderFromString(
                      UpdateClientDetailsTEC.genderController.text)),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: MyInputField(
                    myController: UpdateClientDetailsTEC.birthYearController,
                    hint: 'مثال: 1990',
                    label: 'سنة الميلاد')),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: UpdateClientDetailsTEC.areaController,
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
