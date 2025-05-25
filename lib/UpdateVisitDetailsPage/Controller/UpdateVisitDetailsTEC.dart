import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../Core/Model/Classes/Visit.dart';

class UpdateVisitDetailsTEC{
  // Visit
  static late TextEditingController visitDateController;
  static late TextEditingController visitDietController;
  static late TextEditingController visitWeightController;
  static late TextEditingController visitBMIController;
  static late TextEditingController visitNotesController;

  static void init(Visit v) {
    visitDateController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(v.mDate));
    visitDietController = TextEditingController(text: v.mDiet);
    visitWeightController = TextEditingController(text: "${v.mWeight}");
    visitBMIController = TextEditingController(text: "${v.mBMI}");
    visitNotesController = TextEditingController(text: v.mVisitNotes);
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