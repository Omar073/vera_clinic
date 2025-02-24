import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/Visit.dart';

class NewVisitTEC{
  // Visit
  static late TextEditingController visitDateController;
  static late TextEditingController visitDietController;
  static late TextEditingController visitWeightController;
  static late TextEditingController visitBMIController;
  static late TextEditingController visitNotesController;
  static List<Visit> clientVisits = [];

  static void init() {
    visitDateController = TextEditingController();
    visitDietController = TextEditingController();
    visitWeightController = TextEditingController();
    visitBMIController = TextEditingController();
    visitNotesController = TextEditingController();
  }

  static void clear() {
    visitDateController.clear();
    visitDietController.clear();
    visitWeightController.clear();
    visitBMIController.clear();
    visitNotesController.clear();
  }

  static void dispose() {
    visitDateController.dispose();
    visitDietController.dispose();
    visitWeightController.dispose();
    visitBMIController.dispose();
    visitNotesController.dispose();
  }
}