import 'package:flutter/cupertino.dart';

class VisitTEC {
  static late TextEditingController visitDietController;
  static late TextEditingController visitWeightController;
  static late TextEditingController visitBMIController;
  static late TextEditingController visitNotesController;

  static void initVisitTEC() {
    visitDietController = TextEditingController();
    visitWeightController = TextEditingController();
    visitBMIController = TextEditingController();
    visitNotesController = TextEditingController();
  }

  static void clearVisitTEC() {
    visitDietController.clear();
    visitWeightController.clear();
    visitBMIController.clear();
    visitNotesController.clear();
  }

  static void disposeVisitTEC() {
    visitDietController.dispose();
    visitWeightController.dispose();
    visitBMIController.dispose();
    visitNotesController.dispose();
  }
}
