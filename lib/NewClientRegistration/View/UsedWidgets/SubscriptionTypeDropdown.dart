import 'package:flutter/material.dart';
import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/View/Pages/CheckInPage.dart';

class SubscriptionTypeDropdown extends StatefulWidget {
  final TextEditingController subscriptionTypeController;
  final String? label;
  final double? width;

  const SubscriptionTypeDropdown({
    super.key,
    required this.subscriptionTypeController,
    this.label = 'نوع الكشف',
    this.width,
  });

  @override
  State<SubscriptionTypeDropdown> createState() => _SubscriptionTypeDropdownState();
}

class _SubscriptionTypeDropdownState extends State<SubscriptionTypeDropdown> {
  SubscriptionType? _selectedType;

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
                widget.label ?? 'نوع الكشف',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          // This creates the underline
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          // Optional: customize the underline when focused
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400),
          ),
        ),
        textAlign: TextAlign.right,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<SubscriptionType>(
            value: _selectedType,
            isExpanded: true,
            alignment: AlignmentDirectional.centerEnd,
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20, // Match the font size with other text inputs
            ),
            onChanged: (SubscriptionType? newValue) {
              setState(() {
                _selectedType = newValue;
                widget.subscriptionTypeController.text = newValue?.name ?? '';
              });
            },
            items: SubscriptionType.values
                .where((type) => type != SubscriptionType.none)
                .map((SubscriptionType type) {
              return DropdownMenuItem<SubscriptionType>(
                value: type,
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  getSubscriptionTypeLabel(type),
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
            hint: Text(
              widget.label ?? 'نوع الكشف',
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