import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  void initState() {
    super.initState();
    // Format the initial value of the controller if it already has a value
    if (widget.textEditingController.text.isNotEmpty) {
      DateTime? initialDate = DateTime.tryParse(widget.textEditingController.text);
      if (initialDate != null) {
        widget.textEditingController.text = DateFormat('yyyy-MM-dd').format(initialDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Colors.blueAccent, // Selected date color
                  onPrimary: Colors.white, // Text color for selected date
                  onSurface: Colors.black, // Text color for unselected dates
                ),
                dialogTheme: const DialogTheme(
                  backgroundColor: Colors.white,
                ),
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          setState(() {
            // Format the date before assigning it to the controller
            widget.textEditingController.text =
                DateFormat('yyyy-MM-dd').format(pickedDate);
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