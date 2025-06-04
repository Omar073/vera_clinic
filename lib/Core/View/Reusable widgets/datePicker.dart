import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart'; // Standard import
import 'package:vera_clinic/Core/View/PopUps/MySnackBar.dart';

import '../../../Core/View/Reusable widgets/MyInputField.dart';

// Helper class to return multiple values from validation
class _ValidationResult {
  final int day;
  final int month;
  final int year;

  _ValidationResult(
      {required this.day, required this.month, required this.year});
}

class DatePicker extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  final String hint;

  const DatePicker({
    super.key,
    required this.textEditingController,
    required this.label,
    this.hint = 'اختر التاريخ',
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String _displayText = '';

  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateDisplayFromController();
    widget.textEditingController.addListener(_updateDisplayFromController);
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_updateDisplayFromController);
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _updateDisplayFromController() {
    if (mounted) {
      String textToShow = widget.textEditingController.text;
      if (textToShow.isNotEmpty) {
        try {
          DateFormat('dd/MM/yyyy').parseStrict(textToShow);
        } catch (e) {
          textToShow =
              ''; // Not a valid date in the expected format, show hint instead
        }
      }
      setState(() {
        _displayText = textToShow;
      });
    }
  }

  // Helper method for validating basic input fields
  _ValidationResult? _validateDialogInputFields(
    BuildContext dialogContext,
    String dayStr,
    String monthStr,
    String yearStr,
  ) {
    if (dayStr.isEmpty || monthStr.isEmpty || yearStr.isEmpty) {
      showMySnackBar(dialogContext, 'يرجى ملء جميع الحقول', Colors.red);
      return null;
    }

    final int? day = int.tryParse(dayStr);
    final int? month = int.tryParse(monthStr);

    if (day == null || day < 1 || day > 31) {
      showMySnackBar(dialogContext,
          'اليوم المدخل غير صالح (يجب أن يكون بين 1 و 31)', Colors.red);
      return null;
    }
    if (month == null || month < 1 || month > 12) {
      showMySnackBar(dialogContext,
          'الشهر المدخل غير صالح (يجب أن يكون بين 1 و 12)', Colors.red);
      return null;
    }

    // Directly call the imported top-level function from UtilityFunctions.dart
    if (!validateYear(dialogContext, 'السنة', yearStr)) {
      // validateBirthYear shows its own snackbar
      return null;
    }

    final int? year = int.tryParse(yearStr);
    if (year == null) {
      showMySnackBar(dialogContext, 'السنة المدخلة غير صالحة', Colors.red);
      return null;
    }
    return _ValidationResult(day: day, month: month, year: year);
  }

  // Helper method for validating the constructed DateTime object
  DateTime? _validateConstructedDateLogic(
    BuildContext dialogContext,
    int year,
    int month,
    int day,
  ) {
    try {
      final newDate = DateTime(year, month, day);
      if (newDate.day != day ||
          newDate.month != month ||
          newDate.year != year) {
        showMySnackBar(dialogContext,
            'التاريخ المدخل غير صالح (مثال: يوم 31 في شهر فبراير)', Colors.red);
        return null;
      }

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      if (newDate.isAfter(today)) {
        showMySnackBar(
            dialogContext, 'لا يمكن اختيار تاريخ في المستقبل', Colors.red);
        return null;
      }
      return newDate;
    } catch (e) {
      showMySnackBar(
          dialogContext, 'التاريخ المدخل بشكل عام غير صالح', Colors.red);
      return null;
    }
  }

  Future<void> _showDatePickerDialog(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    String initialDay = currentDate.day.toString();
    String initialMonth = currentDate.month.toString();
    String initialYear = currentDate.year.toString();

    if (widget.textEditingController.text.isNotEmpty) {
      try {
        DateTime parsedFromController = DateFormat('dd/MM/yyyy')
            .parseStrict(widget.textEditingController.text);
        initialDay = parsedFromController.day.toString();
        initialMonth = parsedFromController.month.toString();
        initialYear = parsedFromController.year.toString();
      } catch (_) {
        // Parsing failed, use current date parts as initialized
      }
    }

    _dayController.text = initialDay;
    _monthController.text = initialMonth;
    _yearController.text = initialYear;

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.blue[50]!,
          title: const Text('اختر التاريخ',
              textAlign: TextAlign.end), // Select Date
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyInputField(
                    myController: _dayController,
                    label: 'اليوم',
                    hint: '1-31'), // Day
                const SizedBox(height: 8),
                MyInputField(
                    myController: _monthController,
                    label: 'الشهر',
                    hint: '1-12'), // Month
                const SizedBox(height: 8),
                MyInputField(
                    myController: _yearController,
                    label: 'السنة',
                    hint: '1990'), // Year
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: const Text('تأكيد',
                  style: TextStyle(color: Colors.blueAccent)), // Confirm
              onPressed: () {
                final String dayStr = _dayController.text.trim();
                final String monthStr = _monthController.text.trim();
                final String yearStr = _yearController.text.trim();

                final validationResult = _validateDialogInputFields(
                    dialogContext, dayStr, monthStr, yearStr);

                if (validationResult == null) {
                  return; // Validation failed, snackbar already shown
                }

                final DateTime? newDate = _validateConstructedDateLogic(
                  dialogContext,
                  validationResult.year,
                  validationResult.month,
                  validationResult.day,
                );

                if (newDate == null) {
                  return; // Validation failed, snackbar already shown
                }

                widget.textEditingController.text =
                    DateFormat('dd/MM/yyyy').format(newDate);
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('خروج', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentDisplay = _displayText.isEmpty ? widget.hint : _displayText;
    bool isHintDisplayed = _displayText.isEmpty;

    TextStyle? displayTextStyle;
    if (isHintDisplayed) {
      // Style for the hint text when it's acting as the display
      displayTextStyle = const TextStyle(
          fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400);
    } else {
      displayTextStyle = null;
    }

    return GestureDetector(
      onTap: () {
        _showDatePickerDialog(context);
      },
      child: AbsorbPointer(
        child: MyInputField(
          myController:
              TextEditingController(text: currentDisplay), // Display purposes
          label: widget.label,
          hint:
              '',
          textStyle: displayTextStyle,
        ),
      ),
    );
  }
}
