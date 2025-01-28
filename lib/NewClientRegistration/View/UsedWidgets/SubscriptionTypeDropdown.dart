import 'package:flutter/material.dart';
import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/View/Pages/CheckInPage.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: DropdownButton<SubscriptionType>(
        value: _selectedType,
        onChanged: (SubscriptionType? newValue) {
          setState(() {
            _selectedType = newValue;
            widget.subscriptionTypeController.text = newValue?.name ?? '';
            // debugPrint(newValue?.name);
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
      ),
    );
  }
}
