import 'package:flutter/material.dart';
import 'package:vera_clinic/View/Pages/CheckInPage.dart';
import '../../Model/Classes/Client.dart';

class SubscriptionTypeDropdown extends StatefulWidget {
  final TextEditingController subscriptionTypeController;

  const SubscriptionTypeDropdown(
      {super.key, required this.subscriptionTypeController});

  @override
  State<SubscriptionTypeDropdown> createState() =>
      _SubscriptionTypeDropdownState();
}

class _SubscriptionTypeDropdownState extends State<SubscriptionTypeDropdown> {
  SubscriptionType? _selectedType;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SubscriptionType>(
      value: _selectedType,
      onChanged: (SubscriptionType? newValue) {
        setState(() {
          _selectedType = newValue;
          widget.subscriptionTypeController.text = newValue?.name ?? '';
        });
      },
      items: SubscriptionType.values.map((SubscriptionType type) {
        return DropdownMenuItem<SubscriptionType>(
          value: type,
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(getSubscriptionTypeLabel(type),
                  textAlign: TextAlign.start)),
        );
      }).toList(),
      hint: const Text('نوع الاشتراك',
          textAlign: TextAlign.start), //todo: fix alignment
    );
  }
}

class MyCheckBox extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  const MyCheckBox({super.key, required this.controller, required this.text});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
          setState(() {
            widget.controller.text =
            widget.controller.text == 'true' ? 'false' : 'true';
          });
            },
            child: Icon(
          widget.controller.text == 'true'
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: Colors.green,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            widget.text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
