import 'package:flutter/material.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  const DatePicker(
      {super.key, required this.textEditingController, required this.label});

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
            widget.textEditingController.text =
                "${pickedDate.toLocal()}".split(' ')[0];
          });
        }
      },
      child: AbsorbPointer(
        child: MyInputField(
          myController: widget.textEditingController,
          hint: '',
          label: widget.label,
        ),
      ),
    );
  }
}
