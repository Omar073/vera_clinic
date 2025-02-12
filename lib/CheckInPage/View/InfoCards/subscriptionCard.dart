import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vera_clinic/NewClientRegistration/View/UsedWidgets/SubscriptionTypeDropdown.dart';

import '../../../Core/Model/Classes/Client.dart';
import '../../Controller/TextEditingControllers2.dart';
import '../../Controller/TextEditingControllers2.dart';
import '../../Controller/UtilityFunctions.dart';

class SubscriptionCard extends StatefulWidget {
  final Client? client;
  const SubscriptionCard(
      {super.key,
      required this.client,});

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: TextField(
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.end,
                    controller: visitSubscriptionPriceController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                    ],
                    decoration: const InputDecoration(
                      hintText: "أدخل سعر الإشتراك",
                      labelText: "السعر",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // DropdownButton<SubscriptionType>(
                //   hint: const Text('اختر نوع الكشف'),
                //   items: SubscriptionType.values.map((SubscriptionType type) {
                //     return DropdownMenuItem<SubscriptionType>(
                //       value: type,
                //       child: Text(getSubscriptionTypeLabel(type)),
                //     );
                //   }).toList(),
                //   onChanged: (SubscriptionType? newValue) {
                //     if (newValue != SubscriptionType.none && newValue != null) {
                //       setState(() {
                //         widget.client?.subscriptionType =
                //             newValue; //todo: displayed value not being updated?
                //       });
                //     }
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SubscriptionTypeDropdown(
                      subscriptionTypeController:
                          visitSubscriptionTypeController),
                ),
                const SizedBox(width: 16),
                // const Text(
                //   ": نوع الكشف",
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
