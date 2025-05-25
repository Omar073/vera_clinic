import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Core/View/Reusable widgets/GenderDropdownMenu.dart';
import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../../Core/View/Reusable widgets/SubscriptionTypeDropdown.dart';
import '../../../Core/View/Reusable widgets/datePicker.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../../Controller/ClientRegistrationTEC.dart';

Widget personalInfoCard() {
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
                    ClientRegistrationTEC.subscriptionTypeController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.phoneController,
                hint: '',
                label: "رقم التليفون",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.nameController,
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
                  genderController: ClientRegistrationTEC.genderController),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: MyInputField(
                    myController: ClientRegistrationTEC.birthYearController,
                    hint: 'مثال: 1990',
                    label: 'سنة الميلاد')),
            const SizedBox(width: 16),
            Expanded(
              child: MyInputField(
                myController: ClientRegistrationTEC.areaController,
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
