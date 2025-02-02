import 'package:flutter/material.dart';
import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/View/Pages/CheckInPage.dart';

class SubscriptionTypeDropdown extends StatefulWidget {
  final TextEditingController subscriptionTypeController;

  const SubscriptionTypeDropdown({
    super.key,
    required this.subscriptionTypeController,
  });

  @override
  State<SubscriptionTypeDropdown> createState() =>
      _SubscriptionTypeDropdownState();
}

class _SubscriptionTypeDropdownState extends State<SubscriptionTypeDropdown> {
  SubscriptionType? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17.0),
      child: SizedBox(
        width: 150,
        child: InputDecorator(
          decoration: InputDecoration(
            // Label styling/behavior (matching MyInputField)
            label: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "نوع الكشف",
                  style: TextStyle(
                    fontSize: 16,
                    color: _selectedType != null
                        ? Colors.black // Label color when "floating"
                        : Colors.transparent, // Label color when inside
                  ),
                ),
              ],
            ), // Auto-float when value exists
            // This creates the underline
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SubscriptionType>(
              value: _selectedType,
              isExpanded: true,
              alignment: AlignmentDirectional.centerEnd,
              icon: const Icon(Icons.arrow_drop_down),
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (SubscriptionType? newValue) {
                setState(() {
                  _selectedType = newValue;
                  widget.subscriptionTypeController.text = newValue?.name ?? '';
                });
              },
              items: SubscriptionType.values.map((SubscriptionType type) {
                return DropdownMenuItem<SubscriptionType>(
                  value: type,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    getSubscriptionTypeLabel(type),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                );
              }).toList(),
              hint: const Text(
                'نوع الكشف',
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
