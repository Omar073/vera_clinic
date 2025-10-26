import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/MyInputField.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/SubscriptionTypeDropdown.dart';

class SubscriptionDialogContent extends StatelessWidget {
  final TextEditingController subscriptionPriceController;
  final TextEditingController subscriptionTypeController;
  final TextEditingController checkInTimeController;
  final bool isAM;
  final StateSetter setDialogState;
  final Function(bool) onAMChanged;

  const SubscriptionDialogContent({
    super.key,
    required this.subscriptionPriceController,
    required this.subscriptionTypeController,
    required this.checkInTimeController,
    required this.isAM,
    required this.setDialogState,
    required this.onAMChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        MyInputField(
            myController: subscriptionPriceController,
            hint: 'أدخل سعر الاشتراك',
            label: 'سعر الاشتراك'),
        const SizedBox(height: 16),
        SubscriptionTypeDropdown(
            subscriptionTypeController: subscriptionTypeController),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: MyInputField(
                myController: checkInTimeController,
                hint: "HH:MM",
                label: "وقت تسجيل الدخول",
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setDialogState(() {
                      onAMChanged(true);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAM ? Colors.blueAccent : Colors.white,
                    foregroundColor: isAM ? Colors.white : Colors.grey[600],
                    side: BorderSide(
                      color: isAM ? Colors.blueAccent : Colors.grey[400]!,
                      width: isAM ? 2 : 1,
                    ),
                    elevation: isAM ? 4 : 1,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: const Size(60, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'صباحاً', 
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isAM ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    setDialogState(() {
                      onAMChanged(false);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isAM ? Colors.blueAccent : Colors.white,
                    foregroundColor: !isAM ? Colors.white : Colors.grey[600],
                    side: BorderSide(
                      color: !isAM ? Colors.blueAccent : Colors.grey[400]!,
                      width: !isAM ? 2 : 1,
                    ),
                    elevation: !isAM ? 4 : 1,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: const Size(60, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'مساءً', 
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: !isAM ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
