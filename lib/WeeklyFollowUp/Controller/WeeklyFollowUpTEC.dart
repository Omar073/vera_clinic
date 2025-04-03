import 'package:flutter/cupertino.dart';

class WeeklyFollowUpTEC {
  static late TextEditingController visitDietController;
  static late TextEditingController visitWeightController;
  static late TextEditingController visitBMIController;
  static late TextEditingController visitNotesController;

  static void init() {
    visitDietController = TextEditingController();
    visitWeightController = TextEditingController();
    visitBMIController = TextEditingController();
    visitNotesController = TextEditingController();
  }

  static void clear() {
    visitDietController.clear();
    visitWeightController.clear();
    visitBMIController.clear();
    visitNotesController.clear();
  }

  static void dispose() {
    visitDietController.dispose();
    visitWeightController.dispose();
    visitBMIController.dispose();
    visitNotesController.dispose();
  }
}
