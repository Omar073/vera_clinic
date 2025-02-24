import 'package:flutter/cupertino.dart';

class CheckInPageTEC {
  static late TextEditingController visitSubscriptionTypeController;
  static late TextEditingController visitSubscriptionPriceController;

  static void init() {
    visitSubscriptionTypeController = TextEditingController();
    visitSubscriptionPriceController = TextEditingController();
  }

  static void clear() {
    visitSubscriptionTypeController.clear();
    visitSubscriptionPriceController.clear();
  }

  static void dispose() {
    visitSubscriptionTypeController.dispose();
    visitSubscriptionPriceController.dispose();
  }
}