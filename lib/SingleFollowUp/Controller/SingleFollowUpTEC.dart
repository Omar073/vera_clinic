import 'package:flutter/cupertino.dart';

class SingleFollowUpTEC {
  static late TextEditingController singleFollowUpDietController;
  static late TextEditingController singleFollowUpWeightController;
  static late TextEditingController singleFollowUpBMIController;
  static late TextEditingController singleFollowUpNotesController;

  static void init() {
    singleFollowUpDietController = TextEditingController();
    singleFollowUpWeightController = TextEditingController();
    singleFollowUpBMIController = TextEditingController();
    singleFollowUpNotesController = TextEditingController();
  }

  static void clear() {
    singleFollowUpDietController.clear();
    singleFollowUpWeightController.clear();
    singleFollowUpBMIController.clear();
    singleFollowUpNotesController.clear();
  }

  static void dispose() {
    singleFollowUpDietController.dispose();
    singleFollowUpWeightController.dispose();
    singleFollowUpBMIController.dispose();
    singleFollowUpNotesController.dispose();
  }
}
