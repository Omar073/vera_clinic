import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';
import '../../Controller/TextEditingControllers.dart';
import '../UsedWidgets/GenderDropdownMenu.dart';
import '../UsedWidgets/myCard.dart';
import '../UsedWidgets/SubscriptionTypeDropdown.dart';

class PersonalInfoCard extends StatefulWidget {
  const PersonalInfoCard({super.key});

  @override
  State<PersonalInfoCard> createState() => _PersonalInfoCardState();
}

class _PersonalInfoCardState extends State<PersonalInfoCard> {
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
                  subscriptionTypeController: subscriptionTypeController,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: phoneController,
                  hint: '',
                  label: "رقم الهاتف",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: nameController,
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
                child: GenderDropdownMenu(genderController: genderController),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: DatePicker(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: MyInputField(
                  myController: areaController,
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

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
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
          hint: '',
          label: "تاريخ الميلاد",
        ),
      ),
    );
  }
}
