import 'package:flutter/cupertino.dart';

class SingleFollowUpTEC {
  static late TextEditingController singleFollowUpDietController;
  static late TextEditingController singleFollowUpWeightController;
  static late TextEditingController singleFollowUpNotesController;

  static void init() {
    singleFollowUpDietController = TextEditingController();
    singleFollowUpWeightController = TextEditingController();
    singleFollowUpNotesController = TextEditingController();
  }

  static void clear() {
    singleFollowUpDietController.clear();
    singleFollowUpWeightController.clear();
    singleFollowUpNotesController.clear();
  }

  static void dispose() {
    singleFollowUpDietController.dispose();
    singleFollowUpWeightController.dispose();
    singleFollowUpNotesController.dispose();
  }
}
