import 'package:flutter/material.dart';
import '../../../Core/Model/Classes/Client.dart';
import '../../Controller/ClientRegistrationUF.dart';

class GenderDropdownMenu extends StatefulWidget {
  final TextEditingController genderController;

  const GenderDropdownMenu({
    super.key,
    required this.genderController,
  });

  @override
  State<GenderDropdownMenu> createState() => _GenderDropdownMenuState();
}

class _GenderDropdownMenuState extends State<GenderDropdownMenu> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17.0),
      child: Container(
        width: 150,
        child: InputDecorator(
          decoration: InputDecoration(
            label: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'النوع',
                  style: TextStyle(
                    fontSize: 16,
                    color: _selectedGender != null
                        ? Colors.black
                        : Colors.transparent,
                  ),
                ),
              ],
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Gender>(
              value: _selectedGender,
              isExpanded: true,
              alignment: AlignmentDirectional.centerEnd,
              icon: const Icon(Icons.arrow_drop_down),
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (Gender? newValue) {
                setState(() {
                  _selectedGender = newValue;
                  widget.genderController.text = newValue?.name ?? '';
                });
              },
              items: Gender.values
                  // .where((gender) => gender != Gender.none) // Filter out 'none'
                  .map((Gender gender) {
                return DropdownMenuItem<Gender>(
                  value: gender,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    getGenderLabel(gender),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
              hint: const Text(
                'النوع',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
