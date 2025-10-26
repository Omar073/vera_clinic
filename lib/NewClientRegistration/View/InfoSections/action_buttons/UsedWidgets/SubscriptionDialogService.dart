import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/PopUps/InvalidDataTypeSnackBar.dart';
import 'package:vera_clinic/Core/View/PopUps/MySnackBar.dart';
import 'SubscriptionDialogContent.dart';

class SubscriptionDialogService {
  static Future<Map<String, dynamic>?> showSubscriptionDialog({
    required BuildContext context,
    required TextEditingController subscriptionPriceController,
    required TextEditingController subscriptionTypeController,
    required TextEditingController checkInTimeController,
    required bool isAM,
    required Function(bool) onAMChanged,
  }) async {
    // Set default time to current time in 12-hour format
    final now = DateTime.now();
    int hour12 = now.hour;
    if (hour12 == 0) {
      hour12 = 12;
    } else if (hour12 > 12) {
      hour12 = hour12 - 12;
    }
    checkInTimeController.text =
        '$hour12:${now.minute.toString().padLeft(2, '0')}';
    bool currentIsAM = now.hour < 12;

    return await showDialog<Map<String, dynamic>?>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.blue[50]!,
              title: const Text(
                'إدخال بيانات الاشتراك',
                textAlign: TextAlign.end,
              ),
              content: SubscriptionDialogContent(
                subscriptionPriceController: subscriptionPriceController,
                subscriptionTypeController: subscriptionTypeController,
                checkInTimeController: checkInTimeController,
                isAM: currentIsAM,
                setDialogState: (fn) {
                  setDialogState(() {
                    fn();
                    onAMChanged(currentIsAM);
                  });
                },
                onAMChanged: (isAM) {
                  currentIsAM = isAM;
                },
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    try {
                      // Validate time input
                      final timeText = checkInTimeController.text.trim();
                      if (timeText.isEmpty) {
                        showMySnackBar(
                            context, 'يرجى إدخال وقت تسجيل الدخول', Colors.red);
                        return;
                      }

                      // Parse and validate time format (12-hour HH:MM)
                      final timeRegex = RegExp(r'^(0?[1-9]|1[0-2]):[0-5][0-9]$');
                      if (!timeRegex.hasMatch(timeText)) {
                        showMySnackBar(
                            context,
                            'تنسيق الوقت غير صحيح. استخدم HH:MM (1-12)',
                            Colors.red);
                        return;
                      }

                      final double? subscriptionPrice =
                          double.tryParse(subscriptionPriceController.text);

                      if (subscriptionPrice == null) {
                        showInvalidDataTypeSnackBar(context, 'سعر الاشتراك');
                        return;
                      }

                      Navigator.of(dialogContext).pop({
                        'subscriptionPrice': subscriptionPrice,
                        'checkInTime': timeText,
                        'isAM': currentIsAM,
                      });
                    } catch (e) {
                      showInvalidDataTypeSnackBar(context, 'سعر الاشتراك');
                    }
                  },
                  child: const Text(
                    'تأكيد',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(dialogContext).pop(null),
                  child: const Text(
                    'إلغاء',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
