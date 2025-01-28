import 'package:flutter/material.dart';

import '../../../Core/Model/Classes/Client.dart';

class GenderDropdownMenu extends StatefulWidget {
  final TextEditingController genderController;
  const GenderDropdownMenu({super.key, required this.genderController});

  @override
  State<GenderDropdownMenu> createState() => _GenderDropdownMenuState();
}

class _GenderDropdownMenuState extends State<GenderDropdownMenu> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: DropdownButton<Gender>(
        value: _selectedGender,
        onChanged: (Gender? newValue) {
          setState(() {
            _selectedGender = newValue;
            widget.genderController.text = newValue?.name ?? '';
          });
        },
        items: Gender.values.map((Gender gender) {
          return DropdownMenuItem<Gender>(
            value: gender,
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(getGenderLabel(gender),
                    textAlign: TextAlign.start)),
          );
        }).toList(),
        hint: const Text('النوع',
            textAlign: TextAlign.start), //todo: fix alignment
      ),
    );
  }
}

String getGenderLabel(Gender gender) {
  switch (gender) {
    case Gender.male:
      return 'ذكر';
    case Gender.female:
      return 'أنثى';
    case Gender.none:
      return '';
    default:
      return '';
  }
}