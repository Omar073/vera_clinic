import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyInputField.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../../Core/View/Reusable widgets/SubscriptionTypeDropdown.dart';

class SubscriptionCard extends StatefulWidget {
  final TextEditingController visitSubscriptionTypeController;
  final TextEditingController visitSubscriptionPriceController;
  final Client? client;

  const SubscriptionCard({
    super.key,
    required this.client,
    required this.visitSubscriptionTypeController,
    required this.visitSubscriptionPriceController,
  });


  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'معلومات الإشتراك',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: MyInputField(
                      myController: widget.visitSubscriptionPriceController,
                      hint: '',
                      label: 'السعر'),
                ),
                const SizedBox(width: 24),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: SubscriptionTypeDropdown(
                      subscriptionTypeController:
                      widget.visitSubscriptionTypeController),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
