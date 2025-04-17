import 'package:flutter/material.dart';
import '../../../CheckInPage/Controller/UtilityFunctions.dart';
import '../../Model/Classes/Client.dart';

class SubscriptionTypeDropdown extends StatefulWidget {
  final TextEditingController subscriptionTypeController;
  SubscriptionType? selectedType;

  SubscriptionTypeDropdown({
    super.key,
    required this.subscriptionTypeController,
    this.selectedType,
  });

  @override
  State<SubscriptionTypeDropdown> createState() =>
      _SubscriptionTypeDropdownState();
}

class _SubscriptionTypeDropdownState extends State<SubscriptionTypeDropdown> {

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
                    color: widget.selectedType != null
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
              value: widget.selectedType,
              isExpanded: true,
              alignment: AlignmentDirectional.centerEnd,
              icon: const Icon(Icons.arrow_drop_down),
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (SubscriptionType? newValue) {
                setState(() {
                  widget.selectedType = newValue;
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
