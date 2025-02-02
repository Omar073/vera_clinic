import 'package:flutter/material.dart';
import '../../../Core/Model/Classes/Client.dart';
import '../../Controller/UtilityFunctions.dart';

class GenderDropdownMenu extends StatefulWidget {
  final TextEditingController genderController;
  final String? label;
  final double? width;

  const GenderDropdownMenu({
    super.key,
    required this.genderController,
    this.label = 'النوع',
    this.width,
  });

  @override
  State<GenderDropdownMenu> createState() => _GenderDropdownMenuState();
}

class _GenderDropdownMenuState extends State<GenderDropdownMenu> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 200,
      child: InputDecorator(
        decoration: InputDecoration(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.label ?? 'النوع',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400),
          ),
        ),
        textAlign: TextAlign.right,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Gender>(
            value: _selectedGender,
            isExpanded: true,
            alignment: AlignmentDirectional.centerEnd,
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            onChanged: (Gender? newValue) {
              setState(() {
                _selectedGender = newValue;
                widget.genderController.text = newValue?.name ?? '';
              });
            },
            items: Gender.values
                .where((gender) => gender != Gender.none) // Filter out 'none'
                .map((Gender gender) {
              return DropdownMenuItem<Gender>(
                value: gender,
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  getGenderLabel(gender),
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
            hint: Text(
              widget.label ?? 'النوع',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
