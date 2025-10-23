import 'package:flutter/cupertino.dart';

class CheckInPageTEC {
  static late TextEditingController visitSubscriptionTypeController;
  static late TextEditingController visitSubscriptionPriceController;
  static late TextEditingController checkInTimeController;

  static void init() {
    visitSubscriptionTypeController = TextEditingController();
    visitSubscriptionPriceController = TextEditingController();
    checkInTimeController = TextEditingController();
    // Set default time to current time
    final now = DateTime.now();
    checkInTimeController.text = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
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