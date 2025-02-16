import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../Controller/NewClientRegistrationTEC.dart';
import '../UsedWidgets/GenderDropdownMenu.dart';
import '../UsedWidgets/datePicker.dart';
import '../../../Core/View/Reusable widgets/myCard.dart';
import '../UsedWidgets/SubscriptionTypeDropdown.dart';

class PersonalInfoCard extends StatefulWidget {
  const PersonalInfoCard({super.key});

  @override
  State<PersonalInfoCard> createState() => _PersonalInfoCardState();
}

class _PersonalInfoCardState extends State<PersonalInfoCard> {

  @override
  void dispose() {
    ClientRegistrationTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  label: "رقم الهاتف",
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
                child: DatePicker(
                    textEditingController:
                        ClientRegistrationTEC.birthdateController,
                    label: "تاريخ الميلاد"),
              ),
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
}
