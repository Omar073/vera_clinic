import 'package:flutter/cupertino.dart';

class CheckInPageTEC {
  static late TextEditingController visitSubscriptionTypeController;
  static late TextEditingController visitSubscriptionPriceController;
  static late TextEditingController checkInTimeController;
  static bool isAM = true;

  static void init() {
    visitSubscriptionTypeController = TextEditingController();
    visitSubscriptionPriceController = TextEditingController();
    checkInTimeController = TextEditingController();
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
    isAM = now.hour < 12;
  }

  static void clear() {
    visitSubscriptionTypeController.clear();
    visitSubscriptionPriceController.clear();
    checkInTimeController.clear();
  }

  static void dispose() {
    visitSubscriptionTypeController.dispose();
    visitSubscriptionPriceController.dispose();
    checkInTimeController.dispose();
  }
}
