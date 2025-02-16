import 'package:flutter/cupertino.dart';

late TextEditingController visitDietController;
late TextEditingController visitWeightController;
late TextEditingController visitBMIController;
late TextEditingController visitNotesController;

void initVisitTEC(){
  visitDietController = TextEditingController();
  visitWeightController = TextEditingController();
  visitBMIController = TextEditingController();
  visitNotesController = TextEditingController();
}

void clearVisitTEC(){
  visitDietController.clear();
  visitWeightController.clear();
  visitBMIController.clear();
  visitNotesController.clear();
}

void disposeVisitTEC(){
  visitDietController.dispose();
  visitWeightController.dispose();
  visitBMIController.dispose();
  visitNotesController.dispose();
}

//todo: decide if this way is better or the one in new client registration