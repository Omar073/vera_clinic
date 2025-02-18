import 'package:flutter/cupertino.dart';

class CheckInPageTEC {
  final TextEditingController visitSubscriptionTypeController = TextEditingController();
  final TextEditingController visitSubscriptionPriceController = TextEditingController();

  void dispose() {
    visitSubscriptionTypeController.dispose();
    visitSubscriptionPriceController.dispose();
  }
}